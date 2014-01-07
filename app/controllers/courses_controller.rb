class CoursesController < ApplicationController
  autocomplete :golf_facility, :company, :extra_data => [:location_state], :full => true, :display_value => :display_course
  autocomplete :college, :name, :full => true

  def find
    # Set this instance variable to decide what view to render
    @course_owner_search = params[:course_owner_search]

    search_filter = {}
    if @course_owner_search
      search_filter[:filter] = "exclude_next_rated"
    elsif params[:nextgen_rated] && params[:nextgen_rated] == "1"
      search_filter[:filter] = "show_only_next_rated"
    end

    if params[:search].present?
      @term = params[:search]
      if zipcode?(@term)
        @term = @term.split("-")[0]
        @results = zipcode_search(@term, search_filter)
      else
        @results = name_search(@term, search_filter)
      end
      @course_markers = build_course_markers(@results)
    end

    respond_to do |format|
      format.js { render(:find) }
      format.html
    end
  end

  def find_by_college
    if params[:search].present?
      @term = params[:search]
      college = College.where(:name => @term).first
      return [] unless college
      search_filter = {}
      if params[:nextgen_rated] && params[:nextgen_rated] == "1"
        search_filter[:filter] = "show_only_next_rated"
      end
      @results = courses_around_location(college, 40, params[:page], search_filter)
    end

    @course_markers = build_course_markers(@results)
    @course_markers += build_college_markers([college])

    respond_to do |format|
      format.js { render(:find) }
      format.html
    end
  end

  def find_by_state
    if params[:state_id].present?
      @term = params[:state_id]
      if params[:nextgen_rated] && params[:nextgen_rated] == "1"
        @results = GolfFacility.joins(:courses).where("courses.nextgen_rate_desc is not null and golf_facilities.location_state=?", @term).includes(:courses).page params[:page]
      else
        @results = GolfFacility.where(:location_state => @term).includes(:courses).page(params[:page])
      end
    end

    @course_markers = build_course_markers(@results)

    respond_to do |format|
      format.js { render(:find) }
      format.html
    end
  end

  def zipcode_search(term, search_filter)
    @zip = ZipCode.for(term)
    unless @zip
      @error = "Invalid zipcode"
      return []
    end
    courses_around_location(@zip, 40, params[:page], search_filter)
  end

  def name_search(term, search_filter)
    name, state = term.split(",")
    if search_filter[:filter] == "show_only_next_rated"
      if state
        GolfFacility.joins(:courses).where("courses.nextgen_rate_desc is not null and golf_facilities.company ilike ? and state=?", "%#{name}%", state.strip).page params[:page]
      else
        GolfFacility.joins(:courses).where("courses.nextgen_rate_desc is not null and golf_facilities.company ilike ?", "%#{name}%").page params[:page]
      end
    elsif search_filter[:filter] == "exclude_next_rated"
      if state
        GolfFacility.joins(:courses).where("courses.nextgen_rate_desc is null and golf_facilities.company ilike ? and state=?", "%#{name}%", state.strip).page params[:page]
      else
        GolfFacility.joins(:courses).where("courses.nextgen_rate_desc is null and golf_facilities.company ilike ?", "%#{name}%").page params[:page]
      end
    else
      if state
        GolfFacility.where("company ilike ? and state=?", "%#{name}%", state.strip).includes(:courses).page(params[:page])
      else
        GolfFacility.where("company ilike ?", "%#{name}%").includes(:courses).page(params[:page])
      end
    end
  end

  def suggest
    @id = params[:id]
    @email = params[:email]
    begin
      CourseSuggestion.create(course_id: @id, email_address: @email)
    rescue
      logger.error "Failed to save suggestion"
      # Do nothing
    end
  end

  private

  def courses_around_location(location, radius, page_number, search_filter)
    if search_filter[:filter] == "show_only_next_rated"
      results = GolfFacility.within(40, origin: [location.lat, location.lon]).joins(:courses).where("courses.nextgen_rate_desc is not null").includes(:courses).page page_number
    elsif search_filter[:filter] == "exclude_next_rated"
      results = GolfFacility.within(40, origin: [location.lat, location.lon]).joins(:courses).where("courses.nextgen_rate_desc is null").includes(:courses).page page_number
    else
      facilities = GolfFacility.within(40, origin: [location.lat, location.lon]).includes(:courses).sort_by {|s| s.distance_to(location)}
      results = Kaminari.paginate_array(facilities).page page_number 
    end
    results
  end

  def zipcode?(term)
    zip = term.split('-')[0]
    !!(zip =~ /^[-+]?[0-9]+$/)
  end
end

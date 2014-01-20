class ProfileController < AppController
  skip_before_action :redirect_if_profile_incomplete

  def show
    if current_user.is_course_manager?
      redirect_to course_manager_index_path and return
    end

    if params[:id] == "my_profile" || params[:id] == nil
      @user_profile = current_user.user_profile || UserProfile.new
      @user = current_user
    else
      @user = User.where(:id => params[:id]).first
      if @user
        @user_profile = @user.user_profile
      end
    end
  end

  def add_user
    if request.post?
      user = User.invite!(email: params[:email])
      if user.errors.present?
        if user.errors.full_messages.include?("Email is invalid") || user.errors.full_messages.include?("Email can't be blank")
          @error = "Please enter a valid email address"
        elsif user.errors.full_messages.include?("Email has already been taken")
          @error = "Member with that email address already exists"
        else
          @error = "Oops! Something went wrong, please try again in few minutes"
        end
        flash[:alert] = @error
        if team = Team.find(params[:team_id])
          redirect_to team_path(team)
        end
      else
        role_type = RoleType.where(id: params[:role_type_id]).first
        user.add_role role_type.code
        if team = Team.find(params[:team_id])
          user.team = team
          user.save
          flash[:notice] = "Team member added successfully"
          redirect_to team_path(team)
        else
          flash[:notice] = "Successfully sent the invitation!"
        end
      end
    end
  end

  def create
    @user = current_user
    @user_profile = UserProfile.new(user_profile_params)
    @user_profile.user_id = current_user.id
    if @user_profile.save
      flash[:notice] = "Your profile was created successfully" if @user_profile.save
      redirect_to profile_path(@user_profile)
    else
      flash[:notice] = "Something went wrong updating your profile"
      render :show
    end
  end

  def update
    @user_profile = User.find(params[:id]).user_profile
    if @user_profile.user_id != current_user.id
      redirect_to root_path and return
    end
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to profile_path(@user_profile.user_id), notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user_profile = User.find(params[:id]).user_profile
    if @user_profile.user_id != current_user.id
      redirect_to root_path and return
    end
  end

  private

  def user_profile_params
    my_params = params.require(:user_profile).permit(:first_name, :last_name, :university, :graduation_year, :hometown, :major, :phone, :gender, :birthdate, :avatar, :remove_avatar)
  end

end

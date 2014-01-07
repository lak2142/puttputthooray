class AdminController < AppController
  before_action :admin_only, :except => [:stop_shadow_user]
  skip_before_action :redirect_if_profile_incomplete, :only => [:stop_shadow_user] 
  def members
    @users = User.page(params[:page])
  end

  def change_role
    role_id = params[:user][:role_type_id]
    user = User.find(params[:id])
    user.update_role(role_id)
    respond_to do |format|
      format.json { render :json => {"result" => "OK"}.to_json}
    end
  end

  def search
    if params[:email].blank?
      users = []
    else
      users = User.where(:email => params[:email])
    end
    @users = Kaminari.paginate_array(users).page(params[:page])
    render :members
  end

  def shadow_user
    session[:original_user_id] = current_user.id
    user = User.find(params[:id])
    sign_in(:user, User.find(params[:id]), { :bypass => true })
    redirect_to root_path
  end

  def stop_shadow_user
    sign_in(:user, User.find(session[:original_user_id]), { :bypass => true })
    flash[:notice] = "Successfully stopped shadowing"
    redirect_to members_admin_index_path
  end

end


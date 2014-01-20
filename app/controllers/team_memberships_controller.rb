class TeamMembershipsController < AppController 

  def update
    member = User.find(params[:member_id])
    member.team = nil

    if member.save
      flash[:notice] = "Team member was successfully removed"
    else
      flash[:notice] = "Something went wrong, please try again"
    end
    redirect_to team_path(current_user.team)
  end

end
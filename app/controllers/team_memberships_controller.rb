class TeamMembershipsController < AppController 

  def update
    member = User.find(params[:member_id])
    @team = member.team
    member.team = nil

    if member.save
      flash[:notice] = "Team member was successfully removed"
    else
      flash[:notice] = "Something went wrong, please try again"
    end
    redirect_to team_path(@team)
  end

end

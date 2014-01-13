class TeamsController < ApplicationController
  def index

  end

  def new
    @team = Team.new
  end

  def create
    user = User.invite!(email: params[:team][:email])
    user.add_role RoleType.PRESIDENT.code

    @team = Team.new(team_params)

    if @team.save
      user.team = @team
      user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:college_id, :email, :team_name)
  end
end

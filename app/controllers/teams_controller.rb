class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    user = User.invite!(email: params[:team][:email])
    user.add_role RoleType.PRESIDENT.code

    @team = Team.new(team_params)

    if @team.valid? && user.valid?
      user.team = @team
      user.save
      redirect_to admin_index_path, notice: 'Team successfully added!'
    else
      @team.errors[:email] = "Must provide valid email for President" unless user.valid?
      render :new
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team)
    else
      render :edit
    end
  end

  private

  def team_params
    params.require(:team).permit(:college_id, :email, :team_name, :team_logo)
  end
end

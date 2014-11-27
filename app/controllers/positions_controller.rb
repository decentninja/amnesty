class PositionsController < IndexController

  def show
    position = Position.find(params[:id])
    set_models([position], [], position.roles, position.privileges, Position)
  end

end

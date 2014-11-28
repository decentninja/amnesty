class PositionsController < IndexController

  def show
    position = Position.find(params[:id])
    set_models(
      positions: [position],
      students: position.students,
      roles: position.roles,
      privileges: position.privileges,
      top: Position
    )
  end

end

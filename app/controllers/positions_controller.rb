class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :add_role, :remove_role]

  def index
    @positions = Position.all
  end

  def show
  end

  def add_role
    role = Role.where("name like ?", params[:role_name])[0]
    if role == nil
      @position.errors.add(:role_name, 'does not exist. Go to the roles tab and create it!')
    else
      if @position.roles.include?(role)
        @position.errors.add(:role_name, 'is already added.')
      else
        @position.roles << role
      end
    end
    render 'show'
  end

  def remove_role
    role = Role.find(params[:role_id])
    role.positions.delete(@position)
    render 'show'
  end

  private
  def set_position
    @position = Position.find(params[:id])
  end

end

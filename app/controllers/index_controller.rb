class IndexController < ApplicationController

	def index
		set_models()
	end

  def update
  end

  def create_role
  end

  def create_privilege
  end

private
	def set_models(positions: [], students: [], roles: [], privileges: [], top: ActiveRecord::Base)
		@positions = mark_relevant_models(positions, Position, Position == top)
		@students = mark_relevant_models(students, Student, Student == top)
		@roles = mark_relevant_models(roles, Role, Role == top)
		@privileges = mark_relevant_models(privileges, Privilege, Privilege == top)
	end

  def mark_relevant_models(relevant, model, top)
    {
      marked: relevant,
      rest: model.where.not(id: relevant.map(&:id)),
      columns: model.column_names,
      top: top
    }
  end
end

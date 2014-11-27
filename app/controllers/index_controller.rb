class IndexController < ApplicationController

	def index
		@students = Student.all
		@privileges = Privilege.all
		@roles = Role.all
	end

  def update
  end

  def create_role
  end

  def create_privilege
  end
end

class RolesController < ApplicationController
  before_action :set_role, only: [
                             :show,
                             :edit,
                             :update,
                             :destroy,
                             :add_student,
                             :remove_student,
                             :add_privilege,
                             :remove_privilege,
                             :add_position,
                             :remove_position
                         ]

  # GET /roles
  # GET /roles.json
  def index
    @role = Role.new
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    @role.save

    respond_to do |format|
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render action: 'show', status: :created, location: @role }
    end
  end

  def add_student
    if !params[:student_name].include?(' ')
      params[:student_name] += ' '
    end
    student = Student.where("(first_name || ' ' || last_name) like ?", params[:student_name])[0]
    if student == nil
      @role.errors.add(:student_name, 'does not exist. Go to the roles tab and create it!')
    else
      if student.roles.include?(@role)
        @role.errors.add(:student_name, 'is already added.')
      else
        @role.assign(student, params[:expire])
      end
    end
    render 'show'
  end

  def remove_student
    student = Student.find(params[:student_id])
    student.roles.delete(@role)
    render 'show'
  end

  def add_privilege
    privilege = Privilege.where("name like ?", params[:priv_name])[0]
    if privilege == nil
      @role.errors.add(:student_name, 'does not exist. Go to the students tab!')
    else
      if @role.privileges.include?(@role)
        @role.errors.add(:student_name, 'is already added.')
      else
        privilege.assign(@role, params[:expire])
      end
    end
    render 'show'
  end

  def remove_privilege
    privilege = Privilege.find(params[:privilege_id])
    privilege.roles.delete(@role)
    render 'show'
  end

  def add_position
    position = Position.where("name like ?", params[:position_name])[0]
    if position == nil
      @role.errors.add(:position_name, 'does not exist!')
    else
      if @role.positions.include?(@role)
        @role.errors.add(:position_name, 'is already added.')
      else
        position.roles << @role
      end
    end
    render 'show'
  end

  def remove_position
    position = Position.find(params[:position_id])
    position.roles.delete(@role)
    render 'show'
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    @role = Role.find params[:id]
    @role.update_attributes(role_params)
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role = Role.find params[:id]
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :default_term_end)
    end
end

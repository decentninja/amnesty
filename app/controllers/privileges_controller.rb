class PrivilegesController < ApplicationController
  before_action :set_privilege, only: [:show, :edit, :update, :destroy, :add_role, :remove_role, :add_student, :remove_student]

  # GET /privileges
  # GET /privileges.json
  def index
    @privileges = Privilege.all
    @privilege = Privilege.new
  end

  # GET /privileges/1
  # GET /privileges/1.json
  def show
  end

  def add_role
    role = Role.where("name like ?", params[:role_name])[0]
    if role == nil
      @privilege.errors.add(:role_name, 'does not exist. Go to the roles tab and create it!')
    else
      if @privilege.roles.include?(role)
        @privilege.errors.add(:role_name, 'is already added.')
      else
        @privilege.assign(role, params[:expire])
      end
    end
    render 'show'
  end

  def remove_role
    role = Role.find(params[:role_id])
    @privilege.roles.delete(role)
    render 'show'
  end

  def add_student
    if !params[:student_name].include?(' ')
      params[:student_name] += ' '
    end
    student = Student.where("(first_name || ' ' || last_name) like ?", params[:student_name])[0]
    if student == nil
      @privilege.errors.add(:student_name, 'does not exist. Go to the roles tab and create it!')
    else
      if student.roles.include?(@privilege)
        @privilege.errors.add(:student_name, 'is already added.')
      else
        @privilege.assign(student, params[:expire])
      end
    end
    render 'show'
  end

  def remove_student
    student = Student.find(params[:student_id])
    @privilege.students.delete(student)
    render 'show'
  end

  # POST /privileges
  # POST /privileges.json
  def create
    @privilege = Privilege.new(privilege_params)
    @privilege.save
    respond_to do |format|
      format.html { redirect_to @privilege, notice: 'Privilege was successfully created.' }
      format.json { render action: 'show', status: :created, location: @privilege }
    end
  end

  # PATCH/PUT /privileges/1
  # PATCH/PUT /privileges/1.json
  def update
    respond_to do |format|
      if @privilege.update(privilege_params)
        format.html { redirect_to @privilege, notice: 'Privilege was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @privilege.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privileges/1
  # DELETE /privileges/1.json
  def destroy
    @privilege.destroy
    respond_to do |format|
      format.html { redirect_to privileges_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_privilege
    @privilege = Privilege.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def privilege_params
    params.require(:privilege).permit(:name)
  end
end

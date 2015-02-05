class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy, :add_role, :remove_role, :add_privilege, :remove_privilege]

  # GET /students
  # GET /students.json
  def index
    @student = Student.new
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  def add_role
    role = Role.where("name like ?", params[:role_name])[0]
    if role == nil
      @student.errors.add(:role_name, 'does not exist. Go to the roles tab and create it!')
    else
      if @student.roles.include?(role)
        @student.errors.add(:role_name, 'is already added.')
      else
        role.assign(@student, params[:expire])
      end
    end
    render 'show'
  end

  def remove_role
    role = Role.find(params[:role_id])
    @student.roles.delete(role)
    render 'show'
  end

  def add_privilege
    priv = Privilege.where("name like ?", params[:priv_name])[0]
    if priv == nil
      @student.errors.add(:priv_name, 'does not exist. Go to the privileges tab and create it!')
    else
      if @student.privileges.include?(priv)
        @student.errors.add(:priv_name, 'is already added.')
      else
        priv.assign(@student, params[:expire])
      end
    end
    render 'show'
  end

  def remove_privilege
    priv = Privilege.find(params[:role_id])
    @student.privileges.delete(priv)
    render 'show'
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.create(student_params)

    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @student.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @student = Student.find_by_ugid(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :ugid)
    end
end

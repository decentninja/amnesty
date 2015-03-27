class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy, :add_role, :remove_role, :add_privilege, :remove_privilege]
  skip_before_filter :authenticate!, :only => :have_privilege

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

  # GET /student/
  def have_privilege
    begin
      if params[:name]
        student = Student.where("(first_name || ' ' || last_name) like ?", params[:name])[0]
      elsif params[:ugid]
        student = Student.find_by_ugid(params[:ugid])
      elsif params[:id]
        student = Student.find(params[:id])
      end
      privilege = Privilege.find_by_name(params[:privilege])
    rescue ActiveRecord::RecordNotFound
    end
    if not (params[:ugid] and params[:name] and params[:id] and params[:privilege])
      render text: 'You will need to specify the parameters to this route as http GET parameters. See http://localhost:3000/static_pages/apidoc for more information.', status: 406
    elsif student.nil?
      render text: "Student #{params[:name] or params[:ugid] or params[:id]} was not found.", status: 404
    elsif privilege.nil?
      render text: "Privilege #{params[:privilege]} was not found.", status: 404
    elsif student.current_privileges.include?(privilege)
      render text: "#{student.first_name} #{student.last_name} have Amnesty's permission to #{params[:privilege]}!", status: 200
    else
      render text: "#{student.first_name} #{student.last_name} does not have Amnesty's permission to #{params[:privilege]}!", status: 550
    end
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
    @student = Student.new(student_params)
    @student.save

    respond_to do |format|
      format.html { redirect_to @student, notice: 'Student was successfully created.' }
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

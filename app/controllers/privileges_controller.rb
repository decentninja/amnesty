class PrivilegesController < ApplicationController
  before_action :set_privilege, only: [:show, :edit, :update, :destroy]

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

  end

  def remove_role

  end

  def add_student

  end

  def remove_student

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

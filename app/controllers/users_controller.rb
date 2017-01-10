class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :validate_user, :only => :edit
  # GET /users
  # GET /users.json
  def index
    @tags = Tag.all
    if params[:tag]
        @users = User.tagged_with(params[:tag])
    else
        @users = User.search(params[:search])
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
      @tags = Tag.all
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :title, :description, :role,  :linkedin_url, :picture, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end


     def validate_user
      redirect_to user_path unless current_user.id.to_s == params[:id]
     end
end

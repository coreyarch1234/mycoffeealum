class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :profile_filled, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :validate_user, :only => :edit

  def show
  end

  def info
  end

  def blogs
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
        redirect_to blog_path_url
    else
        respond_to do |format|
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
        @user = current_user
    end

    def profile_filled
        if current_user
            if current_user.description == ""
                flash[:notice] = "Fill in your profile!"
            end
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :title, :description, :role,  :linkedin_url, :picture, :location)
    end

   def validate_user
    redirect_to user_path unless current_user.id.to_s == params[:id]
   end
end

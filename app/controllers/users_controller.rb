class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :profile_filled, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :validate_user, :only => :edit
  # GET /users
  # GET /users.json

  def index
    set_tags
    set_user_type
    set_tags_for_users
    if params[:tag]
        @users = User.all_except(current_user).tagged_with(params[:tag])
    else
        @users = User.all_except(current_user).search(params[:search])
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

    def set_tags
         @tags = Tag.all
         @tag_array = Array.new
         @tags.each do |tag|
             @tag_array.append(tag.name)
         end
    end

    def set_user_type
         if current_user.role == "student" || current_user.role == "alumni"
              @users = User.role("mentor") + User.role("student") + User.role("alumni")

          elsif current_user.role == "mentor"
              @users = User.role("student")
          else
             @users = User.all
         end
    end


    def set_tags_for_users
         @users.each do |user|
             @tag_array_select = Array.new
             user.tag_list.each do |tag|
                 @tag_array_select.append(tag)
             end
         end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
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
      params.require(:user).permit(:first_name, :last_name, :title, :description, :role,  :linkedin_url, :picture, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end

   def validate_user
    redirect_to user_path unless current_user.id.to_s == params[:id]
   end
end

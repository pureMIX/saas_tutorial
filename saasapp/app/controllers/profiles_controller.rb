class ProfilesController < ApplicationController
 
  # Get to /users/:user_id/profile/new
  def new 
    #Render blank profile details form
    @profile = Profile.new
  end
  # Post to /users/:user_id/profile
  def create
    #Ensure that user exists
    @user = User.find(params[:user_id])
    #Create profile link to the user
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path(id: params[:user_id])
    else
      render action :new
    end
  end
  # Get to /users/:user_id/profile/edit
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  # PATCH/POST to /users/:user_id/profile
  def update
    # Retrieve user from database
    @user = User.find(params[:user_id])
    # Retrieve profile related to the user
    @profile = @user.profile
    # Update profile of the user by mass assignment
    if @profile.update_attributes(profile_params)
      flash[:success]= "Profile updated!"
      #Redirect user to profile page
      redirect_to user_path(id: params[:user_id])
    else
      flash[:error]= "Profile failed to load!!"
      render action: :edit
    end
  end
  
  private 
    # If you collect data from form then 
    # we need to use strong parameters 
    # and whitelist form fields
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end
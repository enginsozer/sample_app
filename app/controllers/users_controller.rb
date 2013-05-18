class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy] #Applies only to edit and update actions
  before_filter :correct_user,   only: [:edit, :update] #Users can only update their own profile
  before_filter :admin_user,     only: :destroy #Only admin can call destroy method

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    if !signed_in?
      @user = User.new
    else
      flash[:error] = "You are already signed in!"
      redirect_to root_path
    end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def create
    if !signed_in?
      @user = User.new(params[:user])
      if @user.save
        # Handle a successful save.
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    else
      flash[:error] = "You are already signed in!"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if !@user.admin? && !current_user?(@user)
      @user.destroy
      flash[:success] = "User is successfully destroyed!"
      redirect_to users_url
    else
      flash[:error] = "Admin can not delete itself!"
      redirect_to users_url
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end

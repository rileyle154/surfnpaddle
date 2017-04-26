class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_self, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # render text: params.inspect
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup(@user).deliver
      session[:user_id] = @user.id
      redirect_to @user
      # redirect_to "/users/#{@user.id}"
      # url_for @user
      #   - Check class name (User)
      #   - "#{class_name}_path(id: thing.id)"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :bio, :avatar, :password, :email)
  end

  def require_self
    unless @user == current_user
      flash[:danger] = "This is not you."
      redirect_to :root
    end
  end

end

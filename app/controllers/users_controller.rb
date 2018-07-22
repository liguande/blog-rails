class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    yzm = params[:_rucaptcha]
    if verify_rucaptcha?(yzm)
      if @user.save
        redirect_to :root
      else
        render :new
      end
    else
    	@user.errors.add(:captcha,"error")
      render :new
    end
  end

  def sign_in
    @user = User.new
  end

  def sign_in_session
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_username(username)
    if @user
      if @user.authenticate(password)
        session[:user_id] = @user.id
        redirect_to :root
      else
        @user.errors.add(:password,"error!")
        render :sign_in
      end
    else
      @user = User.new
      @user.errors.add(:username,"Don't exsist!")
      render :sign_in
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  def show
    @user = User.find(params[:id])
  end

  private
  	def user_params
  		params.require(:user).permit(:username,:password,:password_confirmation)
  	end
end

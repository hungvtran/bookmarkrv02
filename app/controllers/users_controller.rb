class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def update
  	render :text => "file has been  uploaded"
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

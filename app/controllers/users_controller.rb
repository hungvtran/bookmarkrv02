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
      log_in @user
      flash[:success] = "Signup Successful!"
      render 'show'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  uploaded_io = params[:user][:bookmark]
  array = []
  @bookmarks = []
  file = uploaded_io.read
  file.each_line do |line|
  array << line.match(/A HREF=(["'])(?:(?=(\\?))\2.)*?\1/)
  end
  array.each do | bookmark |
  @bookmarks << bookmark.to_s.match(/(["'])(?:(?=(\\?))\2.)*?\1/).to_s.gsub('"', '') unless bookmark == nil
  end 
  @bookmarks.slice!(0)
  render :text => @bookmarks
  end
  
  def upload_file
    @user = @current_user
  end


    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

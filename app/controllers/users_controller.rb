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
  #if !params[:user][:bookmark].nil?
  uploaded_io = params[:user][:bookmarks]
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
  #need to somehow add @bookmarks to user.bookmark database

  params[:user][:bookmarks] = @bookmarks
  render :text => current_user.bookmarks
  #else
    #render :text => "Please pick a file"
  #end
  current_user.update(bookmarks:@bookmarks)
  #current_user.bookmarks.update_attributes(user_params) doesn't work
  end
  
  def upload_file
      @user ||= User.find_by(id: session[:user_id])
  end

    def bookmarks
      current_user
      #@current_user ||= User.find_by(id: session[:user_id])
  end


    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

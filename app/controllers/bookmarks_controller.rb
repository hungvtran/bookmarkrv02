class BookmarksController < ApplicationController
  def new
  	@bookmarks = Bookmark.new
  end

  def update
	  uploaded_io = params[:bookmarks][:file]
	  array = []
	  @bookmarks = []
	  file = uploaded_io.read
	  
	  file.each_line do |line|
	  array << line.match(/A HREF=(["'])(?:(?=(\\?))\2.)*?\1/)
	  end
	  
	  array.each do | url |
	  @bookmarks << url.to_s.match(/(["'])(?:(?=(\\?))\2.)*?\1/).to_s.gsub('"', '') unless bookmark == nil
	  end 
	  
	  @bookmarks.slice!(0)
	  render :text => @bookmarks
	end


end

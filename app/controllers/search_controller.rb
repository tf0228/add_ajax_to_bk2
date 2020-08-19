class SearchController < ApplicationController

  def search
    if params[:search_target] == 'user'
      search_method = params[:search_method]
      user_name = params[:search_word]
      @users = User.search(user_name,search_method)
    elsif params[:search_target] == 'book'
      search_method = params[:search_method]
      book_title = params[:search_word]
      @books = Book.search(book_title,search_method)
    end
  end

end

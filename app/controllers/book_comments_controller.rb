class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    respond_to do |format|
      format.html { redirect_to book_path(@book) }
      format.js
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    respond_to do |format|
      format.html { redirect_to book_path(params[:book_id]) }
      format.js { @book = Book.find(params[:book_id]) }
    end
  end

  private

    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end

end

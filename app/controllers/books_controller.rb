class BooksController < ApplicationController

  def new
    @book = Book.new
  end
  # 投稿データの保存
  def create
    @post_books = Book.all
    @book = Book.new(post_book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
       render :index
    end
  end

  def index
    @book = Book.new
    @post_books = Book.all
  end


  def show
    @books = Book.find(params[:id])

  end

  def edit
    is_matching_login_user
    @book  = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(post_book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
    is_matching_login_user
  end

   def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    unless user.id == current_user.id
      redirect_to books_path
    end
   end

  # 投稿データのストロングパラメータ
  private
  def post_book_params
    params.require(:book).permit(:title, :body)
  end

end

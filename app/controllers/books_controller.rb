class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
    @users = User.all
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save(book_params) #入力されたデータをdbに保存する。
      redirect_to @book, notice: "successfully created book!"
  	else
      @books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    redirect_to books_path if current_user.id != @book.user_id
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

end

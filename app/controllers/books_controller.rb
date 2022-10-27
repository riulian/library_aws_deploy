class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  

  # GET /books or /books.json
  def index
      
    #@books = Book.order(:title).page params[:page]
      
      @q = Book.ransack(params[:q])
      @books = @q.result(distinct: true).page params[:page]
        
       
    #render json:JSON.pretty_generate( @book.as_json(:include => { :books => { :only => [:title] }}))
    #render json: @books
  end
  def search
    @q = Book.ransack(params[:q])
    @books = @k.result(distinct: true)
  end  

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    @book.books_users.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def destroy_booksuser
    @book.books_users.destroy_all 
  end  
  def rent_a_book #get #NULL is for new books, 1 is for rented books, 2 is for returned
    @scop1=Book.order(:title).where("status is NULL or status=2")
    
         
    #@scop1= (Book.order(:title).left_outer_joins(:books_users).where(books_users: {user_id: nil})).
          #or(Book.order(:title).left_outer_joins(:books_users).where("((status='returned' and status= 'rented')) or(status='returned' and status!= 'rented')"))  #"(user_id > ? AND user_id < ? )      

          

    @scop2=User.order(:id)
  end
  def rentabookrented #post/patch

    @book = Book.find_by id: book_params1[:book_id]
    @user = User.find_by id: book_params1[:user_id]

    if !@user or !@book
      redirect_to books_rent_a_book_path , notice: "Please select correctly!"
    else
      #verify if book was rented in past
      @u=(BooksUser.where(book_id: book_params1[:book_id]).where(books_users: {status: "returned",user_id:book_params1[:user_id] })) #ar trebui sa gasesc ceva pt if
      
     
        if @u[0]!=nil          

          BooksUser.where(book_id: book_params1[:book_id]).where(books_users: {status: "returned",user_id:book_params1[:user_id]}).update(status: "rented")
          @book.update(status: 1)
          redirect_to books_rent_a_book_path , notice: "Rent was succesfully! #{@inspect} "

        else
          @books_users = BooksUser.new(book_id: book_params1[:book_id], user_id: book_params1[:user_id],status: 'rented')
          if @books_users.save
            @book.update(status: 1)
            redirect_to root_path , notice: "Rented!"
          end 
        end 
    end  
  end

  def return_a_book #get
    @scop1= Book.order(:title).joins(:books_users).where(books_users: {status: "rented"} )
    
  end  
  def returnabook #post 
    @book = Book.find_by id: book_params1[:book_id]
    if !@book
        redirect_to books_return_a_book_path , notice: "Please select correctly!"
      else
        BooksUser.where(book_id: book_params1[:book_id]).where(books_users: {status: "rented"}).update(status: "returned")
        @book.update(status: 2)
    end  
  end  
  
  def my_rented_books
    if current_user
     
     @scop1= Book.order(:title).joins(:books_users).where(books_users: {status: "rented",user_id: current_user.id})
    else
      redirect_to user_session_path
    end
  end  
  def all_rented_books
    if current_user && current_user.role=='1'
     
      @scop1= Book.order(:title).joins(:books_users).where(books_users: {status: "rented"})
     else
       redirect_to root_path , notice: "You don't have autorization to see all rented books!"
     end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :book_id)
    end
    def book_params1
      params.permit(:book_id ,:user_id)
    end
   
   
end

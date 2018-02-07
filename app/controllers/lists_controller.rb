class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]
  before_action :set_list, :authorize_user!, except: [:create]

  # GET /lists
  # GET /lists.json
  def index
    # @boards = current_user.boards
    @lists = current_user.lists.order(order: :asc, created_at: :desc)
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    puts 'create'
    @list = List.new(list_params)
    @list.board = @board
    # @board = lists.board
    if @list.save
      redirect_to board_path(@board), notice: 'List was successfully created.'
    else
      puts @list.errors.full_messages
      redirect_to board_path(@board), notice: 'List not created.'
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    if @list.update(list_params)
      redirect_to @board, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    redirect_to @list.board, notice: 'List was successfully destroyed.'
  end

  private
  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_board
    puts 'set board'
    @board = Board.friendly.find(params[:board_id])
    unless can?(:crud, @board)
      flash[:alert] = "You cannot 'crud' lists!"
      redirect_to board_path(@board)
    end
  end

  def list_params
    params.require(:list).permit(:title, :order, :background_color, :image, :status, :slug, :board_id)
  end

  def authorize_user!
    puts 'suthorize user'
    unless can?(:crud, @list)
      flash[:alert] = "You cannot 'crud' lists!"
      redirect_to board_path(@list.board)
    end
  end
end

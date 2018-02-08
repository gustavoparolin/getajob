class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]
  before_action :set_list, :authorize_user!, except: [:create]

  def index
    @lists = current_user.lists.order(order: :asc, created_at: :desc)
  end

  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.board = @board
    if @list.save
      redirect_to board_path(@board), notice: 'List was successfully created.'
    else
      redirect_to board_path(@board), notice: 'List not created.'
    end
  end

  def update
    if @list.update(list_params)
      redirect_to @board, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to @list.board, notice: 'List was successfully destroyed.'
  end

  private
  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_board
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
    unless can?(:crud, @list)
      flash[:alert] = "You cannot 'crud' lists!"
      redirect_to board_path(@list.board)
    end
  end
end

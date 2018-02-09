class Api::V1::BoardsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @boards = current_user.boards.order(order: :asc, created_at: :desc)
  end

  def show
    render json: @board
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      render json: @board
    else
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @board.destroy
      head :ok
      render json: { message: 'Board was successfully deleted' }
    else
      head :bad_request
      render json: { message: 'Board was not deleted' }
    end
  end

  private
  def set_board
    @board = Board.friendly.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :order, :background_color, :background_image, :status, :user_id, :slug)
  end

  def authorize_user!
    unless can?(:crud, @board)
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

end

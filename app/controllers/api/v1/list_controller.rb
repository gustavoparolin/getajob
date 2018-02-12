class Api::V1::ListsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]
  before_action :set_list, :authorize_user!, except: [:create]

  def index
    @lists = current_user.board.lists.order(order: :asc, created_at: :desc)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.board = @board
    if @list.save
      render json: { message: 'List was created', @list }
    else
      render json: { message: 'List was not created',  @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @list.update(list_params)
      render json: { message: 'List was updated', @list }
    else
      render json: { message: 'List was not updated',  @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @list.destroy
      head :ok
      render json: { message: 'List was successfully deleted' }
    else
      head :bad_request
      render json: { message: 'List was not deleted' }
    end
  end

  private
  def set_list
    @list = List.friendly.find(params[:id])
  end

  def set_board
    @board = Board.friendly.find(params[:board_id])
    unless can?(:crud, @board)
      render json: { message: 'You cannot manage this board and its lists',  @board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def list_params
    params.require(:list).permit(:name, :position, :background_color, :image, :status, :slug, :board_id)
  end

  def authorize_user!
    unless can?(:crud, @list)
      render json: { message: 'You cannot manage lists',  @list.errors.full_messages }, status: :unprocessable_entity
    end
  end

end

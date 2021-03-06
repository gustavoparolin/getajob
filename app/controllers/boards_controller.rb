class BoardsController < ApplicationController
  layout "board"
  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @boards = current_user.boards.sorted
  end

  def show
    @lists = @board.lists.sorted
    @list = List.new
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_path, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to boards_path, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_params
    params.require(:board).permit(:name, :position, :background_color, :background_image, :status, :user_id, :slug)
  end

  def authorize_user!
    unless can?(:crud, @board)
      flash[:alert] = "Access denied!"
      redirect_to root_path
    end
  end
end

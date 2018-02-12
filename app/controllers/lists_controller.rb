class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:create]
  before_action :set_list, :authorize_user!, except: [:create]

  def index
    @lists = current_user.lists.sorted
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

    respond_to do |format|
      if @list.save

        ActionCable.server.broadcast "board", { commit: 'addList', payload: render_to_string(:show, format: :json) }

        format.html { redirect_to board_path(@board), notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { redirect_to board_path(@board), notice: 'List not created.' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @board, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to @list.board, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move
    @list.insert_at(list_params[:position].to_i)
    ActionCable.server.broadcast "board", { commit: 'moveList', payload: render_to_string(:show, format: :json) }
    render action: :show
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
    params.require(:list).permit(:name, :position, :background_color, :image, :status, :slug, :board_id)
  end

  def authorize_user!
    unless can?(:crud, @list)
      flash[:alert] = "You cannot 'crud' lists!"
      redirect_to board_path(@list.board)
    end
  end
end

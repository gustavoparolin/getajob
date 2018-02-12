class CardsController < InheritedResources::Base
  before_action :set_card, only: [:show, :edit, :update, :destroy, :move]

  def index
    @cards = current_user.cards.sorted
  end

  def show
  end

  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save

        # ActionCable.server.broadcast "board", { commit: 'addCard', payload: render_to_string(:show, format: :json) }

        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)

        ActionCable.server.broadcast "board", { commit: 'editCard', payload: render_to_string(:show, format: :json) }

        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def move
    @card.update(card_params)
    # ActionCable.server.broadcast "board", { commit: 'moveCard', payload: render_to_string(:show, format: :json) }
    render action: :show
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:name, :position, :slug, :list_id)
    end
end

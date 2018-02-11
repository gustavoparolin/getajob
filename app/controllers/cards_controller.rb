class CardsController < InheritedResources::Base

  def index
    @cards = current_user.cards.sorted
  end

  private

    def card_params
      params.require(:card).permit(:name, :position, :slug, :list_id)
    end
end

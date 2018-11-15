class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def cocktail_params
    # NEED TO ADD OTHER KEYS LINKED TO DOSES AND INGREDIENTS LATER ON - 15/11/2018 - 15h02
    params.require(:cocktail).permit(:name)
  end
end

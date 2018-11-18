class CocktailsController < ApplicationController
  def index
    per_page = 12
    @page_idx = params[:page] ? params[:page].to_i - 1 : 0
    @page_human = @page_idx + 1

    results = params[:q] ? Cocktail.search(:name, params[:q]) : Cocktail.all

    @cocktails = results.order(:name).limit(per_page).offset(per_page * @page_idx)
    @max_page_idx = ((results.count - 1).to_f / per_page).floor
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new # keeps user input to avoid writing everything again when error
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    else
      render :new # keeps user input to avoid writing everything again when error
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    dose_ids = @cocktail.doses.ids
    dose_ids.each do |id|
      @dose = Dose.find(id)
      @dose.destroy
    end

    @cocktail.destroy
    redirect_to cocktails_path
  end

  def search
    redirect_to cocktails_path(q: params[:q])
  end

  def random
    offset = rand(Cocktail.count)
    @cocktail = Cocktail.offset(offset).first
    redirect_to cocktail_path(@cocktail)
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo, :photo_cache, :pic)
  end
end

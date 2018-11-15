class DosesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    # @dose = Dose.new(dose_params)

    # if @dose.save
      # redirect_to cocktail_path(@cocktail)
    # else
      # render :new # keeps user input to avoid writing everything again when error
    # end

    ingredient = Ingredient.find(params[:dose][:ingredient_id])

    qty = params[:dose][:qty].to_i
    qty_unit = params[:dose][:qty_unit]

    Dose.create!(ingredient: ingredient, cocktail: @cocktail, qty: qty, qty_unit: qty_unit)
    # todo: implement correct logic for validation/permission error handling

    redirect_to cocktail_path(@cocktail)
  end

  def update
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
  end

  def destroy
    # @cocktail = Cocktail.find(params[:cocktail_id])
    # @dose = Dose.find(params[:id])
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def edit
    @dose = Dose.find(params[:id])
  end

  private

  def dose_params
    params.require(:dose).permit(:name)
  end

  private

  def dose_params
    params.require(:dose).permit(:qty, :qty_unit, :cocktail, :ingredient)

  end
end


# cocktail_doses POST   /cocktails/:cocktail_id/doses(.:format)       doses#create
#  cocktail_dose PATCH  /cocktails/:cocktail_id/doses/:id(.:format)   doses#update
#                PUT    /cocktails/:cocktail_id/doses/:id(.:format)   doses#update
#                DELETE /cocktails/:cocktail_id/doses/:id(.:format)   doses#destroy

# Format data is save in a cocktail object
# <Dose id: 234, qty: 99, qty_unit: "ml", cocktail_id: 1, ingredient_id: 3201, created_at: "2018-11-15 11:05:23", updated_at: "2018-11-15 11:05:23", qty_raw: nil>

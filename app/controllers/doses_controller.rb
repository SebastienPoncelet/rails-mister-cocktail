class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    ingredient = Ingredient.find(params[:dose][:ingredient_id])

    pars = dose_params
    pars[:cocktail] = @cocktail

    Dose.create!(pars)
    # TODO: implement correct logic for validation/permission error handling

    redirect_to cocktail_path(@cocktail)
  end

  def edit
    @dose = Dose.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])

    @dose.update(dose_params)

    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    # dose_ids = @cocktail.doses.ids
    # dose = Dose.where(cocktail_id: params[:cocktail_id])
    @dose.destroy
    redirect_to cocktail_path(@cocktail)

    # dose_ids.each do |id|
    #   @dose = Dose.find(id)
    #   @dose.destroy
    # end
    # # @dose = Dose.find(params[:id])
    # redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :qty_raw)
  end
end

# cocktail_doses POST   /cocktails/:cocktail_id/doses(.:format)       doses#create
#  cocktail_dose PATCH  /cocktails/:cocktail_id/doses/:id(.:format)   doses#update
#                PUT    /cocktails/:cocktail_id/doses/:id(.:format)   doses#update
#                DELETE /cocktails/:cocktail_id/doses/:id(.:format)   doses#destroy

# Format data is save in a cocktail object
# <Dose id: 234, qty: 99, qty_unit: "ml", cocktail_id: 1, ingredient_id: 3201, created_at: "2018-11-15 11:05:23", updated_at: "2018-11-15 11:05:23", qty_raw: nil>

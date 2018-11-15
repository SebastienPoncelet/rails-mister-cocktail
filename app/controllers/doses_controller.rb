class DosesController < ApplicationController
  def create
    @dose = Dose.new(dose_params)
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new # keeps user input to avoid writing everything again when error
    end
  end

  def update
    @
  end

  def destroy
    @
  end

  private

  def dose_params
    params.require(:dose).permit(:qty, :qty_unit, :cocktail, :ingredient)

  end
end

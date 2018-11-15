class CocktailsController < ApplicationController
  def index(page_idx = 0)

    per_page = 12

    @cocktails = Cocktail.limit(per_page).offset(per_page * page_idx)
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
    @cocktail = Cocktail.find(cocktail_id_params)
    @cocktail[:name] = cocktail_params["name"]

    # @cocktail.update(cocktail_params["name"])
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new # keeps user input to avoid writing everything again when error
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    # NEED TO ADD OTHER KEYS LINKED TO DOSES AND INGREDIENTS LATER ON - SPO - 15/11/2018 - 15h02
    params.require(:cocktail).permit(:name)
  end

  def cocktail_id_params
    # NEED TO ADD OTHER KEYS LINKED TO DOSES AND INGREDIENTS LATER ON - SPO - 15/11/2018 - 15h02
    params.require(:id).to_i
  end
end

# params being sent when updating a cocktail
# {"utf8"=>"✓",
#  "_method"=>"patch",
#  "authenticity_token"=>"/wnVQuMlozyHNJUZUqRN7nuPJf7Dm/FbbQIU7gI/htVSaH0ke8WQLsn6zINK0lwmvqB9ZvPXE0ze/O8tTFqcdA==",
#  "cocktail"=>{"name"=>"RANDOM COCKTAIL 4"},
#  "commit"=>"Update Cocktail",
#  "id"=>"12"}

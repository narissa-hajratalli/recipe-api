class RecipesController < ApplicationController
  # INDEX - Get all recipes
  def index
    @recipe_list = Recipe.where(category_id: params[:category_id])
    # Looks in recipe where the key, category_id is equal to the endpoint

    if @recipe_list.empty?
      render :json => {
          :error => 'Oops, no recipes yet! Add some now.'
      }
    else
      render :json => {
          :response => "successful",
          :data => @recipe_list
      }
    end
  end

  # POST - create a new recipe
  def create
    @one_recipe_for_category =  Recipe.new(recipe_params)
    if Category.exists?(@one_recipe_for_category.category_id)
      if @one_recipe_for_category.save
      render :json => {
          :response => "Success! Created your new recipe.",
          :data => @one_recipe_for_category
      }
    else
      render :json => {
          :error => "Cannot save data."
      }
      end
    end
  end

  # SHOW - one recipe
  def show
    @recipes = Recipe.where(:category_id => params[:category_id])
    @single_recipe = Recipe.exists?(params[:id])
    if @recipes.empty?
      render :json => {
          :error => 'This category does not exist.'
      }
    else
      if @single_recipe && Recipe.find(params[:id]).category_id == params[:category_id].to_i
        render :json => {
            :response => 'Successful',
            :data => Recipe.find(params[:id])
        }
      else
        render :json => {
            :error => 'Recipe does not exist.'
        }
      end
    end
  end

  # UPDATE - update recipe information
  def update
    #if you query the Recipe db by the id, and the id is present then...
    if (@single_recipe_to_update = Recipe.find_by_id(params[:id])).present?
      # ... run the recipe_params function within the update function. it takes the input values from recipe_params and
      # updates that information the db
      @single_recipe_to_update.update(recipe_params)
      render :json => {
          :response => "Successfully updated recipe.",
          :data => @single_recipe_to_update # return the recipe with updated info
      }
    else
      render :json => {
          :response => "Cannot find this record."
      }
    end
  end

  # DELETE - delete a recipe
  def destroy
    if (@single_recipe_delete = Recipe.find_by_id(params[:id])).present?
      @single_recipe_delete.destroy
      render :json => {
          :response => 'Successfully deleted record.'
      }
    else
      render :json => {
          :response => 'record not found'
      }
    end
  end

  ################### PRIVATE ##############################
  private
  def recipe_params
    params.permit(:name, :ingredients, :directions, :notes, :tags, :category_id)
  end
end

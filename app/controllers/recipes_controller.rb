class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    @recipes = Recipe.recent
    render json: RecipeSerializer.new(@recipes)
  end

  def show
    render json: RecipeSerializer.new(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end

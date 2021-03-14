class RecipesController < ApplicationController
  def index
    recipes = Recipe.recent
    render json: serializer.new(recipes)
  end

  def serializer
    RecipeSerializer
  end
end

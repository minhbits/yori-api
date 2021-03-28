# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = Recipe.recent
    render json: RecipeSerializer.new(@recipes)
  end

  def show
    render json: RecipeSerializer.new(@recipe)
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: RecipeSerializer.new(@recipe)
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: RecipeSerializer.new(@recipe)
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:data).require(:attributes).permit(:title)
  end
end

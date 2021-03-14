require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "returns http success response" do
      get "/recipes"
      expect(response).to have_http_status(:success)
    end

    it "returns proper JSON format" do
      recipe = create(:recipe)
      get "/recipes"

      expect(json_data.length).to eq(1)

      aggregate_failures do
        expected = json_data.first
        expect(expected[:id]).to eq(recipe.id.to_s)
        expect(expected[:type]).to eq("recipe")
        expect(expected[:attributes]).to eq(
          title: recipe.title
        )
      end
    end

    it "returns recipes sorted by most recent" do
      old_recipe = create(:recipe, created_at: 1.hour.ago)
      new_recipe = create(:recipe)
      get "/recipes"
      ids = json_data.map { |recipe| recipe[:id].to_i }
      
      expect(ids).to(
        eq([new_recipe.id, old_recipe.id])
      )
    end
  end
end

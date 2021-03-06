# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /recipes' do
    it 'returns http success response' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end

    it 'returns proper JSON format' do
      recipe = create(:recipe)
      get '/recipes'
      expect(json_data.length).to eq(1)

      aggregate_failures do
        expected = json_data.first
        expect(expected[:id]).to eq(recipe.id.to_s)
        expect(expected[:type]).to eq('recipe')
        expect(expected[:attributes]).to eq(title: recipe.title)
      end
    end

    it 'returns recipes sorted by most recent' do
      old_recipe = create(:recipe, created_at: 1.hour.ago)
      new_recipe = create(:recipe)
      get '/recipes'
      ids = json_data.map { |recipe| recipe[:id].to_i }

      expect(ids).to(
        eq([new_recipe.id, old_recipe.id])
      )
    end
  end

  describe 'GET /recipes/:id' do
    let(:recipe) { create :recipe }
    before { get "/recipes/#{recipe.id}" }

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns proper JSON format' do
      aggregate_failures do
        expected = json_data
        expect(expected[:id]).to eq(recipe.id.to_s)
        expect(expected[:type]).to eq('recipe')
        expect(expected[:attributes]).to eq(
          title: recipe.title
        )
      end
    end
  end

  describe 'POST /recipes' do
    let(:valid_attributes) { { data: { attributes: { title: 'Awesome recipe' } } } }
    before { post '/recipes', { params: valid_attributes } }

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns proper JSON format' do
      expect(json_data[:attributes]).to include(
        valid_attributes[:data][:attributes]
      )
    end

    it 'creates the recipe' do
      expect { Recipe.create(valid_attributes[:data]) }.to change { Recipe.count }.by(1)
    end
  end

  describe 'PUT /recipes' do
    let(:recipe) { create :recipe }
    let(:valid_attributes) { { data: { attributes: { title: 'Awesome recipe' } } } }
    before { put "/recipes/#{recipe.id}", { params: valid_attributes } }

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns proper JSON format' do
      expect(json_data[:attributes]).to include(
        valid_attributes[:data][:attributes]
      )
    end

    it 'does not create a new recipe' do
      expect { Recipe.update(valid_attributes[:data]) }.not_to(change { Recipe.count })
    end
  end

  describe 'PATCH /recipes' do
    let(:recipe) { create :recipe }
    let(:valid_attributes) { { data: { attributes: { title: 'Awesome recipe' } } } }
    before { patch "/recipes/#{recipe.id}", { params: valid_attributes } }

    it 'returns http success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns proper JSON format' do
      expect(json_data[:attributes]).to include(
        valid_attributes[:data][:attributes]
      )
    end

    it 'does not create a new recipe' do
      expect { Recipe.update(valid_attributes[:data]) }.not_to(change { Recipe.count })
    end
  end

  describe 'DELETE /recipes/:id' do
    let!(:recipe) { create :recipe }

    it 'returns http success response' do
      delete "/recipes/#{recipe.id}"
      expect(response).to have_http_status(:success)
    end

    it 'returns empty JSON' do
      expect(response).to be_blank
    end

    it 'deletes the recipe' do
      expect { Recipe.find(recipe.id).destroy }.to change { Recipe.count }.by(-1)
    end
  end
end

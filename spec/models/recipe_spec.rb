# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe('#validations') do
    let(:recipe) { build(:recipe) }

    it 'is valid if nothing is missing' do
      expect(recipe).to be_valid
    end

    it 'is invalid if title is missing' do
      recipe.title = ''
      expect(recipe).not_to be_valid
      expect(recipe.errors[:title]).to include('can\'t be blank')
    end
  end

  describe('.recent') do
    it 'returns recipes in the correct order' do
      old_recipe = create(:recipe, created_at: 1.hour.ago)
      new_recipe = create(:recipe)

      expect(described_class.recent).to eq(
        [new_recipe, old_recipe]
      )

      new_recipe.update_column(:created_at, 2.hours.ago)

      expect(described_class.recent).to eq(
        [old_recipe, new_recipe]
      )
    end
  end
end

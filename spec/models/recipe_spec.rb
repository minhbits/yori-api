require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe("#validations") do
    let(:recipe) { build(:recipe) }

    it "is valid if nothing is missing" do
      expect(recipe).to be_valid
    end

    it "is invalid if title is missing" do
      recipe.title = ""
      expect(recipe).not_to be_valid
      expect(recipe.errors[:title]).to include("can't be blank")
    end
  end
end

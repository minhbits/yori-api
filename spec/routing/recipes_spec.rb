require 'rails_helper'

RSpec.describe "/recipes routes", type: :routing do
  it "routes to recipes#index" do
    expect(get "/recipes").to route_to("recipes#index")
  end
end
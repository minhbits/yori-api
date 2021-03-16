require 'rails_helper'

RSpec.describe "/recipes routes", type: :routing do
  it "routes to recipes#index" do
    expect(get "/recipes").to route_to("recipes#index")
  end

  it "routes to recipes#show" do
    expect(get "/recipes/1").to route_to("recipes#show", "id"=>"1")
  end
end
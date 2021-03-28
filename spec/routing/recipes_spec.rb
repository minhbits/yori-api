# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/recipes routes', type: :routing do
  it 'routes to recipes#index' do
    expect((get '/recipes')).to route_to('recipes#index')
  end

  it 'routes to recipes#show' do
    expect((get '/recipes/1')).to route_to('recipes#show', id: '1')
  end

  it 'routes to recipes#create' do
    expect((post '/recipes')).to route_to('recipes#create')
  end

  it 'routes to recipes#update' do
    expect((put '/recipes/1')).to route_to('recipes#update', id: '1')
    expect((patch '/recipes/1')).to route_to('recipes#update', id: '1')
  end

  it 'routes to recipes#destroy' do
    expect((delete '/recipes/1')).to route_to('recipes#destroy', id: '1')
  end
end

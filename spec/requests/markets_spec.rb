require 'rails_helper'

describe 'GET /markets' do
  context 'when sort parameter is provided' do
    it 'returns markets sorted in ascending order by field provided as parameter' do
      create(:market, name: 'New York')
      create(:market, name: 'Anaheim')
      create(:market, name: 'Calgary')

      get '/markets?sort=name'

      binding.pry
      markets = JSON.parse(response.body).deep_symbolize_keys.fetch(:data)
      expect(markets).to eq([
        hash_including(attributes: hash_including(name: 'Anaheim')),
        hash_including(attributes: hash_including(name: 'Calgary')),
        hash_including(attributes: hash_including(name: 'New York'))
      ])
    end
  end

  context 'when negated sort parameter is provided' do
    it 'returns markets sorted in descending order by field provided as parameter' do
      create(:market, name: 'New York')
      create(:market, name: 'Anaheim')
      create(:market, name: 'Calgary')

      get '/markets?sort=-name'
      markets = JSON.parse(response.body).deep_symbolize_keys.fetch(:data)

      expect(markets).to eq([
        hash_including(attributes: hash_including(name: 'New York')),
        hash_including(attributes: hash_including(name: 'Calgary')),
        hash_including(attributes: hash_including(name: 'Anaheim'))
      ])
    end
  end
end

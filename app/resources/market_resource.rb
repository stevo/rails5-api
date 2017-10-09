class MarketResource < JSONAPI::Resource
  attribute :name

  def order
    binding.pry
  end
end

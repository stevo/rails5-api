class Market
  include Flex::ActiveModel

  attribute :name

  def self.all
    MarketsCollection.new
  end
end

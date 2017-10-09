class MarketsCollection
  include Enumerable

  def order(field_sort)
    field, order = field_sort.to_a.flatten
    Market.sort(field => order).all
  end

  def each
    collection.each do |market|
      yield market
    end
  end

  private

  def collection
  end
end

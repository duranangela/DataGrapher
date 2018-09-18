class GraphPresenterSerializer < ActiveModel::Serializer
  attributes :colors, :labels, :pops, :popsb, :popsc, :stats, :total

  def colors
    object.colors
  end

  def total
    object.total
  end

  def labels
    object.labels
  end

  def pops
    object.pops
  end

  def popsb
    object.popsb
  end

  def popsc
    object.popsc
  end

  def stats
    object.characteristics
  end

end

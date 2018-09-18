class GraphPresenter
  attr_reader :location, :characteristics

  def initialize(location, characteristics)
    @location = location
    @characteristics = characteristics
  end

  def colors
    num = labels.count
    colors = num.times.map do |hex|
      '#'+ ("%06x" % rand(0..0xffffff))
    end
  end

  def total
    GraphService.new(@location, @characteristics).total
  end

  def labels
    GraphService.new(@location, @characteristics).labels
  end

  def pops
    GraphService.new(@location, @characteristics).pops
  end

  def popsb
    GraphService.new(@location, @characteristics).popsb
  end

  def popsc
    GraphService.new(@location, @characteristics).popsc
  end

end

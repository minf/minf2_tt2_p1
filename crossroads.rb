
class Crossroads < Array
  def initialize
    super

    @space = Rinda::RingFinger.primary
  end

  def detect_within(x, y, width, height)
    return detect{ |crossroad| crossroad.within?(x, y, width, height) }
  end

  def add(*crossroads)
    crossroads.each do |crossroad|
      @space.write [ :traffic, :crossroad, crossroad.to_s ]
      @space.write [ :map, :crossroad, crossroad.to_s ]

      push crossroad
    end
  end
end


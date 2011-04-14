
class Crossroads < Array
  def detect_within(x, y, width, height)
    return detect{ |crossroad| crossroad.within?(x, y, width, height) }
  end
end


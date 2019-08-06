class Cat
  @@total = 0

  def self.total
    @@total
  end

  def initialize
    @@total += 1
  end
end



kitty1 = Cat.new
kitty2 = Cat.new

p Cat.total

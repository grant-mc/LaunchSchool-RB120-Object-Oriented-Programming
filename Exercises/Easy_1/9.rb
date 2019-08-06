class Pet
  attr_reader :name, :age, :color
  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end

  def to_s
    "#{self.name} is #{self.age} years old and has #{self.color} fur."
  end
end

class Cat < Pet
  def to_s
    "My cat " + super
  end
end

#TEXT BOOK SOLUTION

# class Cat < Pet
#   def initialize(name, age, colors)
#     super(name, age)
#     @colors = colors
#   end

#   def to_s
#     "My cat #{@name} is #{@age} years old and has #{@colors} fur."
#   end
# end


pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name=('Luna')
kitty.greet

#--OR---

# class Cat
#   attr_reader :name
#   attr_writer :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = 'Luna'
# kitty.greet
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
end

kitty = Cat.new('Sophie')
kitty.greet
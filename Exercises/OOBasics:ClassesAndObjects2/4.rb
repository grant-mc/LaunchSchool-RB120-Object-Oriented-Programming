class Cat
  attr_reader :name

  def self.generic_greeting
    p "Hello I'm a cat!"
  end

  def initialize(name)
    @name = name
  end

  def personal_greeting
    p "Hello! My name is " + self.name + "!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting


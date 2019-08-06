class Person
  attr_accessor :name

  def name=(name)
    name_arr = name.split()
    @first_name = name_arr[0]
    @last_name = name_arr[1]
  end

  def name()
    @first_name + " " + @last_name
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name

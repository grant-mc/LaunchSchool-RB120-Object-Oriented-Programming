class Pet
  attr_reader :type, :pet_name

  def initialize(type, pet_name)
    @type = type
    @pet_name = pet_name
  end
end

class Owner
  attr_reader :name, :num_pets
  attr_accessor :num_pets

  def initialize(owner_name)
    @name = owner_name
    @num_pets = 0
  end

  def increase_num_pets
    self.num_pets += 1
  end

  private

  attr_writer :num_pets


end


class Shelter

  def initialize
    @adoptions = {}
  end

  def adopt (owner, pet)
    owner.increase_num_pets
    if self.adoptions.has_key?(owner) == false
      pets = []
      pets << pet
      self.adoptions[owner] = pets
    else
      self.adoptions[owner] << pet
    end
  end

  def print_adoptions
    adoptions.each do |k, v|
      p "#{k.name} has adopted the following pets:"
      v.each do |pet|
        p "a #{pet.type} named #{pet.pet_name}"
      end
      puts "\n"
    end
  end

  protected

  attr_accessor :adoptions
end


#OR

# class Pet
#   attr_reader :animal, :name

#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end

#   def to_s
#     "a #{animal} named #{name}"
#   end
# end

# class Owner
#   attr_reader :name, :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def add_pet(pet)
#     @pets << pet
#   end

#   def number_of_pets
#     pets.size
#   end

#   def print_pets
#     pets.each { |pet| puts pet }
#   end
# end

# class Shelter
#   def initialize
#     @owners = {}
#   end

#   def adopt(owner, pet)
#     owner.add_pet(pet)
#     @owners[owner.name] ||= owner
#   end

#   def print_adoptions
#     @owners.each_pair do |name, owner|
#       puts "#{name} has adopted the following pets:"
#       owner.print_pets
#       puts
#     end
#   end
# end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
# p shelter.adoptions
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.num_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.num_pets} adopted pets."
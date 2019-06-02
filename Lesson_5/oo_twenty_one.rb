# class Player
#   attr_accessor :hand
#   def initialize(deck)
#     # what would the "data" or "states" of a Player object entail?
#     # maybe cards? a name?
#     @hand = deal_hand(deck)
#   end

#   def deal_hand(deck)
#     hand = []
#     2.times { hand << deck.deal }
#     hand
#   end

#   def hit(deck)
#     @hand << deck.deal
#   end

#   def stay
#   end

#   def busted?
#     total > 21
#   end

#   def total
#   total_value = 0
#   @hand.each do |card|
#     if card == "Ace"
#       total_value += 11
#     elsif card.to_i == 0
#       total_value += 10
#     else
#       total_value += card
#     end
#   end

#   hand.select { |card| card == "Ace" }.count.times do
#     total_value -= 10 if total_value > 21
#   end
#   total_value
#   end
# end



# class Deck
#   CARDS = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King']
#   FACE_CARDS = ['Jack', 'Queen', 'King']
  
#   def initialize
#     @deck = prep
#   end

#   def prep
#     deck = []
#     4.times { CARDS.each { |card| deck << card } }
#     deck.shuffle!
#   end

#   def deal
#     @deck.pop
#   end
# end

# class Card
#   def initialize
#     # what are the "states" of a card?
#   end
# end

# class Game
#   attr_accessor :deck, :Human, :Dealer

#   def initialize
#     @deck = Deck.new
#     @Human = Player.new(@deck)
#     @Dealer = Player.new(@deck)
#   end


#   def compare_score
#     if @Human.total > @Dealer.total
#       puts "Your hand is #{@Human.hand} it's value is #{@Human.total}\n" + 
#       "The dealers hand is #{@Dealer.hand} it's value is #{@Dealer.total}\n" + 
#       "You win!!!"
#     elsif @Dealer.total > @Human.total
#       puts "Your hand is #{@Human.hand} it's value is #{@Human.total}\n" + 
#       "The dealers hand is #{@Dealer.hand} it's value is #{@Dealer.total}\n" + 
#       "You lose!!!"
#     else
#       puts "It's a tie!!!"
#     end
#   end

#   def player_turn
#     loop do
#       puts "It's your turn would you like to hit or stay?"
#       choice = gets.chomp.downcase
#       if choice == 'hit'
#         @Human.hit(@deck)
#         puts "Your hand is #{@Human.hand} it's value is #{@Human.total}"
#         break if @Human.busted?
#       elsif choice == 'stay'
#         break
#       else
#         puts "That is not a valid input please choose again"
#       end
#     end
#   end

#   def computer_turn
#     while @Dealer.total < 17
#       @Dealer.hit(@deck)
#     end
#   end

#   def play_game
#     puts "Your hand is #{@Human.hand} it's value is #{@Human.total}"
#     player_turn
#     if @Human.busted?
#       puts "You Busted!!!! You lose!"
#       return
#     end

#     computer_turn
#     if @Dealer.busted?
#       puts "The Dealer Busted!!!! You win!"
#       return
#     end
#     compare_score
#   end


#   def start
#     answer = ''
#     while answer != 'n'
#       play_game
#       p "That was a good game would you like to play again? (y/n)"
#       answer = gets.chomp.downcase
#       @deck = Deck.new
#       @Human = Player.new(@deck)
#       @Dealer = Player.new(@deck)
#       system "clear"
#     end
#   end



# end

# Game.new.start

class Card
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def ace?
    face == 'Ace'
  end

  def king?
    face == 'King'
  end

  def queen?
    face == 'Queen'
  end

  def jack?
    face == 'Jack'
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def total
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.jack? || card.queen? || card.king?
        total += 10
      else
        total += card.face.to_i
      end
    end

    # correct for Aces
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards
  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def show_flop
    show_hand
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = ROBOTS.sample
  end

  def show_flop
    puts "---- #{name}'s Hand ----"
    puts "#{cards.first}"
    puts " ?? "
    puts ""
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    puts "#{player.name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if ['h', 's'].include?(answer)
        puts "Sorry, must enter 'h' or 's'."
      end

      if answer == 's'
        puts "#{player.name} stays!"
        break
      elsif player.busted?
        break
      else
        # show update only for hit
        player.add_card(deck.deal_one)
        puts "#{player.name} hits!"
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    loop do
      if dealer.total >= 17 && !dealer.busted?
        puts "#{dealer.name} stays!"
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits!"
        dealer.add_card(deck.deal_one)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "It looks like #{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "It looks like #{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def show_result
    if player.total > dealer.total
      puts "It looks like #{player.name} wins!"
    elsif player.total < dealer.total
      puts "It looks like #{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def start
    loop do
      system 'clear'
      deal_cards
      show_flop

      player_turn
      if player.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      dealer_turn
      if dealer.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      # both stayed
      show_cards
      show_result
      play_again? ? reset : break
    end

    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

game = TwentyOne.new
game.start
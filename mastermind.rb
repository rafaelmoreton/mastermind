class Match

    def initialize
        @human = Human.new(self)
        @computer = Computer.new(self)
        @breaker = nil
        @maker = nil
        @code = nil
        self.choose_role
    end

    def play
        @code = @maker.make_code!
        loop do
            guess = @breaker.try_crack_code!
            if self.guess_checks?(guess)
                puts "Win!"
                break
            else
                self.provide_feedback(guess)
            end
        end
    end

    def guess_checks?(guess)
        if guess == @code
            return true
        else
            return false
        end
    end

    def provide_feedback(guess)
        feedback = []
        check_index = 0
        second_test_guess = [] #the one to be tested for correct number if the position was wrong
        second_test_code = []
        guess.each do |guess_digit|
            if guess_digit == @code[check_index]
                feedback << "O"
            else
                second_test_code << @code[check_index]
                second_test_guess << guess_digit
            end
            check_index += 1
        end
        common_values = (second_test_code & second_test_guess).flat_map do
            |code_digit| code_digit * [second_test_code.count(code_digit),
                second_test_guess.count(code_digit)].min
        end
        common_values.length.times do
            feedback << "."
        end
        return puts "\nThe guess was #{guess}.\nThis how close it was #{feedback}"
    end

    def choose_role
        puts "\n\nDo you want to be the code BREAKER-(1) or the code MAKER-(2)?"
        role_choice = nil
        loop do
            role_choice = gets.chomp
            case role_choice
            when "1"
                @breaker = @human
                @maker = @computer
                break
            when "2"
                @breaker = @computer
                @maker = @human
                break
            else
                puts "Enter '1' to be the BREAKER or '2' to be the MAKER."
            end
        end
    end


end

class Player
    def initialize(match)
        @match = match
    end
end

class Human < Player
    def make_code!
        code = gets.chomp.split(//)
        return code
    end

    def try_crack_code!
        puts "\nTry your guess."
        guess = gets.chomp.split(//).map { |number| number.to_i }
        return guess
    end
end

class Computer < Player
    def make_code!
        code = []
        4.times do
            code << rand(1..6)
        end
        return code
    end

    def try_crack_code!
        
    end

end


Match.new.play
class Match

    def initialize
        puts "What role do you want?"
        @human_role = self.choose_role
        @human = Human.new(self, @human_role)
        @computer_role = nil
        case @human_role #1 is for BREAKER, 2 is for MAKER
        when "1"
            @computer_role = "2"
        when "2"
            @computer_role = "1"
        end
        @computer = Computer.new(self, @computer_role)
        @code = nil
    end

    def play
        @human_role == "1" ? @code = @computer.make_code! : @code = @human.make_code!
        loop do
            guess = @human.try_crack_code!
            puts "#{@human}'s guess is #{guess}."
            if self.guess_checks?(guess)
                puts "Win!"
                break
            # else
            #     self.provide_feedback(guess)
            end
        end
    end

    def guess_checks?(guess)
        p "debug: the correct code is #{@code}"
        if guess == @code
            return true
        else
            return false
        end
    end

    # def provide_feedback(guess)
    #     feedback = []
    #     check_index = 0
    #     working_code = Array.new(@code)
    #     guess.each do |guess_digit|
    #         p "guess digit is #{guess_digit}"
    #         p "code digit is #{working_code[check_index]}"
    #         if guess_digit == working_code[check_index]
    #             feedback << "O"
    #             working_code.delete_at(check_index)
    #             guess.delete_at(check_index)
    #         end
    #         check_index += 1
    #     end
    #     return p feedback 
    # end

    def choose_role
        puts "Do you want to be the code BREAKER-(1) or the code MAKER-(2)?"
        role_choice = nil
        loop do
            role_choice = gets.chomp
            case role_choice
            when "1"
                break
            when "2"
                break
            else
                puts "Enter '1' to be the BREAKER or '2' to be the MAKER."
            end
        end
        return role_choice
    end


end

class Player
    def initialize(match, player_role)
        @match = match
        @player_role
    end
end

class Human < Player
    def make_code!
        code = gets.chomp.split(//)
        return code
    end

    def try_crack_code!
        puts "Guess the code"
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

end


Match.new.play
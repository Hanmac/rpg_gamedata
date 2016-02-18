require_relative "enemy"
require_relative "unit"

module RPG
	class Troop
	end
end

module Game
	class Troop < Unit
		def create_member(key)
			Game::Enemy.new(key)
		end
	end
end

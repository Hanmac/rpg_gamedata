require_relative "actor"
require_relative "unit"

module RPG
	class Party
	end
end

module Game
	class Party < Unit
		def create_member(key)
			Game::Actor.new(key)
		end
	end
end

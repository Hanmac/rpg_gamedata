require_relative "base_item"

module RPG

	class State < BaseItem
	end
end

module Game
	class State < BaseItem
		def rpg
			RPG::State[@key]
		end
	end
end

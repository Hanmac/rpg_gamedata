require_relative "base_item"

module RPG

	class Weapon < BaseItem
	end
end

module Game
	class Weapon < BaseItem
		def rpg
			RPG::Weapon[@key]
		end
	end
end

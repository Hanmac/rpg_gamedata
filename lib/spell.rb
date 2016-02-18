require_relative "base_item"

module RPG

	class Skill < BaseItem
	end
end

module Game
	class Skill < BaseItem
		def rpg
			RPG::Skill[@key]
		end
	end
end

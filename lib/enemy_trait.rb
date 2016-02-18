require_relative "enemy"
require_relative "battler_trait"

module RPG
	
	class Enemy < Battler
		attr_accessor :traits
		
		override("trait") do
			def initialize(*)
				super
				@traits = []
			end
		end
	end
end

module Game
	class Enemy < Battler
		
		override("trait") do
			def initialize(*)
				super
				rpg.traits.each {|t| add_trait(t.key) }
			end
		end
	end
end

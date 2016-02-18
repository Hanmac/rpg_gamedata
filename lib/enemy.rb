require_relative "battler"

module RPG

	class Requirement
		attr_accessor :any_enemy
		attr_accessor :none_enemy
	
		override("enemy") do
			def initialize(*)
				super
				@any_enemy = []
				@none_enemy = []
			end
			
			def check(battler, *opt)
				result = super
				result &&= check_single_value(
					any: @any_enemy,
					none: @none_enemy,
					value: battler.key
				) if battler.is_a?(Game::Enemy)
				return result
			end
		end
	end
	
	class Enemy < Battler
	end
end

module Game
	class Enemy < Battler
		def rpg
			RPG::Enemy[@key]
		end
	end
end

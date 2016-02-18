require_relative "battler"

module RPG

	class Requirement
		attr_accessor :any_actor
		attr_accessor :none_actor
	
		override("actor") do
			def initialize(*)
				super
				@any_actor = []
				@none_actor = []
			end
			
			def check(battler, **opt)
				result = super
				result &&= check_single_value(
					any: @any_actor,
					none: @none_actor,
					value: battler.key
				) if battler.is_a?(Game::Actor)
				return result
			end
		end
	end
	
	class Actor < Battler
	end
end

module Game
	class Actor < Battler
		def rpg
			RPG::Actor[@key]
		end
	end
end

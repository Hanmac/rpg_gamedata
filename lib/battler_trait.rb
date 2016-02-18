require_relative "battler"
require_relative "trait"


module Game
	class Battler
	
		attr_accessor :traits
		
		override("trait") do
			
			def initialize(*)
				super
				@traits = []
			end
			
		end
		
		def available_traits
			traits.select {|t| t.rpg.requirement.check(self) }
		end
		
		def add_trait(key)
			@traits << Game::Trait.new(key)
			return self
		end
	end
end

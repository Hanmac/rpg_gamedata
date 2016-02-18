require_relative "trait"
require_relative "state"

module RPG
	class Trait
		attr_accessor :states
		
		override("states") do
			def initialize(*)
				super
				@states = []
			end
		end
		
	end
end

module Game
	class Trait
		attr_accessor :states
		override("states") do
			def initialize(*)
				super
				@states = rpg.states.map {|k| [k, Game::State.new(k)] }.to_h
			end
		end
	end
end

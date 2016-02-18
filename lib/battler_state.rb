require_relative "battler_trait"
require_relative "trait_state"

module RPG

	class Requirement
		attr_accessor :all_state
		attr_accessor :any_state
		attr_accessor :one_state
		attr_accessor :none_state
	
		override("state") do
			def initialize(*)
				super
				@all_state = []
				@any_state = []
				@one_state = []
				@none_state = []
			end
			
			def check(battler, states: nil, **opt)
				result = super
				result &&= check_hash_value(
					all: @all_state,
					any: @any_state,
					one: @one_state,
					none: @none_state,
					list: states
				) { battler.states }
				return result
			end
		end
	end
	
	class State
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

	class State
		attr_accessor :traits
		
		override("trait") do
			def initialize(*)
				super
				@traits = rpg.traits.map {|t| Trait.new(t.key) }
			end
		end
	end

	class Battler
		override("state") do
			def initialize(*)
				super
				@states = {}
			end
			
			def traits
				@states.values.flat_map(&:traits).flatten + super
				#+ states.map(&:traits).flatten
			end
		end
		
		def add_state(key)
			@states[key] = Game::State.new(key)
		end
		
		def states
			# cant use available traits because of recusion!
			vsymbols, vstates = @states.keys, @states.values
			
			traits.each do |t|
				if t.rpg.requirement.check(self, states: vsymbols)
					vsymbols += t.states.keys
					vstates += t.states.values
				end
			end
			return vstates.flatten.group_by(&:key)
		end
	end
end

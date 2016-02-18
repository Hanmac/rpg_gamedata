require_relative "battler_trait"
require_relative "trait_skill"

module RPG

	class Requirement
		attr_accessor :all_skill
		attr_accessor :any_skill
		attr_accessor :one_skill
		attr_accessor :none_skill
	
		override("skill") do
			def initialize(*)
				super
				@all_skill = []
				@any_skill = []
				@one_skill = []
				@none_skill = []
			end
			
			def check(battler, skills: nil, **opt)
				result = super
				result &&= check_hash_value(
					all: @all_skill,
					any: @any_skill,
					one: @one_skill,
					none: @none_skill,
					list: skills
				) { battler.skills }
				return result
			end
		end
	end
end

module Game
	class Battler
		override("skill") do
			def initialize(*)
				super
				@skills = {}
			end
		end
		
		def add_skill(key)
			@skills[key] = Game::Skill.new(key)
		end
		
		def skills
			# cant use available traits because of recusion!
			vsymbols, vskills = @skills.keys, @skills.values
			
			traits.each do |t|
				if t.rpg.requirement.check(self, skills: vsymbols)
					vsymbols += t.skills.keys
					vskills += t.skills.values
				end
			end
			return vskills.flatten.group_by(&:key)
		end
	end
end

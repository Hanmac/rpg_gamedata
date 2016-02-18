require_relative "trait"
require_relative "skill"

module RPG
	class Trait
		attr_accessor :skills
		
		override("skill") do
			def initialize(*)
				super
				@skills = []
			end
		end
		
	end
end

module Game
	class Trait
		attr_accessor :skills
		override("skill") do
			def initialize(*)
				super
				@skills = rpg.skills.map {|k| [k, Game::Skill.new(k)] }.to_h
			end
		end
	end
end

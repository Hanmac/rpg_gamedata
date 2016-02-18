require_relative "requirement"

module RPG
	class Trait
		
		attr_accessor :key
		
		attr_accessor :requirement
	
		def initialize(key)
			@key = key
			@requirement = Requirement.new(key)
			
			self.class[key] = self
		end
		
		
		
		class << self
			
			def [](key)
				@objects ||= {}
				@objects[key]
			end
			
			def []=(key,value)
				@objects ||= {}
				@objects[key] = value
			end
		end
	end
end


module Game
	class Trait
	
		def initialize(key)
			@key = key
		end
		
		def rpg
			RPG::Trait[@key]
		end
	end
end

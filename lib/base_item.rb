require_relative "requirement"

module RPG
	class BaseItem
		
		attr_accessor :key
		
		def initialize(key)
			@key = key
			
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
	class BaseItem
		attr_accessor :key
		
		def initialize(key)
			@key = key
		end
	end
end

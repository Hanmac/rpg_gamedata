require_relative "prereq"
module RPG
	class Requirement
	
		def initialize(key)
			@key = key
			
			self.class[key] = self
		end
		
		def check_single_value( any: [], none: [], value: nil)
			return true if any.empty? && none.empty?

			return any.include?(value) unless any.empty?
			return !none.include?(value) unless none.empty?

			return true
		end
		
		def check_hash_value( all: {}, any: {}, one: {}, none: {}, list: nil, &block)
			return true if all.empty? && any.empty? && one.empty? && none.empty?
			
			if list
				m = list.method(:include?)
			else
				m = block.arity == 1 ? block : block.call().method(:has_key?)
			end
			
			return all.all? {|s| m.call(s) } unless all.empty?
			return any.any? {|s| m.call(s) } unless any.empty?
			return one.one? {|s| m.call(s) } unless one.empty?
			return none.none? {|s| m.call(s) } unless none.empty?
			
			return true
		end
		
		def check(battler, **opt)
			return true
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

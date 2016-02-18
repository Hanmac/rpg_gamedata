require_relative "battler"

module Game
	class Unit
	
		include Enumerable
	
		def initialize
			@members = []
			@removed_members = []
		end
	
		def each
			return to_enum(:each) unless block_given?
			@members.each {|m| yield m }
			return self
		end
		
		def add_battler(battler)
			if battler.is_a?(Symbol)
				@members << create_member(battler)
			else
				@removed_members.delete(battler)
				@members << battler
			end
		end
		
		def remove_battler(battler)
			if battler.is_a?(Symbol)
				@removed_members << @members.delete(@members.find {|m| m.key == battler })
			else
				@members.delete(battler)
				@removed_members << battler
			end
		end
		
		def create_member(key)
			raise NotImplementedError
		end
	end
end

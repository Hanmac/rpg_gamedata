require "nokogiri"

class AnonModule < Module

	def initialize(name, parent, &block)
		super(&block)
		@name = name
		@parent = parent.inspect
	end

	def inspect
		return "#@parent<#@name>"
	end
end

class Module
	def override(name, &block)
		prepend(AnonModule.new(name, self, &block))
	end
end

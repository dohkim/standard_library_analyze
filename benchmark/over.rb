class A
	attr_reader :asdf

	def initialize(num=0)
		@asdf=num
	end

	def +(other)
		p @asdf.__send__(:+, other.asdf)
	end
end

class B
	attr_reader :asdf

	def initialize(num=0)
		@asdf=num
	end
end

asdf=A.new(3)
p asdf
dd=B.new(1)
p dd
asdf+dd



	




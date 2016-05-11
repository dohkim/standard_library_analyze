module Benchmark
	def measure(label="") #:yield:
		#Returns a Tms structure (see Struct::Tms) that
		#contains user and system CPU times for this process,
		# and also for children processes.
		t0, r0 = Process.times, Time.now
		yield
		t1, r1 = Process.times, Time.now

		Benchmark::Tms.new(t1.utime - t0.utime,
							t1.stime - t0.stime,
							t1.cutime - t0.cutime,
							t1.cstime - t0.cstime,
							r1-r0,
							label)		
	end
	module_function :measure

	class Tms
		FORMAT = "%10.6u %10.6y %10.6t %10.6r\n"

		attr_reader :utime
		attr_reader :stime
		attr_reader :cutime
		attr_reader :cstime
		attr_reader :real
	    attr_reader :total
	    attr_reader :label

		def initialize(utime=0.0, stime=0.0, cutime=0.0, cstime=0.0, real=0.0, label=nil)
			@utime, @stime, @cutime, @cstime, @real, @label = utime, stime, cutime, cstime, real, label.to_s
			@total = @utime + @stime + @cutime + @cstime
		end

		def format(format = nil, *args)  
			str = (format||FORMAT).dup #array should be duplicated.

			str.gsub!(/(%[-.\d]*)n/) { "#{$1}s" % label }
			str.gsub!(/(%[-.\d]*)u/) { "#{$1}f" % @utime }
			str.gsub!(/(%[-.\d]*)t/) { "#{$1}f" % @total }
			str.gsub!(/(%[-.\d]*)r/) { "#{$1}f" % @real }
			str.gsub!(/(%[-+.\d]*)y/) { "#{$1}f" % stime }
      		str.gsub!(/(%[-+.\d]*)U/) { "#{$1}f" % cutime }
      		str.gsub!(/(%[-+.\d]*)Y/) { "#{$1}f" % cstime }
      		format ? str % args : str
		end
		def to_s
			format
		end
	end

end

# require_relative 'benchmark_doh'
# puts Benchmark.measure { "a"*1_000_000_000 }

require_relative 'benchmark'
# include Benchmark         # we need the CAPTION and FORMAT constants

# n = 50000
	
# Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x| #def benchmark(caption = "", label_width = nil, format = nil, *labels) # :yield: report
#   tf = x.report("for:")   { for i in 1..n; a = "1"; end }
#   tt = x.report("times:") { n.times do   ; a = "1"; end }
#   tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
#   [tf+tt+tu, (tf+tt+tu)/3]
# end
# n = 50000
# Benchmark.bm(7) do |x|
#   x.report("for:")   { for i in 1..n; a = "1"; end }
#   x.report("times:") { n.times do   ; a = "1"; end }
#   x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
# end

array = (1..1000000).map { rand }

Benchmark.bmbm do |x|
  x.report("sort!") { array.dup.sort! }
  x.report("sort")  { array.dup.sort  }
end
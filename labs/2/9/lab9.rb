# coding: utf-8
# Работа 9: Измерение коэффициента теплопроводимости воздуха.
require 'gnuplot'

outFile = 'graph.png'
writeOut = false

alpha = 61.0
d1 = 16.9
d2 = 1.6

ia = [0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225]
r1 = [8.09, 8.10, 8.11, 8.12, 8.16, 8.19, 8.21, 8.25]
r2 = [8.10, 8.11, 8.12, 8.14, 8.16, 8.19, 8.22, 8.25]
r = Array.new
0.upto(r1.size - 1) do |i|
    r[i] = (r1[i] + r2[i]) / 2
    r[i] = r[i].round(3)
    ia[i] **= 2
    ia[i] = ia[i].round(4)
end

mx = ia.size - 4
k = Array.new
0.upto(mx) do |i|
# p (r[i + 3] - r[i])
    k[i] = (ia[i + 3] - ia[i]) / (r[i + 3] - r[i])
end

tk = 0

0.upto(k.size - 1) do |i|
    tk += k[i]
end

tk /= ((k.size).to_r)

p tk

sx = 0
sy = 0
x = ia.collect { |v| v * 1000.0}
y = r.collect { |v| v}
x.each{|v| sx += v / 1000.0}
y.each{|v| sy += v}
sx /= x.size.to_r
sy /= y.size.to_r
p sx
p sy
b = sy - tk * sx - 0.06
p b, tk
dy = x.collect { |v| 0.02 }
p x
p y
p (k[1] - k[2]) / 2.0
delta = Math::sqrt((0.1/15.8)**2 + (0.1/0.16)**2)/4.59
print "delta: %f\n" % [delta]
kk = (((0.05**2 /(8.095-8.09) ) * 8.09**2 * 0.005 * 4.59)/(8.0 * Math::PI * 0.694 *(1.0 + 0.005 * 25)))
print "k: %f\n" % [kk - 0.01]
dk = Math::sqrt((0.0163/0.31)**2 + 4*(0.0015/8.09)**2 + (0.5/69.4)**2 +(delta)**2)
print "dk/k: %f\n" % [dk]
#exit(0)

Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
        if writeOut
            plot.output outFile
            plot.terminal 'png'
        end
        plot.xrange "[-10:70]"
        plot.yrange "[8.05:8.30]"
        plot.title  ""
        plot.ylabel "r, Om"
        plot.xlabel "I^2, A^2"
#        plot.arbitrary_lines << "terminal postscript eps enhanced adobeglyphnames"
#        plot.arbitrary_lines << "set encoding utf8"
#        plot.arbitrary_lines << "set ylabel \"\" font \"Helvetica,10\""

        plot.data = [
#            Gnuplot::DataSet.new( "y=5x" ) { |ds|
#                ds.with = "lines"
#                ds.title = "String function"
#                ds.linewidth = 4
#            },

            Gnuplot::DataSet.new( [x, y, dy] ) { |ds|
                ds.with = "yerrorbars lt rgb \"orange\""
                ds.title = "dR"
#                ds.linetype "rgb \"violet\""
            },
            Gnuplot::DataSet.new( "8.09+0.0031*x" ) { |ds|
                ds.with = "lines lt rgb \"grey\""
                ds.title = "line"
            }
        ]

    end
end



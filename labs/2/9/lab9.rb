# coding: utf-8
# Работа 9: Измерение коэффициента теплопроводимости воздуха.
require 'gnuplot'

outFile = 'graph.png'
writeOut = false

alpha = 61.0
d1 = 16.9
d2 = 1.6

i = [0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25]
r = [8.57, 8.59, 8.59, 8.61, 8.63, 8.65, 8.675, 8.705, 8.73]
x = i.collect { |v| v * v * 1000.0 }
y = r.collect { |v| v }
dy = x.collect { |v| 0.02 }


Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
        if writeOut
            plot.output outFile
            plot.terminal 'png'
        end
        plot.xrange "[-10:100]"
        plot.yrange "[8.50:8.80]"
        plot.title  "qweqwe"
        plot.ylabel "x"
        plot.xlabel "sin(x)"
        plot.arbitrary_lines << "terminal postscript eps enhanced adobeglyphnames"
        plot.arbitrary_lines << "set encoding utf8"
        plot.arbitrary_lines << "set ylabel \"Й:wSignal mean value\" font \"Helvetica,10\""

        plot.data = [
#            Gnuplot::DataSet.new( "y=5x" ) { |ds|
#                ds.with = "lines"
#                ds.title = "String function"
#                ds.linewidth = 4
#            },

            Gnuplot::DataSet.new( [x, y, dy] ) { |ds|
                ds.with = "yerrorbars lt rgb \"orange\""
                ds.title = "Array data"
#                ds.linetype "rgb \"violet\""
            },
            Gnuplot::DataSet.new( "8.56+0.0024*x" ) { |ds|
                ds.with = "lines lt rgb \"grey\""
                ds.title = "Array data"
            }
        ]

    end
end



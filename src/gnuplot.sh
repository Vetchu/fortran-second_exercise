for i in afterFFT timesignal afterNoise afterNoiseFFT afterCorrection
do
    gnuplot -e "set terminal png size 1200,800; set output 'res/plot_$i.png'; plot 'res/$i.dat' with lines"
done

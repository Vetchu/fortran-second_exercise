for i in afterFFT afterNoiseFFT
do
    gnuplot -e    "set terminal png size 1200,800;    set xlabel 'Frequency';    set ylabel 'Intensity';    set output 'res/plot_$i.png';    plot 'res/$i.dat' with lines";
    done
for i in timesignal afterNoise afterCorrection
do
    gnuplot -e    "set terminal png size 1200,800;    set xlabel 'Time';    set ylabel 'Valu';    set output 'res/plot_$i.png';    plot 'res/$i.dat' with lines";
done

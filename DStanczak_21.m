clear all;

Nballs = [10, 10^2, 10^5];
Nrows = 50;

r = cumsum(randi(2, [10^5 Nrows])*2 - 3, 2);
for i=Nballs;
    r_this = r(1:1:i, Nrows);
    [x, y] = galton(Nrows);
    [m, bin] = hist(r_this, 30);
    m = m/trapz(bin,m);
    filename_bins = sprintf('galton_%d_bins.csv', i);
    filename_m = sprintf('galton_%d_m.csv', i);
    csvwrite(filename_bins, bin);
    csvwrite(filename_m, m); 
end
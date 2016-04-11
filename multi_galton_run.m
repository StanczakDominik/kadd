function [r] = multi_galton_run(Nrows, Nballs)
    r = cumsum(randi(2, [Nballs Nrows])*2 - 3, 2);
    disp(size(r))
    for i=logspace(1,5, 5)
        r_this = r(1:1:i, Nrows);
        [x, y] = galton(Nrows);
        [m, bin] = hist(r_this, 30);
        m = m/trapz(bin,m);
        bar(bin, m);
        hold on
        gaussian_std = std(r_this)
        gaussian_mean = mean(r_this)
        disp(max(r_this))
        disp(min(r_this))
        x_g = -Nrows/2:0.01:Nrows/2;
        y_g = exp(-(x_g-gaussian_mean).^2/(2*gaussian_std.^2))/(gaussian_std*sqrt(2*pi));
        plot(x_g, y_g, 'r-');
        pause
        hold off
    end
end
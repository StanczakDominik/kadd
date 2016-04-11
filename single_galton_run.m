function [r] = single_galton_run(Nrows)
    [x, y] = galton(Nrows);
    plot(x,y, 'bo')
    hold on
    r = 0
    for i = Nrows:-1:1
        r = r + randi(2)*2-3
        plot(r, i, 'ro')
        hold on
        pause
    end
end
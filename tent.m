function y = tent(x)
    if x < 0.5
        y = 2*x;
    else
        y = 2-2*x;
    end
end
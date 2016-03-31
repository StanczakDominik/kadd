function fraction_accepted = hypersphere(dim)
%
%
    N = 100000;
    punkty = rand(dim, N);

    r = sum(punkty.^2);
    number_accepted = sum(r<1);
    fraction_accepted = number_accepted/N;
end
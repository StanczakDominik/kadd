N = 100000;
dim = 2;
punkty = rand(dim, N);

r = sum(punkty.^2)
number_accepted = sum(r<1)
fraction_accepted = number_accepted/N
pi_estimate = 4*fraction_accepted

punkty_in = punkty(:,r<1)
punkty_out = punkty(:, r>1)


plot(punkty_in(1,:), punkty_in(2,:), 'b.')
hold on
plot(punkty_out(1,:), punkty_out(2,:), 'r.')
xlabel('x')
ylabel('y')
title('pole ćwierćkoła')
%x = linspace(0,1,1000);
f = @(x) sqrt(1-x.^2)
pi_numerical_estimate = 4*quadgk(f, 0, 1)
relative_difference = (pi_estimate-pi_numerical_estimate)/pi_numerical_estimate

%%czesc 2
dims = 2:10;
fractions = zeros(1,9)
for i = dims
    fractions(i-1) = hypersphere(i);
end
fractions
hold off
plot(dims,fractions)
xlabel('wymiar')
ylabel('acceptance ratio')
title('dlaczego monte carlo sie slabiej nadaje w wielu wymiarach')


x = linspace(0,1,100)
y = x
y(x<0.5) = 4*x(x<0.5)
y(x>=0.5) = 4-4*x(x>=0.5)
N_random = 100000
random_tent = zeros(1,N_random);
for i = 1:N_random
    random_number = rand();
    acceptance_random = rand();
    while acceptance_random > tent(random_number)
        random_number = rand();
        acceptance_random = rand();
    end
    random_tent(i) = random_number;
end
[m, bin] = hist(random_tent, 100);
m = m/trapz(bin, m)
bar(bin,m)
hold on
plot(x,y)
xlabel('x')
ylabel('pdf rozkladu namiotowego')
title('von Neumann acceptance-rejection alg')
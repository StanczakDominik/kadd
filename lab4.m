a = 1
ni = 1
f = @(x) exp(-x/a)/a
F = @(x) 1-exp(-x/a)

%exp(-x/a) = 1 - F
%-x/a = ln(1-F)

InvF = @(x) -a*log(1-x)
Runiform = 0.01 + 0.99*rand(1,1000)
Rexp = InvF(Runiform)



sp1 = subplot(211)
[m, bin] = hist(Rexp, 50)
m = m/trapz(bin,m)
bar(sp1, bin, m)

x = linspace(min(Rexp), max(Rexp), 1000);
fExp = f(x);
hold on;
plot(sp1,x, fExp, '-r', 'Linewidth', 5);
legend('Histogram exp', 'Rozklad exp');
xlabel('wartość zmiennej losowej x')
ylabel('gęstość prawdopodobieństwa rozkładu wykładniczego a = 1')



sp2 = subplot(212);

g = @(x) gamma((ni + 1)/2) / (sqrt(ni*pi) * gamma(ni/2)) * (1+1/ni*x.^2).^(-(ni+1)/2);

G = @(x) quadgk(g, -Inf, x);
Runiform2 = 0.01+0.98*rand(1,1000)
Rstudent = arrayfun( @(y) fzero(@(x) (G(x)-y), 0), Runiform2)

[m, bin] = hist(Rstudent, 50);
m = m/trapz(bin,m);
bar(sp2, bin, m);
hold on
x2 = linspace(-20, 20, 1000);
plot(sp2, x2, g(x2), '-r', 'Linewidth', 5);
xlabel('wartość zmiennej losowej x')
ylabel('gęstość prawdopodobieństwa rozkładu studenta ni = 1')
legend('Histogram student', 'Rozklad student');
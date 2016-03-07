f = @(x)exp(-x/6)

Cquadgk = 1/quadgk(f, 0, Inf)

x = linspace(0,1000,100000);
dx = x(2)-x(1)
y = f(x);
Ctrapxz = 1/trapz(x, y)
Csum = 1/sum(dx*y)

Canal = 1/6


% 2.2
fx = @(x)exp(-x/6)/6
dystrybuanta = @(x)(1-exp(-x/6))

x = linspace(0,30,1000);
dx = x(2)-x(1)
tab_fx = fx(x);
tab_dyst_anal = dystrybuanta(x);
tab_dyst_cumsum = cumsum(dx * tab_fx);
tab_dyst_cumtrapz = cumtrapz(dx * tab_fx);
expected_value = quadgk(@(x)(x.*fx(x)), 0, Inf)

standard_dev = sqrt(quadgk(@(x)(x-expected_value).^2.*fx(x),0, Inf))
variance = standard_dev^2

losowe = rand(1000000, 1)*1000000;
losowe_naszrozklad = fx(losowe);
expected_value_testowy = mean(losowe_naszrozklad)
standard_dev_testowy = std(losowe_naszrozklad)
variance_testowy = var(losowe_naszrozklad)

moda = mode(fx(x)) %...?
search_kwantyla = @(x, a)(abs(dystrybuanta(x)-a))
[smiec, mediana_idx] = min(search_kwantyla(x, 0.5))
mediana = x(mediana_idx)
[smiec, kwantyl1_idx] = min(search_kwantyla(x, 0.25))
kwantyl1 = x(kwantyl1_idx)
[smiec, kwantyl3_idx] = min(search_kwantyla(x, 0.75))
kwantyl3 = x(kwantyl3_idx)

sp1 = subplot(211)
hold on
plot(sp1, x, tab_fx)
ylabel('pdf')
x_kwantyl1 = linspace(0,kwantyl1, 100);
y_kwantyl1 = fx(x_kwantyl1);
y_dyst_kwantyl1 = dystrybuanta(x_kwantyl1);
area(x_kwantyl1, y_kwantyl1)
text(kwantyl1, fx(kwantyl1), '\leftarrow 25%')

sp2 = subplot(212)
hold on
plot(sp2, x, tab_dyst_anal, '-r', 'LineWidth', 4)
plot(sp2, x, tab_dyst_cumsum,  '--g', 'LineWidth', 3)
plot(sp2, x, tab_dyst_cumtrapz,  '--b', 'LineWidth', 2)
area(x_kwantyl1, y_dyst_kwantyl1)
xlabel('x')
ylabel('cdf')
legend('Analityczny', 'Cumsum', 'Cumtrapz')
text(kwantyl1, dystrybuanta(kwantyl1), '\leftarrow 25%')


line([mediana, mediana],[0, dystrybuanta(mediana)], 'Color', 'c')
line([kwantyl1, kwantyl1],[0, dystrybuanta(kwantyl1)],'Color', 'b')
line([kwantyl3, kwantyl3],[0, dystrybuanta(kwantyl3)],'Color', 'g')
line([moda, moda], [0.5, dystrybuanta(moda)],'Color', 'r')

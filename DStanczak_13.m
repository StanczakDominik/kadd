clear all
gamma = 1;
x0 = 0;
C_trial = 1;

f = @(x, gamma, x0, C_trial) C_trial./(pi*gamma*(1+((x-x0)/gamma).^2));
x_plot = linspace(-20,20,1000);
y_plot = f(x_plot, gamma, x0, C_trial);

C = 1;
y_plot = f(x_plot, gamma, x0, C);

subplot(2,1,1);
title('rozklad gestosci funkcji')
xlabel('x')
ylabel('pdf')

y_cdf = cumtrapz(x_plot, y_plot);

N_our_randoms = 1e7;
g = @(x) f(x, gamma, x0, C);
G = @(x) quadgk(g, -Inf, x);
Runiform = 0.01+0.98*rand(1,1000);
f_Random_numbers = arrayfun( @(x) x0 + gamma*tan(pi*(x-0.5)), Runiform);


[m, bin] = hist(f_Random_numbers, 1000);
m = m/trapz(bin, m);

bar(bin, m);
hold on
plot(x_plot, y_plot, 'r-');
e_x= bin;
e_pdf = m;

emp_mean = trapz(e_x, e_x.*e_pdf);
emp_variance = trapz(e_x, e_pdf.*(e_x-emp_mean).^2);

analytical_cauchy_cdf = @(x) 1/pi * arctan((x-x0)/gamma) + 0.5;
e_cdf = cumtrapz(bin, m);

f_mean = trapz(x_plot, y_plot.*x_plot);
f_variance = trapz(x_plot, y_plot.*(x_plot-f_mean).^2);


%kwantyle teoretyczne
search_kwantyla = @(a, y)(abs(y-a));
[smiec, kwantyl1_idx] = min(search_kwantyla(0.25, y_cdf));
[smiec, kwantyl2_idx] = min(search_kwantyla(0.5, y_cdf));
[smiec, kwantyl3_idx] = min(search_kwantyla(0.75, y_cdf));
kwantyl1 = x_plot(kwantyl1_idx);
kwantyl2 = x_plot(kwantyl2_idx);
kwantyl3 = x_plot(kwantyl3_idx);

%kwantyle empiryczne
[smiec2, ekwantyl1_idx] = min(search_kwantyla(0.25, e_cdf));
[smiec2, ekwantyl2_idx] = min(search_kwantyla(0.5, e_cdf));
[smiec2, ekwantyl3_idx] = min(search_kwantyla(0.75, e_cdf));
ekwantyl1 = e_x(kwantyl1_idx);
ekwantyl2 = e_x(kwantyl2_idx);
ekwantyl3 = e_x(kwantyl3_idx);


subplot(2,1,2);
bar(bin, e_cdf);
hold on
plot(x_plot, y_cdf, 'r-');
title('dystrybuanta')
xlabel('x')
ylabel('cdf')

fprintf('z jakiegos powodu wyniki na samplach troche lataja, nie jestem pewien czemu\n');
fprintf('?\tSample\tAnalitycznie\n');
fprintf('E\t%f\t%f\n', emp_mean, f_mean);
fprintf('Var\t%f\t%f\n', emp_variance, f_variance);
fprintf('Q1\t%f\t%f\n', ekwantyl1, kwantyl1);
fprintf('Med\t%f\t%f\n', ekwantyl2, kwantyl2);
fprintf('Q3\t%f\t%f\n', ekwantyl3, kwantyl3);

clear all
gamma = 1;
x0 = 0;
C_trial = 1;

f = @(x, gamma, x0, C_trial) C_trial./(pi*gamma*(1+((x-x0)/gamma).^2));

N_randoms = 5e7;

x_plot = linspace(-20,20,1000);
y_plot = f(x_plot, gamma, x0, C_trial);

width = 10000;
random_x = -width/2 + width*rand(N_randoms, 1);
rectangle_height = 1.01*max(y_plot);
random_y = rectangle_height*rand(N_randoms, 1);
rectangle_area = rectangle_height*width;
random_x_func_values = f(random_x, gamma, x0, C_trial);
points_under_curve = sum(random_x_func_values > random_y)
ratio_points = points_under_curve/N_randoms
integral_value = ratio_points * rectangle_area

C = integral_value;
y_plot = f(x_plot, gamma, x0, C);

subplot(2,1,1);
plot(x_plot, y_plot);
title('rozklad gestosci funkcji')
xlabel('x')
ylabel('pdf')

y_cdf = cumtrapz(x_plot, y_plot);

N_our_randoms = 1e5;
g = @(x) f(x, gamma, x0, C);
G = @(x) quadgk(g, -Inf, x);
Runiform = 0.01+0.98*rand(1,1000);
f_Random_numbers = arrayfun( @(y) fzero(@(x) (G(x)-y), 0), Runiform);

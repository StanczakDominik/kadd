clear all;
r1 = csvread('dane1.csv')
x1 = r1(:, 1);
y1 = r1(:, 2);
r2 = csvread('dane2.csv')
x2 = r2(:, 1);
y2 = r2(:, 2);

subplot(4,2,1)
plot(x1, y1, 'b-')
xlabel('x')
ylabel('y')
subplot(4,2,2)
plot(x2, y2, 'r-')
xlabel('x')
ylabel('y')
N = length(r1)

dr1 = sum((r1(2:N, 1:2) - r1(1:N-1, 1:2)).^2, 2).^0.5
dr2 = sum((r2(2:N, 1:2) - r2(1:N-1, 1:2)).^2, 2).^0.5
subplot(4,2,3)
[m1, bin1] = hist(dr1, 50);
bar(bin1, m1)
xlabel('dr')
ylabel('czestosc wystapienia')
subplot(4,2,4)
[m2, bin2] = hist(dr2, 50);
bar(bin2, m2)
xlabel('dr')
ylabel('czestosc wystapienia')

n = 1:N-1
subplot(4,2,5)
avg_dr1 = cumsum(dr1)./n'
plot(n, avg_dr1)
xlabel('n ')
ylabel('srednia biezaca')
avg_dr2 = cumsum(dr2)./n'
subplot(4,2,6)
plot(n, avg_dr2)
xlabel('n ')
ylabel('srednia biezaca')

directions1 = rand(N, 1).*2*pi
directions2 = rand(N, 1).*2*pi
stepsizes1 = rand(N, 1)
stepsizes2 = randn(N,1)
x1new = cumsum(stepsizes1.*cos(directions1))
y1new = cumsum(stepsizes1.*sin(directions1))
x2new = cumsum(stepsizes2.*cos(directions1))
y2new = cumsum(stepsizes2.*sin(directions1))

r1new = zeros(N, 2)
r1new(:, 1) = x1new
r1new(:, 2) = y1new
r2new = zeros(N, 2)
r2new(:, 1) = x2new
r2new(:, 2) = y2new

csvwrite('moje_dane1.csv', r1new)
csvwrite('moje_dane2.csv', r2new)

subplot(4,2,7)
plot(x1new, y2new)
xlabel('x')
ylabel('y')
subplot(4,2,8)
plot(x2new, y2new)
xlabel('x')
ylabel('y')

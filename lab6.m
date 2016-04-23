clear all
N=1e6;
% C x^2 -> C x^3 / 3    C * 10^3 / 3   = 1
C = 3/10^3;
g = @(x) C*x.^2;
G = @(x) C*x.^3/3;

a = g(10)/10;
s = @(x)a*x;
S = @(x)a*x.^2/2;

%y = a x^2 /2
%2 y /a = x^2
%x = sqrt(2y/a)
invS = @(y) sqrt(2*y/a);


s1 = subplot(2,1,1)

our_random = zeros(1, N);
random_numbers = invS((S(10)-S(0))*rand(1,N));
acceptance_randoms = rand(1,N);
ratio = g(random_numbers)./s(random_numbers);
accepted = acceptance_randoms < ratio;

[m_backup, bin_backup] = hist(random_numbers, 100);     %histogram random numbers - losowych punktów z naszej pomocniczej dystrybucji
                                               %policzonych metodą odwrotnej dystrybuanty, z tego "łatwego" rozkładu
m_backup = m_backup/trapz(bin_backup, m_backup);        %normalizacja jak ongiś
bar(bin_backup, (S(10)-S(0)).*m_backup, "r");           %żeby to ładnie wyglądało to trzeba pomnożyć, inaczej z jakiegoś powodu jest za nisko - nie jestem pewien warum
hold on

our_random = random_numbers(accepted);
our_random = sort(our_random);
[m, bin] = hist(our_random, 100);
m = m/trapz(bin,m);
bar(bin, m, "b")                                          %zmieniony kolorek żeby było widoczne
hold on

NX = 100
x = linspace(0,10,NX);
our_cdf = cumtrapz(bin, m)
y = g(x);
plot(x,y, 'g-')                                           %kolorek
xlabel('x')
ylabel('pdf')
title('von Neumann acceptance-rejection alg')


w2 = subplot(2,1,2)
Expected = mean(our_random)
StandardDev = std(our_random)
Variance = var(our_random)
Mediana = median(our_random)
ExpectedA = quadgk(@(x) x.*g(x), 0, 10)%7.5
VarianceA= quadgk(@(x) (x-ExpectedA).^2.*g(x),0, 10);%3.75
search_kwantyla = @(x, a)(abs(G(x)-a))
[smiec, mediana_idx] = min(search_kwantyla(x, 0.5))
MedianAnalytical = x(mediana_idx)%5*2^(2/3)
StandardDevA = sqrt(VarianceA)
plot(bin,our_cdf, 'bo')
hold on
plot(x, G(x), 'r-');
xlabel('x')
ylabel('cdf')
fprintf('?\tSample\tNumerycznie\n');
fprintf('E\t%f\t%f\n', Expected, ExpectedA);
fprintf('Std\t%f\t%f\n', StandardDev, StandardDevA);
fprintf('Var\t%f\t%f\n', Variance, VarianceA);
fprintf('Med\t%f\t%f\n', Mediana, MedianAnalytical);
pause

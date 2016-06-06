clear all;

W = @(x) x.^3 - 2*x + 1

x = 0:0.1:4;
n = length(x);

stds = [0.1, 0.5, 2];

stopien = 3
n = length(x);
A = ones(n, 2);
for i = 2: stopien+1
    A(:, i) = x.^(i-1);
end



for std=stds
    h = figure();
    y = W(x) + randn(1, n)*std;
    disp(std)
    H = diag(1./(ones(1, n)*std))
    c = H * y';
    Aprime = H * A;
    G = (Aprime'*Aprime)^(-1);
    P = G * (Aprime' * c);
    p = P(length(P):-1:1)'
    %p = polyfit(x, y, 3);   %zostawiam z powodu powyzszego komentarza implementacje matlabowską
    disp(p - [1, 0, -2, 1]) %dla duzego szumu znacznie pogarsza sie dofitowanie, zwlaszcza stala przy x^3
    plot(x, y, 'bo');
    hold on;
    y_fit = polyval(p, x);
    plot(x, y_fit, 'b-');
    title(std);
    xlabel('x');
    ylabel('y');

    
end
function [chi2] = lab13_fit(x, y, dy, stopien)
    n = length(x);
    A = ones(n, 2);
    for i = 2: stopien+1
        A(:, i) = x.^(i-1);
    end
    H = diag(1./dy);
    c = H * y';
    Aprime = H * A;
    G = (Aprime'*Aprime)^(-1);
    P = G * (Aprime' * c);
    p = P(length(P):-1:1);
    x_fit = -1:0.1:1;
    y_fit = polyval(p, x_fit);
    figure();
    plot(x, y, 'bo');
    hold on;
    plot(x_fit, y_fit);
    title(stopien);
    xlabel('x');
    ylabel('y');

    y_chi2 = polyval(p, x);
    chi2 = sum((y-y_chi2).^2 ./y_chi2);
    dof = n - 1 - 1 - stopien;
    chi2 = chi2 / dof;
end
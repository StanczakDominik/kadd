clear all
load('data.mat')
X = zeros(11, 4);
Y = zeros(11, 4);
korelacje = zeros(4, 1)
for i = 1:4
    X(:, i) = data(:,2*i-1);
    Y(:, i) = data(:,2*i);
    korelacje_this =corrcoef(X(:, i), Y(:, i))
    korelacje(i) = korelacje_this(1,2)
    
    
    h = subplot(2,2,i)
    scatter(h, X(:, i), Y(:, i))
    hold on
    p = polyfit(X(:,i), Y(:,i), 1)
    x_fit = 3:0.1:22;
    y_fit = polyval(p, x_fit)
    plot(x_fit, y_fit, 'r-')
    title(h, i)
    xlabel(h,'x')
    ylabel(h,'y')
end
l=legend(h, 'punkty', 'dopasowanie');
set(l,'Location','SouthEast');
srednie_x = mean(X,1);
srednie_y = mean(Y,1);
wariancje_x = var(X,1,1);
wariancje_y = var(Y,1,1);
korelacje
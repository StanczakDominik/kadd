sigma_x = 1;     %stdx
sigma_y = 1;     %stdy
mu_x = 0;        %EX
mu_y = 0;        %EY
rho = 0.0;         %Cor
f = @(x,y) 1/(2*pi*sigma_x*sigma_y*sqrt(1-rho.^2)).*exp(-((x-mu_x).^2/sigma_x.^2+(y-mu_y).^2/sigma_y.^2-2.*rho.*(x-mu_x).*(y-mu_y)/(sigma_x.*sigma_y))/(2.*(1-rho.^2)));


min_lim = -5;
max_lim = 5;
N = 101;

x = linspace(min_lim,max_lim,N);
dx = x(2)-x(1);
y = linspace(min_lim,max_lim,N);
dy = y(2)-y(1);
[X,Y] = meshgrid(x,y);

F = f(X,Y);
FX = cumsum(cumsum(F,1),2)*dx*dy;

fx = sum(F, 2)*dx;
fy = sum(F, 1)*dy;

EX = sum(sum(F.*X))*dx*dy;
EY = sum(sum(F.*Y))*dx*dy;
EXY = sum(sum(X.*Y.*F))*dx*dy;
VarX = sum(sum((X-EX).^2.*F))*dx*dy;
VarY = sum(sum((Y-EY).^2.*F))*dx*dy;
SigmaX = sqrt(VarX);
SigmaY = sqrt(VarY);

Cov = EXY - EX.*EY;
Cor = Cov/SigmaX/SigmaY;   %aka rho

C11 = VarX;
C12 = Cor*SigmaX*SigmaY;
C21 = C12; %macierz symetryczna
C22 = VarY;

EXString = ['EX:' num2str(mu_x) ' obliczone: ' num2str(EX)];
EYString = ['EY:' num2str(mu_y) ' obliczone: ' num2str(EY)];
STDXString = ['STD_x', num2str(sigma_x), ' obliczone: ', num2str(SigmaX)];
STDYString = ['STD_y', num2str(sigma_y), ' obliczone: ', num2str(SigmaY)];
CorString = ['Korelacja:', num2str(rho), ' obliczona: ', num2str(Cor)];

Covariance=[[C11 C12]; [C21 C22]];
CovarianceInitial=[[sigma_x^2 rho*sigma_x*sigma_y];[rho*sigma_x*sigma_y sigma_y^2]];

disp('Macierz kowariancji');
disp(CovarianceInitial);
disp('Obliczona:');
disp(Covariance);

w1 = subplot(2,2,1);
surf(X,Y,F)
title('PDF')
xlabel('x')
ylabel('y')
zlabel('PDF')

w2 = subplot(2,2,2);
surf(X, Y, FX)
title(CorString)
xlabel('x')
ylabel('y')
zlabel('CDF')

w3 = subplot(2,2,3);
plot(x, fx)
title('Brzegowy (x)');
xlabel('x')
ylabel('f(x)')
text(min_lim, 0.1, EXString)
text(min_lim, 0, STDXString)

w4 = subplot(2,2,4);
plot(y, fy)
title('Brzegowy (y)')
xlabel('y')
ylabel('f(y)')
text(min_lim, 0.1, EYString)
text(min_lim, 0, STDYString)
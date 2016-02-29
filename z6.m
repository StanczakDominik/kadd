F = @(x)sin(x)

calka3 = quad(@sin, 0, pi)

A =[12 3 2; 1 1 -1; 7 0 1]
f = [0; 0; 1]
inv(A)*f

dowolnywektor = linspace(10,0,20)
srednia = mean(dowolnywektor)
maksimum = max(dowolnywektor)
minimum = min(dowolnywektor)
mediana = median(dowolnywektor)
posortowanydowolnywektor = sort(dowolnywektor)
suma = sum(dowolnywektor)
iloczyn = prod(dowolnywektor)

wyniksilni = silnia(5)

[X,Y,Z] = meshgrid(-2:0.25:2, -2:0.25:2, -2:0.25:2)
Macierz3D = X.*exp(-X.*X-Y.*Y-Z.*Z)

x = linspace(0,pi,1000)
dx = pi/1000.0
sinx = sin(x)
dsinx = diff(sinx)/dx
plot(x, sinx, x(1:end-1), dsinx)

[l, k] = contourf(X(:, :, 3), Y(:, :, 3), Macierz3D(:, :, 3))
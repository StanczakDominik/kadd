function [x, y] = galton(N)
	N = N
	x = 0;
	y  = 0;
	for i = 1:N
		xx = -(N-i):2:((N-i)+2);

		n = length(xx);
		x(end:end+n-1) = xx;
		y(end:end+n-1) = ones(1, n)*(i);
	end
	x = x(1:end-1);
	y = y(1:end-1);
end
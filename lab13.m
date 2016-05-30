clear all;
x = [-0.9, -0.7, -0.5, -0.3, -0.1, 0.1, 0.3, 0.5, 0.7, 0.9]
y = [2, 60, 89, 102, 99, 106, 142, 215, 334, 532];
dy = [2, 8, 4, 10, 8, 15, 5, 8, 15, 20];
n = length(x)

chi2_cutoff = [3.841, 5.991, 7.815, 9.488, 11.070, 12.592, 14.067, 15.507, 16.919, 18.307, 19.675, 21.026, 22.362, 23.685, 24.996, 26.296, 27.587, 28.869, 30.144, 31.410, 32.671, 33.924, 35.172, 36.415, 37.652];
for i = 1:n
    dof = n - 1 - 1 - i;
    chi2wynik = lab13_fit(x, y, dy, i);
    if chi2wynik < chi2_cutoff(i)
        str = 'na poziomie istotnosci 5 proc. mozemy opisac dane wielomianem stopnia %d: wyszlo %f do granicy %f';
        str = sprintf(str, i, chi2wynik,  chi2_cutoff(i));
        disp(str)
        break
    else
        str = 'na poziomie istotnosci 5 proc. NIE mozemy opisac danych wielomianem stopnia %d: wyszlo %f do granicy %f';
        str = sprintf(str, i, chi2wynik,  chi2_cutoff(i));
        disp(str)
    end
end
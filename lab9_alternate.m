clear all
k = [0 1 2 3 4 5 6 7 8]
nk = [47 69 84 76 49 16 11 3 0]
errors = nk.^(1/2)
errorbar(k, nk, errors, 'xr');
norm_nk = sum(nk)
nk = nk/sum(nk);
mean = sum(nk.*k)./sum(nk) %moznaby pominac
poisson = @(x, lambda) lambda.^x .* exp(-lambda)./gamma(x+1);

fit_k = linspace(0, 8, 1000);
fit_poisson = poisson(fit_k, mean)*norm_nk
hold on
plot(fit_k, fit_poisson)
xlabel('liczba par elektronowych w "binie"')
ylabel('PRAWDOPODOBIENSTWO liczby zliczen')
text(4, 80, strcat('wartosc oczekiwana rozkladu:',num2str(mean)))

fit_poisson_do_chi2 = poisson(k, mean);
hold on
plot(k, fit_poisson_do_chi2*norm_nk, 'ko')

chi2_value = sum((fit_poisson_do_chi2-nk).^2 ./ fit_poisson_do_chi2)

degrees_freedom = length(k)-2 %srednia jest szacowanym parametrem
chi2_test_value = chi2_value/degrees_freedom
chi2_cutoff_value = 1.239    %https://faculty.elgin.edu/dkernler/statistics/ch09/images/chi-square-table.gif

if chi2_test_value < chi2_cutoff_value
    disp('na poziomie istotnosci 1% mozemy opisac dane rozkladem poissona')
else
    disp('na poziomie istotnosci 1% NIE mozemy opisac danych rozkladem poissona')
end
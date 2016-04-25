clear all

chi2_arr=[3.84146,5.99146,7.81473,9.48773,11.0705,12.5916,14.0671,15.5073,16.9190, 18.3070, 19.6751, 21.0261, 22.3620, 23.6848];

N_random = 10000
gauss_func = @(x, std, mean)1./std./(2.*pi).^(1/2).*exp(-(x-mean).^2./2./std.^2);
convolution_arr = ones(1, N_random);
running_convolution = convolution_arr;

for liczba_zlozen = 1:50
    random = rand(liczba_zlozen+1, N_random);
    running_random_sum = sum(random, 1)/(liczba_zlozen+1);

    running_convolution = conv(running_convolution, convolution_arr);

    [sum_m, sum_bin] = hist(running_random_sum, 60);
    sum_m = sum_m / trapz(sum_bin, sum_m);
    conv_x = 0: 1/length(running_convolution) : 1-1/length(running_convolution);
    running_convolution = running_convolution / trapz(conv_x,running_convolution);

    % bar(sum_bin, sum_m);
    % hold on;
    % plot(conv_x, running_convolution, 'r');
    % hold on;

    gauss_std = std(running_random_sum);
    gauss_mean = mean(running_random_sum);

    fit_gauss = gauss_func(conv_x, gauss_std, gauss_mean);
    % plot(conv_x, fit_gauss, 'g');
    % hold off

    chi2 = sum((fit_gauss - running_convolution).^2./fit_gauss)
    chi_target = chi2_arr(liczba_zlozen)
    if chi2 < chi_target
        printf('liczba zlozen: %d', liczba_zlozen);
        break
    end
end

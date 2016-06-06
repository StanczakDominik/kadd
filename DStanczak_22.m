clear all;

Nballs = [10, 10^2, 10^5];

chi2_cutoffs_dof_27 = [11.808 12.879 14.573 16.151 18.114 36.741 40.113 43.195 46.963 49.645];
for i=Nballs;
    filename_bins = sprintf('galton_%d_bins.csv', i);
    filename_m = sprintf('galton_%d_m.csv', i);
    bin = csvread(filename_bins);
    dx = bin(2) - bin(1);
    m = csvread(filename_m); 
    mean_val = sum(bin.*m * dx);
    std_val = sqrt(sum((bin-mean_val).^2.*m * dx));
    
    bar(bin, m)
    hold on    
    x_g = min(bin):0.001:max(bin);
    y_g = exp(-(x_g-mean_val).^2/(2*std_val.^2))/(std_val.*sqrt(2*pi));
    %plot(x_g, y_g, 'r-');
    %hold off
    %pause
    hold on
    m_fit = exp(-(bin-mean_val).^2/(2*std_val.^2))/(std_val.*sqrt(2*pi));
    plot(bin, m_fit)
    hold off
    
    chi2 = sum((m-m_fit).^2 ./m_fit);
    dof = length(m) - 1 - 2
    chi2 = chi2 / dof
    
    if(chi2 < chi2_cutoffs_dof_27)
        disp(sprintf('na poziomie istotnosci 5 procent (ufnosci 95 procent) mozemy opisac histogram dla %d kul gaussianem', i))
    else
        disp(sprintf('na poziomie istotnosci 5 procent (ufnosci 95 procent) NIE mozemy opisac histogramu dla %d kul gaussianem', i))
    end
    pause
end 
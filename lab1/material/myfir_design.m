function [bi, bq]=myfir_design(N,nb)
%% start up routine
% Modifica la grandezza del titolo rispetto al font degli assi
set(groot, 'DefaultAxesTitleFontSizeMultiplier', 1.5);
% Imposta il font di default degli assi
set(groot, 'DefaultAxesFontSize', 14);
% Imposta il font di default per il testo
set(groot, 'DefaultTextFontSize', 14);
%% function myfir_design(N,nb)
%% N is order of the filter
%% nb is the number of bits
%% bi taps represented as integers

close all;

f_cut_off = 2000; % 2kHz
f_sampling = 10000; % 10kHz

f_nyq = f_sampling/2; %% Nyquist frequency
f0 = f_cut_off/f_nyq; %% normalized cut-off frequency

b=fir1(N, f0); %% get filter coefficients
[h1, w1]=freqz(b); %% get the transfer function of the designed filter

bi=floor(b*2^(nb-1)); %% convert coefficients into nb-bit integers


bq=bi/2^(nb-1); %% convert back coefficients as nb-bit real values

%bq = b; %for floating point computing coeff

[h2, w2]=freqz(bq); %% get the transfer function of the quantized filter

%% show the transfer functions
figure('Name','My fir design');
plot(w1/pi, 20*log10(abs(h1)),'LineWidth',2); 
hold on;
plot(w2/pi, 20*log10(abs(h2)),'r--','LineWidth',2);
grid on;
title('My fir design');
xlabel('Normalized frequency');
ylabel('dB');
legend('Floating point','Fixed point');






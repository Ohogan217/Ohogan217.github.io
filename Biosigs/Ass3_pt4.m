clc
close all
clear
%clear all values, plots and command window

T = 10;% time is 10s
fs = 300; % sampling frequency is 300Hz
tstep = 1/fs; %calculate the time step
t = (tstep:tstep : T); % create time array
f = (0.2: 0.2: 100); % create frequency array
A = 1./f; % create amplitude array
cossum = zeros(1, length(t)); % initialise cosine sum array

for j = 1:length(t) % for loop to create value for each time step
    for i = 1:length(f) % for loop to sum all cosines together
       cossum(j) = cossum(j) + A(i)*cos(f(i)*t(j)*2*pi); % add previous total to a*cosWt, where W is equal to 2*pi*f 
    end
end

fc = 10; %cut off frequency = 10 Hz
Wn = fc/(fs/2); %the cut off frequecny as a factor of fs/2 
[B, A] = butter(3,Wn); % get filter constants

filtcos = filtfilt(B, A, cossum); % filter cossum

figure% plot of filtered vs unfiltered signal
plot(t, cossum, 'b.-')
hold on
plot(t, filtcos, 'r.-')
title('Signal vs filtered Signal')
ylabel('Value')
xlabel('Time (s)')
legend('Unfiltered', 'Filtered')

% calculate the amplitude and Phase of the original signal
ampcossum = abs(fft(cossum));
angcossum = fftshift(ampcossum);
%calculate the amplitude and phase of the filtered signal
ampfcos = abs(fft(filtcos));
angfcos = fftshift(ampfcos);

figure % plot the amplitudes
plot(ampcossum)
hold on 
plot(ampfcos)
title('Amplitude of Signal vs filtered Signal')
ylabel('Amplitude')
xlabel('Time (s)')
legend('Unfiltered', 'Filtered')

figure% plot the Phases
plot(angcossum)
hold on 
plot(angfcos)
title('Phase of Signal vs filtered Signal')
ylabel('Phase')
xlabel('Time (s)')
legend('Unfiltered', 'Filtered')

%calucalte the filter response
figure
freqz(B, A, 1000)
title('Magnitude of Filter Response')


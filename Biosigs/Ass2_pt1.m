fs = 48; % sampling frequency
t = 12; % time
intl = 6.73; % start of elevated part
intu = 9.52; % end of elevated part
aint = 3.5; % value of elevated part
tstep = 1/fs; % time step
T = 0:tstep:t; % time array 

x = zeros(size(T)); % create signal as specifiec
intlt = find(abs(T - intl) < 0.01);
intut = find(abs(T - intu) < 0.01);
x(intlt:intut) = aint;

n = length(x);
y = abs(fft(x)); % let y = the filtered x
fy = (0:n-1)/n; % the frequencies of y
phase  = fftshift(y); % get the phase of y
fphase = [-n/2: n/2-1]/n; % get frequencies of phase of y

tiledlayout(3,1)
nexttile % plot x
plot(x)
title('Original signal')
xlabel('time (s)')
nexttile
plot(fy, y)
title('Signal Magnitude')
ylim([0, 500])
xlabel('frequency (Hz)')
nexttile
plot(fphase, phase)
title('Signal Phase')
ylim([0, 500])
xlabel('frequency (Hz)')
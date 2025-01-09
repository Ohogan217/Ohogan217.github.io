fcos = 2.38; % frequency of sine wave
t = 10;
tsamp = 1/100; % sampling time
T = [0:tsamp:t];
offset = 23; % phase offset in degrees
x1 = 4*cosd(fcos*T*180 + offset); % cosine array
n1 = 1000; % lower sampling frequency
n2 = 4000; % higher sampling frequency
x11k = abs(fft(x1, n1)); % filtered for magnitude of x1 at 1000 Hz
x14k = abs(fft(x1, n2));% filtered for magnitude of x1 at 4000 Hz
f1 = [0:n1-1]/n1; % Frequencies range of 1
f2 = [0:n2-1]/n2;% Frequencies range of 2
tiledlayout(3,2)
%plot x1 at 1000Hz sample
nexttile
plot(f1, x11k, 'b'),ylim([ 0 2100])
title('x1 sampled at 1000Hz')
nexttile 
%plot x1 at 400Hz sample
plot(f2, x14k, 'r'),ylim([0 2100])
title('x1 sampled at 4000Hz')

fcos2 = 2.5;% 2nd cosine frequency
offet2 = 45; % second cosine phase offset
x2 = 3*cosd(fcos2*T*180 + offet2); % x2
xtot = x1+x2; % calculate xtot
xtot1k = abs(fft(xtot, n1)); % sampled at 1000Hz
xtot4k = abs(fft(xtot, n2));% sampled at 4000Hz

nexttile
%plot xtot at 1000Hz
plot(f1, xtot1k, 'b'),ylim([0 1600])
title('xtot sampled at 1000Hz')

nexttile
%plot xtot at 4000Hz
plot(f2, xtot4k, 'r'),ylim([0 1800])
title('xtot sampled at 4000Hz')
% calculate the phase of xtot for both sample frequencies
xtot1k = fftshift(xtot1k);
xtot4k = fftshift(xtot4k);
% plot phase diagrams of xtot
nexttile
plot(f1, xtot1k, 'b'),ylim([0 1700])
title('Phase of xtot sampled at 1000Hz')
nexttile 
plot(f2, xtot4k, 'r'),ylim([0 1700])
title('Phase of xtot sampled at 4000Hz')

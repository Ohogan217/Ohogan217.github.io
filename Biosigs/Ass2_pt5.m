%for impulse
len = 10; % array length
x1 = zeros(len,1); % initalise x1
x1(1) = 1; % add impulse
y1 = zeros(len,1); % initialise output 1

for n = (1: len) % for loop to calculate output
    if n == 1 % if statements used to account for x(-3), x(-2), and x(-1), letting them equal 0
        y1(n) = x1(n); 
    elseif n == 2
        y1(n) = x1(n) + 1.2*x1(n-1);
    elseif n == 3
        y1(n) = x1(n)+ 1.2*x1(n-1) + .1*x1(n-2);
    else
        y1(n) = x1(n) + 1.2*x1(n-1) + .1*x1(n-2)+ 0.01*x1(n-3);
    end
end
% for cosines
fs = [0.5, 20, 100]; % arrays of frequencies
fsamp = 250; % sampling frequency
tstart = 0; % starting time
tend = 3; % finishing time
t = (tstart:1/fsamp :tend); % time array
sig1 = cos(2*pi*t*fs(1)); % signal 1
sig2 = cos(2*pi*t*fs(2)); % signal 2
sig3 = cos(2*pi*t*fs(3)); % signal 3

x2 = [sig1; sig2; sig3]; % array of signals
y2 = zeros(size(x2)); % array of outputs 
len = length(sig1); % get length of signal and set to length
for m = 1:3 %for loop used to do all three signals efficiently
    for n = (1: len) % same process to calculate outputs as was done above
        if n == 1
            y2(m,n) = x2(m,n);
        elseif n == 2
            y2(m,n) = x2(m,n) + 1.2*x2(m,n-1);
        elseif n == 3
            y2(m,n) = x2(m,n)+ 1.2*x2(m,n-1) + .1*x2(m,n-2);
        else
            y2(m,n) = x2(m,n) + 1.2*x2(m,n-1) + .1*x2(m,n-2)+ 0.01*x2(m,n-3);
        end
    end
end
% plot impulse response
figure(1)
plot(x1, 'r-')
hold on 
plot(y1, 'b-')
title('Filtered response to Impulse')
%plot cosine response, in a separate figure
figure(2)
tiledlayout(3,1)
nexttile
plot(x2(1,:), 'r-')
hold on 
plot(y2(1,:), 'b-')
title('Filtered response to cosine wave of f = 0.5Hz')

nexttile
plot(x2(2,:), 'r-')
hold on 
plot(y2(2,:), 'b-')
title('Filtered response to cosine wave of f = 20Hz')

figure()
%plot(x2(3,:), 'r-')
title('Filtered response to cosine wave of f = 100Hz')
hold on 
plot(y2(3,:), 'b-')

a = load('C:\Users\Oisin\Documents\MATLAB\Signal processing\EvokedPotential.mat'); % load file as 'a'
b = a.EvokedPotential;%let 'b' equal the evoked potential part of 'a'
l = size(b); % let 'l' equal the size of 'b'
t = [-100:650]; % let t range from -100 to 650 ms
plot(t, b)% plot 'b' against 't', each 1 on the x axis is equal to 1 ms
xlabel('time - ms')% label the x axis as time in ms
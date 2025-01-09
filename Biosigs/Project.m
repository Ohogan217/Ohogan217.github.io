clc
clear
close all% clear the command windows, workspace and figures
 
load("G:\My Drive\engineering_work\Biosigs\Project\ecgproject.mat")% load in ecg file
%Part 1
fs = 200; 
fn = fs/2;
N = length(ecg1);
t = (0:1:N-1)/fs;% establish constants for the sampling and nyquist frequencies, and the time domain of the signal
figure()
plot(t, ecg1)
title('Plot of ECG Signal in Time Domain')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
%xlim([1,2])

%part 2 - filtering
ecgang1 = fft(ecg1);
ecgang1 = fftshift(abs(ecgang1));
f = (-N/2:1:N/2-1)/N;
f = f*fs;% create frequency domain array and a fourrier transform of the ECG signal to the frequency domain

figure()% create a new figure for the output of task 2
tiledlayout(3,2)
nexttile
plot(t, ecg1)
title('Plot of ECG Signal in Time Domain')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
%xlim([1,2])
nexttile
plot(f, ecgang1)
title('Plot of ECG Signal in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude(dB)')
xlim([0, fs/2])

fcolow = 1;% choose high pass cut off frequency
wh = fcolow/fn; %] calcualte the adjusted frequency
[b,a] = butter(3, wh, 'high'); % get constants, 'a' and 'b'

ecg2 = filtfilt(b, a, ecg1); % Filter ecg
ecgang2 = abs(fft(ecg2)); %get the frequencies of filtered ecg
ecgang2 = fftshift(ecgang2);

nexttile
plot(t, ecg2)
title('Plot of ECG Signal in Time Domain')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
%xlim([1,2])
nexttile
plot(f, ecgang2)
title('Plot of ECG Signal in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude(dB)')
xlim([0, .5*fs]) %plot the filtered ecg in the time and frequency domains

fcohigh  = 30; %set the frequency for the lowpass filter 
wl = fcohigh/fn;
[b,a] = butter(3, wl);
ecg3 = filtfilt(b,a, ecg2);
ecgang3 = fft(ecg3);
ecgang3 = fftshift(abs(ecgang3)); % filter the ecg and obtain the fourier transform of the signal

nexttile
plot(t, ecg3)
title('Plot of ECG Signal in Time Domain')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
%xlim([1,2])
nexttile
plot(f, ecgang3)
title('Plot of ECG Signal in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude(dB)')
xlim([0, fs/2]) % plot final filtered signal in the time and frequency domain

%Part 3 - Segmentation
fband = [5, 15]/fn; % for the first part of the PT method, the filter pass band was established
[b,a] = butter(3, fband);
ecg4 = filtfilt(b, a, ecg3);% filter ecg with the passband frequencies

figure()
tiledlayout(2,1)
nexttile
plot(t, ecg4)
title('PT Method Part 1')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
nexttile
plot(t, ecg4)
xlim([1,2])
title('PT Method Part 1 (Zoomed in)')
xlabel('Time(s)')
ylabel('Amplitude(mV)')% create a new figure to plot the filtered signal as a whole and zoomed in

ecg5 = diff(ecg4);
dt = t(1:N-1); % differentiate the filtered signal

figure()
tiledlayout(2, 1)
nexttile
plot(dt, ecg5)
title('PT Method Part 2 (Zoomed in)')
xlabel('Time(s)')
ylabel('Amplitude(mV/s)')
xlim([1,2])%plot zoomed in differentiated signal

nexttile
ecg6 = ecg5.^2;% square signal
plot(dt, ecg6)
title('PT Method Part 3 ,4 & 5 (Zoomed in)')
xlabel('Time(s)')
ylabel('Amplitude(mV/s ^2)')
xlim([1,2]) % plot zoomed in squared signal
hold on

fsa = round(fs*.15); % set adjusted frequency for averaging each .15 seconds of the ecg
coeffavg = ones(1, fsa)/fsa; % create 'b' coefficient for the filtering of the signal
ecg7 = filtfilt(coeffavg, 1, ecg6); %filter the signal
plot(dt, ecg7)% plot the filtered signal over the other signal

noisesig = ecg7(1.1*fs:1:1.3*fs); % create an array of the signal where there is only noise

threshmean = mean(noisesig); % find the mean of the noise
threshsd = std(noisesig);% find the standard deviation of the noise
thresh = threshmean+6*threshsd; % experimentally it was foudnd that 6 standard deviations of the mean yielded 399 intances of signals being caught
%this was the threshold of amplitude
gorl = zeros(1, N-1);%create an array to see if the threshold has been passed or not
for i = (1:N-2)
    if ecg7(i)>thresh
        gorl(i) = 1;
    end
end % for loop and if statement to fill out gorl array
insts = find((diff(gorl))>0);% find the intances where the threshold is passed, in samples
plot(dt, gorl*10^4) % plot this data on the same graph as the parts 3 and 4

n = length(insts);
bw = 300;
bundle = zeros(bw, n-1);
%bundle = zeros(bw, n);
for j = 1:n-1
    for i = 1:bw
        if i +insts(j)<insts(j+1)
            bundle(i, j) = ecg3(i +insts(j));
        else
            break
        end
    end
end

figure()
plot(bundle)
title('Bundles of heart beats')
xlabel('Samples')
ylabel('Amplitude (mV)') %Plot each epoch on the same axis in order to identify differences between the PVC and normal contraction

%step 4 and 5 - Classification

%method 1- S wave analysis
compsampno = 74; %select time for amplitude to be measured on
ampthresh = -140; % set cut off amplitude
tfswave = zeros(n-2, 1); %create a 0's array for results
for i = 1:n-2
   if bundle(compsampno, i)<ampthresh  
       tfswave(i) = 1;
   end
end % for loop to generate answer set 
% compare results
tp = 0;
tn = 0;
fp = 0;
fn = 0; % initialise the final answer variables
for i = 1:length(tfswave)
    if tfswave(i)== 1&& isPVC(i) ==1
        tp = tp+1;
    end
    if tfswave(i)== 1&& isPVC(i) ==0
        fp = fp+1;
    end
    if tfswave(i)== 0&& isPVC(i) ==0
        tn = tn+1;
    end
    if tfswave(i)== 0&& isPVC(i) ==1
        fn = fn+1;
    end
end %work out the amount of true and false positive and negative answers
acc = (tp+tn)*100/ (tp+tn+fp+fn); % calcualte accuracy
resultssw = {'True Positive', 'True Negative', 'False Positive', 'False Negative', 'Accuracy' ;tp, tn, fp, fn, acc};% create a dataframe of the results of this method

%method 2 R-R length
rrlegth = 140;% select a cut off length of 140 samples
tfrlen = zeros(n-2, 1);
for i = 1:n-2  
   len = max(find(bundle(:, i)));% calculate the length of the line in question
   line = bundle(1:len, i); %take out the nonzero numbers from the line
   if length(line)>rrlegth  
       tfrlen(i) = 1;
   end
end
% compare results
tp = 0;
tn = 0;
fp = 0;
fn = 0;
for i = 1:length(tfrlen)
    if tfrlen(i)== 1&& isPVC(i) ==1
        tp = tp+1;
    end
    if tfrlen(i)== 1&& isPVC(i) ==0
        fp = fp+1;
    end
    if tfrlen(i)== 0&& isPVC(i) ==0
        tn = tn+1;
    end
    if tfrlen(i)== 0&& isPVC(i) ==1
        fn = fn+1;
    end
end
acc = (tp+tn)*100/ (tp+tn+fp+fn);
resultsrl = {'True Positive', 'True Negative', 'False Positive', 'False Negative', 'Accuracy' ;tp, tn, fp, fn, acc};% fill out results array in the same way as in method 1

%method 3- R Peak Amplitude Analysis
ampthresh = 700;% set an amplitude threshold of 700 mV
rpawave = zeros(n-2, 1);
for i = 1:n-2
   maxamp = max(bundle(:, i));% find the maximum peak value in each epoch
   if maxamp>ampthresh  
       rpawave(i) = 1;
   end
end
% compare results
tp = 0;
tn = 0;
fp = 0;
fn = 0;
for i = 1:length(rpawave)
    if rpawave(i)== 1&& isPVC(i) ==1
        tp = tp+1;
    end
    if rpawave(i)== 1&& isPVC(i) ==0
        fp = fp+1;
    end
    if rpawave(i)== 0&& isPVC(i) ==0
        tn = tn+1;
    end
    if rpawave(i)== 0&& isPVC(i) ==1
        fn = fn+1;
    end
end
acc = (tp+tn)*100/ (tp+tn+fp+fn);
resultsra = {'True Positive', 'True Negative', 'False Positive', 'False Negative', 'Accuracy' ;tp, tn, fp, fn, acc};%cacluate results in the same method as method 1 and 2

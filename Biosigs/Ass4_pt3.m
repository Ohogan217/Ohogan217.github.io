clear
clc
close all% clear the command windows, workspace and figures
load("G:\My Drive\engineering_work\Biosigs\Lab 4\noisy_EMG.mat")% load the EMG file

Fs = 1000; % smapling frequency
Fn = Fs/2; % nyquist frequency
Fint = 50; % the frequency of interference (power line)
len = length(noisy_EMG); % number of samples
tiledlayout(5,2) % tiled layout
%1)
nexttile % plot the noisy emg in the frequency and time domain
plot(noisy_EMG)
title('Noisy EMG signal')
ylabel('Amplitude (mV)')
xticks([])
noisy_EMGf = abs(fft(noisy_EMG));
noisy_EMGf = fftshift(noisy_EMGf);
f = (-len:2:len-1)*Fn/len;
nexttile
plot(f, noisy_EMGf)
title('Noisy EMG Frequencies')
ylabel('Magnitude (dB)')
xticks([])
xlim([0, Fs])
%2)
Fc = Fint;% notch filter routine for power line interference at 50 Hz
wo = Fc/Fn; 
bw = wo/30; 
[b,a] = iirnotch(wo,bw); 
middenemg = filtfilt(b, a, noisy_EMG);
nexttile % plot emg without 50 Hz interference in time and frequency domain
plot(middenemg)
xticks([])
title('Noisy EMG signal, w/o 50Hz interference')
ylabel('Amplitude (mV)')
nexttile
fmiddenemg = abs(fft(middenemg));
fmiddenemg = fftshift(fmiddenemg);
plot(f, fmiddenemg)
title('Noisy EMG w/o 50Hz interference Frequencies')
ylabel('Magnitude (dB)')
xticks([])
xlim([0, Fs])
n = 5; %choose order of butterworth filter
Fc = [20, 450]; % choose range of useful frequencies
Wn = Fc/Fn;% calculate the normalised frequency
[b,a]=butter(n,Wn, 'stop');  %butterworth band stop filter
ignorefreqs = filtfilt(b, a, middenemg); % filter the useful parts out
clean_emg = middenemg - ignorefreqs*(.7);%generate the clean emg by scaling and subtracting the ignored frequencies from the noisy emg
nexttile% plot clean emg in the time and frequency domains
plot(clean_emg)
xticks([])
title('Clean EMG Signal')
ylabel('Amplitude (mV)')
nexttile
fclean_emg = abs(fft(clean_emg));
fclean_emg = fftshift(fclean_emg);
plot(f, fclean_emg)
title('Clean EMG Frequencies')
ylabel('Magnitude (dB)')
xticks([])
xlim([0, Fs])
%% 3)
absemg = abs(clean_emg);%get the absolute value of the emg
nexttile% plot the absolute emg in the time and frequency domains
plot(absemg);
xticks([])
title('EMG Envelopes')
ylabel('Amplitude (mV)')
nexttile
fabsemg = abs(fft(absemg));
fabsemg = fftshift(fabsemg);
plot(f, fabsemg)
title('EMG Envelopes Frequencies')
ylabel('Magnitude (dB)')
xticks([])
xlim([0, Fs])
Fc = .8;%pick frequencies to filter the envelopes of the signal
Wn = Fc/Fn;%normalise
[b,a]=butter(n,Wn); %fitler constants
emgenv = filtfilt(b, a, absemg);%filter and obtain envelopes
%4) - 6)
gorlthresh = zeros(len,1);%initialise a zeros array for whether there is a signal or not
n = 3;%number of standard deviations from mean for cut off frequency
avg5 = mean(emgenv(1:Fs*5)); % find the mean of the first 5 seconds of just noise
sd5 = std(emgenv(1:Fs*5),1); % find the standard deviation of the first 5 seconds of noise
threshold = avg5+n*sd5; % Calculate the amplitude threshold = mean + n*standard deviation
for i = 1:len-1 %for loop to set the gorlthresh array equal to 1 if the signal is greater than the threshold
    if emgenv(i)>threshold
        gorlthresh(i) = 1;
    end
end
nexttile%plot the envelopes in the time and freuqency domain, as well as whether or not the signal is active on the time domain
yyaxis left
plot(emgenv)
title('EMG Envelopes and Activation Signal')
xlabel('Time (samples)')
ylabel('Amplitude (mV)')
hold on
yyaxis right
ylabel('Activated (0/1)')
ylim([0, 1.1])
plot(gorlthresh)

nexttile
femgenv = abs(fft(emgenv));
femgenv = fftshift(femgenv);
plot(f, femgenv)
title('EMG Envelopes and Activation Signal Frequencies')
xlabel('Frequecny (Hz)')
ylabel('Magnitude')
xlim([0, Fc])

insts = find((diff(gorlthresh))>0)/Fs;
insts
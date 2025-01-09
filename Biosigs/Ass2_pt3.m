load("C:\Users\Oisin\Documents\engineering_work\Signal\Lab 2\ecg.mat"); % load file
fsamp = 500; %sampling frequeny
amp = 500; % amplication factor
ecg = (ecg/amp)*1000; %scale ecg
Necg = length(ecg); % get the length of the ecg
t = [0:1/fsamp:(Necg(1)-1)/fsamp]; % get a time array

tiledlayout(3,1)
nexttile % plot the ecg
plot(t, ecg)
title('ECG signal')
xlabel('Time (s)')
ylabel('Voltage (mv)')

nexttile % plot 1 period of the ecg, form 0.344s to 1.324s
plot(t, ecg), xlim([0.344 1.324])
title('ECG signal - 1 Period')
xlabel('Time (s)')
ylabel('Voltage (mv)')

ecgf = abs(fft(ecg, Necg)); %filter ecg
ecgf = fftshift(ecgf); % calculate the frequencies of the ecg
F=[-Necg/2:Necg/2-1]/Necg; %frequency of the phase
Famplified=F*500; % amplify frequency

nexttile % plot frequencies of wave form 0 - 60 Hz
plot(Famplified, ecgf)
title('ECG Frequencies')
xlim ([0 60])


struct = load('C:\Users\Oisin\Documents\MATLAB\Signal processing\EMG.mat');% load in EMG signal
vect = struct.EMG; %let 'vect' be the EMG signal
avect = abs(vect); %get absolute value of vect
plot(avect) %plot avect

lb = 4664;% lower bound observed from graph
ub = 11759;% upper bound observed from graph
avs =avect(lb:ub); %set the signal component of 'avect'

avnb = avect(1:lb); % set the lower bound of the noise component of 'avect'
avna= avect(ub:16001); % set the upper bound of the noise component of 'avect'
avn = [avnb; avna];% add them both together to get the total noise of 'avect'
ravn = rms(avn);% get rms of noise
ravs = rms(avs);% get rms of signal


SNR = 20*log(ravs/ravn) % use the rms values to get the SNR 

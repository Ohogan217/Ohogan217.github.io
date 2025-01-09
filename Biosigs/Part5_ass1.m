struct = load('C:\Users\Oisin\Documents\MATLAB\Signal processing\vep.mat'); % read in the vep file
sigs = struct.vep;% get the signals from struct
sizes = size(sigs);% get the dimensions of sigs
Diff_Min_Max = max(sigs)- min(sigs); % find the difference between the min and max values of signal
avgdiff = mean(Diff_Min_Max);% find the mean difference of the signals
filteredvep = mean((sigs.'));% filtered vep is the mean of all the signals, .' transposes the matrix to ensure its the right dimensions
plot(sigs, '--')% plot all the signals in red dashed lines
hold on% hold all the signals
plot(filteredvep, 'K')%plot the filtered vep in black
ylabel('mV')% label the y axis as mV
maxv = max(filteredvep); % find the max of the filtered vep
minv = min(filteredvep); %find the min of the filtered vep
tmax = find(filteredvep == maxv);% find the time that the max occurs
tmin = find(filteredvep ==minv);% find the time that the min occurs
tdiff = abs(tmax - tmin);% find the difference in times
diffavg = maxv- minv;% find the average difference in the largest and smallest value 
var20 = (std(sigs(1:20, :))).^2; % find the varience of the first 20 time steps of the signas
avgvar20 = mean(var20); % find the mean of these variences
varavg20 = (std(filteredvep(1:20)))^2; % vind the varience of the first 20 time steps of the filtered signal 

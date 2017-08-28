clear;
clc;
close all;

%%
% Data Loading
load('pulseData.mat');

%%
% Bandpass
bandPassLow  = 39.98*1000;
bandPassHigh = 40.02*1000;
frequency = 40000;
Fs = 500000;

bpFiltIir = designfilt('bandpassiir','FilterOrder',4, ...
    'HalfPowerFrequency1',bandPassLow,'HalfPowerFrequency2',bandPassHigh, ...
    'SampleRate',Fs);

data1(1,:) = data(1,:);
data1(2,:) = filter(bpFiltIir,data(2,:));
data1(3,:) = filter(bpFiltIir,data(3,:));
data1(4,:) = filter(bpFiltIir,data(4,:));
data1(5,:) = filter(bpFiltIir,data(5,:));

%%
% Graphing
%subplot(1,3,1);
figure(1);
hold on;
lower = 500000;
upper = 750000;
plot(data(1, lower:upper), data(2, lower:upper));
plot(data(1, lower:upper), data(3, lower:upper));
plot(data(1, lower:upper), data(4, lower:upper));
plot(data(1, lower:upper), data(5, lower:upper));
hold off;


% subplot(1,3,2);
figure(2);
hold on;
lower = 500000;
upper = 750000;
plot(data1(1, lower:upper), data1(2, lower:upper));
plot(data1(1, lower:upper), data1(3, lower:upper));
plot(data1(1, lower:upper), data1(4, lower:upper));
plot(data1(1, lower:upper), data1(5, lower:upper));
hold off;


threshold = 0.00015;
length = 200;
f = find(data1(2, (lower):upper) > threshold, 1);

% subplot(1,3,3);
figure(3);
hold on;
plot(data1(1, f:f+length), data1(2, f:f+length));
plot(data1(1, f:f+length), data1(3, f:f+length));
plot(data1(1, f:f+length), data1(4, f:f+length));
plot(data1(1, f:f+length), data1(5, f:f+length));
hold off;

%% COMPUTATION
angle = traditionalCalculation(data1(2,f:f+length), data1(3,f:f+length), data1(4,f:f+length), frequency);

fprintf("The bearing is: %f degrees.\n", angle*(180/pi));

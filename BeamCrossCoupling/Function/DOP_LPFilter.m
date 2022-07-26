function [LPI,LPQ] = DOP_LPFilter(sigI,sigQ)
%LPFILTER 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.8 and Signal Processing Toolbox 8.4.
% Generated on: 09-Mar-2022 11:30:28

% Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in kHz.
%% 
Fs = 4800/16;  % Sampling Frequency75
Fpass = 50;        % Passband Frequency27.5
Fstop = 65;        % Stopband Frequency37.5
Apass = 1;           % Passband Ripple (dB)
Astop = 80;          % Stopband Attenuation (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'cheby1', 'MatchExactly', match);

%% 
% Fs = 4800;  % Sampling Frequency
% Fpass = 100;             % Passband Frequency
% Fstop = 240;             % Stopband Frequency
% Apass = 1;           % Passband Ripple (dB)
% Astop = 80;          % Stopband Attenuation (dB)
% match = 'passband';  % Band to match exactly
% 
% % Construct an FDESIGN object and call its CHEBY1 method.
% h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
% Hd = design(h, 'cheby1', 'MatchExactly', match);

%% 滤波
[x,~] = size(sigI);
if x == 4 
    LPIA = filter(Hd,sigI(1,:));
    LPQA = filter(Hd,sigQ(1,:));
    LPIB = filter(Hd,sigI(2,:));
    LPQB = filter(Hd,sigQ(2,:));
    LPIC = filter(Hd,sigI(3,:));
    LPQC = filter(Hd,sigQ(3,:));
    LPID = filter(Hd,sigI(4,:));
    LPQD = filter(Hd,sigQ(4,:));
    LPI = [LPIA;LPIB;LPIC;LPID];
    LPQ = [LPQA;LPQB;LPQC;LPQD];
else
    LPI = filter(Hd,sigI);
    LPQ = filter(Hd,sigQ);

% [~,PLPI] = freqSpectrum(LPI,fs);
% [~,PLPQ] = freqSpectrum(LPQ,fs);
end



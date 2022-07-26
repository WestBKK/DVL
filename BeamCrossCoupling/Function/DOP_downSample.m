function [fs,sigI2,sigQ2] = DOP_downSample(sigI0,sigQ0,fs0)
%{
    fun:    300k，降采样和低通滤波，降采样倍数M = 64
    time:   2022.03.09
    by:     jiakuankuan
%}
%% 降采样
Q = 16;
fs = fs0/Q;
sigI1 = decimate(sigI0,2,Q,'FIR');
sigI2 = decimate(sigI1,8,Q,'FIR');
% sigI3 = decimate(sigI2,8,Q ,'FIR');

sigQ1 = decimate(sigQ0,2,Q,'FIR');
sigQ2 = decimate(sigQ1,8,Q,'FIR');
% sigQ3 = decimate(sigQ2,8,Q,'FIR');
% [freq,PsigI3] = freqSpectrum(sigI3,fs);
end


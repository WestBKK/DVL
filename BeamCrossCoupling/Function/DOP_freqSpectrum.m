function [Freq,Ps0] = DOP_freqSpectrum(s0,fs)
%{
    % 频谱估计
%}

% 参数
frequencyLimits = [0 1]*pi; % Normalized frequency (rad/sample)

% 对关注的信号时间区域进行索引
timeLimits = [1 length(s0)]; % 采样

s0_ROI = s0(:);

s0_ROI = s0_ROI(timeLimits(1):timeLimits(2));

% 计算频谱估计值
% 不带输出参数运行该函数调用以绘制结果
[Ps0, Fs0] = pspectrum(s0_ROI, ...
    'FrequencyLimits',frequencyLimits);
Freq = Fs0/pi*fs/2;
end


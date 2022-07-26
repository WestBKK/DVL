function [sigI,sigQ] = DOP_quadMixer(origSig,f0,fs)
%% 正交混频
%{
    fun:    正交混频，实现信号的升频和降频
    time:   2022.03.10
    by:     jiakuankuan
%}
nt = 0:(1/fs):((length(origSig(1,:))-1)/fs);          % 脉冲长度

% 频率分量有600K部分，降频
[x,~] = size(origSig);
if x == 4 
    sigI1 = origSig(1,:).*cos(2*pi*f0*nt);
    sigQ1 = origSig(1,:).*sin(2*pi*f0*nt);

    sigI2 = origSig(2,:).*cos(2*pi*f0*nt);
    sigQ2 = origSig(2,:).*sin(2*pi*f0*nt);

    sigI3 = origSig(3,:).*cos(2*pi*f0*nt);
    sigQ3 = origSig(3,:).*sin(2*pi*f0*nt);

    sigI4 = origSig(4,:).*cos(2*pi*f0*nt);
    sigQ4 = origSig(4,:).*sin(2*pi*f0*nt);

    sigI = [sigI1;sigI2;sigI3;sigI4];
    sigQ = [sigQ1;sigQ2;sigQ3;sigQ4];
else
    sigI = origSig.*cos(2*pi*f0*nt);
    sigQ = origSig.*sin(2*pi*f0*nt);
% 频谱参数
% [freq,PI] = freqSpectrum(sigI,fs);
% [~,PQ] = freqSpectrum(sigQ,fs);
end


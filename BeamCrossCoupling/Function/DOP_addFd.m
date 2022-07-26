function [nt,Sig] = DOP_addFd(origSig,fd,f0,fs)
%     fd = 20;
    dertaf = fd;                                       % 频移值
    shiftFs = (f0-dertaf)/f0*fs;                        % 重采样频率
    % rate = fix(shiftFs/fs*10000);
    Sig = resample(origSig,shiftFs,fs);

    nt = 0:(1/fs):((length(Sig)-1)/fs);          % 脉冲长度
    [freq1,Psig1] = DOP_freqSpectrum((Sig),fs);
end


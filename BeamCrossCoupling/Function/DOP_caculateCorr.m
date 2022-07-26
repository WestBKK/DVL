function [Amp,Phi] = DOP_caculateCorr(complxSig,sampleNum,winLen,hLen)
%{
    fun: 复相关计算
    time:22.03.09
    by:  jiakuankuan
    ref: DOPPLER VELOCITY LOG ALGORITHMS:DETECTION, ESTIMATION, AND ACCURACY
%}
% % time log
% hLen = fix(length(origSig0)/16/Np);
% % 用于计算的信号长度
% winLen = fix(length(origSig0)/16/Np*2);
% sampleNum = length(arrayOut);

for i = 1:(sampleNum-winLen-hLen+1)
    x = complxSig(i:(i+winLen-1));
    y = complxSig((i+hLen):(i+hLen+winLen-1));
    rc(i) = 1/winLen*(y*x');
%     rc0(i) = 1/N*abs(y*x');
end
Amp = abs(rc);
Phi = angle(rc);
end

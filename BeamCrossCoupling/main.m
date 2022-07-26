clc
clear all
close all
%{
    func:   Doppler信号模拟，信号生成方式改成了先编码，然后填充正弦信号
    time:   2021.07.25
    by:     jiakuankuan
    ref:    --
%} 
%% 宽带编码信号时域波形
c = 1500;
Np = 10;
Num = 8;%填充个数
f0 = 300e3;
fs = 4.8e6;

subcode0 = [1 1 1 -1 -1 1 -1];
subcodeInf = [1 1 1 -1 -1 1 -1];

% % 原始信号
[tau0,origSig0] = DOP_genCodeSig1(subcode0,Np,Num,f0,fs);

% % % 干扰信号
% [tauInf,origSigInf] = DOP_genCodeSig1(subcodeInf,Np,Num,f0,fs);

origSig = [zeros(size(origSig0)),(origSig0),zeros(size(origSig0))];

% nt0 = 0:(1/fs):((length(origSig)-1)/fs);          % 脉冲长度
% [freqs,pS] = freqSpectrum(origSig,fs);


%% 频偏信号
fd0 = 10;
[nt0,Sig0] = DOP_addFd(origSig,fd0,f0,fs);

fdInf = 30;
[ntInf,SigInf] = DOP_addFd(origSig,fdInf,f0,fs);

if (length(Sig0)-length(SigInf))>=0
    adZero = zeros(1,(length(Sig0)-length(SigInf)));
    Sig = Sig0 + 0.1*[SigInf,adZero];
else
    adZero = zeros(1,(length(SigInf)-length(Sig0)));
    Sig = [Sig0,adZero] + 0.1*SigInf;
end
   
[freq1,Psig1] = DOP_freqSpectrum((Sig),fs);

%% 正交 降采样 低通
[sigRI,sigRQ] = DOP_quadMixer(Sig,f0,fs);
[fs,PI,PQ] = DOP_downSample(sigRI,sigRQ,fs);
[LPRI,LPRQ] = DOP_LPFilter(PI,PQ);
complxSig = LPRI - 1j*LPRQ;


%% 频偏及速度估计
arrayOut = complxSig;

% time log
hLen = fix(length(origSig0)/16/Np);
% 用于计算的信号长度
winLen = hLen*2;
sampleNum = length(arrayOut);

[Amp,Phi] = DOP_caculateCorr(arrayOut,sampleNum,winLen,hLen);

% [echo_time,phiSet,phiAvr] = DOP_averagePhi(Amp,Phi,sampleNum,winLen,hLen);

[choset,choAmp,phiSet,phiAvr] = DOP_averagePhi2(Amp,Phi,30,max(nt0),fs,2);

ev = phiAvr*c*fs/(4*pi*(hLen)*f0);    
ef = 2*f0*ev/c                 %phiAvr*fs/(2*pi*(hLen)) 
ev_value = mean(ev)
ev_var = var(Phi(phiSet).*c.*fs./(4*pi*(hLen)*f0))

%% 绘图
figure;
plot(Amp./max(Amp),'LineWidth',1.5);
hold on;
plot(Phi/max(abs(Phi)),'LineWidth',1.5);
plot(phiSet,Phi(phiSet)/max(abs(Phi)),'g+','LineWidth',1);
xlabel('采样点','FontSize',14);
ylabel('归一化值','FontSize',14);
legend({'自相关幅值','自相关相位值','估计区间'},'FontSize',12);
text(100,-0.2,['ev = ',num2str(ev_value),' m/s'],'FontSize',12)
text(100,-0.4,['var = ',num2str(ev_var)],'FontSize',12)
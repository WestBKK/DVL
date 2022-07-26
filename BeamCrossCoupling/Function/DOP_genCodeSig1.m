function [tau,origSig0] = DOP_genCodeSig1(subcode,Np,Num,f0,fs)
%{
    func:   宽带编码信号生成，先编码在填充正弦信号
    time:   2021.07.25
    by:     jiakuankuan
    ref:    --
%} 

% subcode = [1 1 1 -1 -1 1 -1];

c = 1500;
L = length(subcode);
% Np = 10;
% Num = 8;%填充个数
% f0 = 300e3;
Ts = Num/f0;
% fs = 4.8e6;

code = repmat(subcode,1,Np);
t = 0:1/fs:(Ts-1/fs);

s = zeros(Np*L,length(t))';
for n = 1:(Np*L)
    s(:,n) = code(n).*rectpuls(t-Ts/2,Ts);
end
codSig = s(:)'; 

% 原始信号
times = 0:1/fs:(length(codSig)/fs-1/fs);
origSig0 = (s(:)'.*cos(2*pi*f0*times));
tau = max(t)*L;
end
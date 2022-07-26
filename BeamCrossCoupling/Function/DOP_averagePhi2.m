function [set,amp,phiSet,phiAvr] = DOP_averagePhi2(amp,phi,theta,tau,fs,N)
%{
    fun: 寻找能量最大子窗
    time:22.03.14
    by:  jiakuankuan
    ref: 声呐电子系统设计导论中的方法P306
%}
% amp = Amp;
% phi = Phi;
% theta = 30;
% tau = 0.001;
% fs = fs0;
% N = 2;
Amp0 = amp;
set = 1:length(amp);
deltaT = tau*fs/cosd(theta);

while length(set) > fix(fix(deltaT)*2)
    len = fix(length(amp)/4);
    index = set;
    energ1 = sum(amp(1:len).^2);
    energ2 = sum(amp((len+1):2*len).^2);
    energ3 = sum(amp((2*len+1):3*len).^2);
    energ4 = sum(amp((3*len+1):4*len).^2);
    E1 = energ1 + energ2;E2 = energ2 + energ3;E3 = energ3 + energ4;
    indxset = [index(1:(2*len));index((len+1):(3*len));index((2*len+1):(4*len))];
    numbr = [E1;E2;E3] == max([E1;E2;E3]);
    
    set = indxset(numbr,:);
    amp = Amp0(set);
    amp;
    set;
end
    deltaN = fix((set(end) - set(1))/N);
    max_sum = sum(amp(1:deltaN));
    max_set = 1;
    for i = 1:(length(set)-deltaN-1)
        temp = sum(amp(i:(i+deltaN-1)));
        if temp > max_sum
            max_sum = temp;                     % 寻找最大值
            max_set = i;                        % 记录最大值位置
        end
    end
    X = max_set:(max_set+deltaN-1);
    Y = amp(X);    
    echo_time = fix(sum(X.*Y)/sum(Y));
    Q_sig_points = fix(deltaN/4);
    phi_set = (echo_time-Q_sig_points):(echo_time+Q_sig_points);
    phiSet = phi_set + set(1);
    phiAvr = sum(phi(phiSet))/((2*Q_sig_points+1));
    

end


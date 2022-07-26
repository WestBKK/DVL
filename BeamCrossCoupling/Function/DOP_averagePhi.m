function [echo_time,Phi_set,Phi_avr] = DOP_averagePhi(Amp,Phi,sampleNum,corrLen,hLen)
%{
    fun: 估计回波时间点，并求相位平均值
    time:22.03.09
    by:  jiakuankuan
    ref: 可以借鉴参考声呐电子系统设计导论中的方法P306,幅度检测法进行最大值的改进
%}
max_sum = sum(Amp(1:corrLen));
max_set = 1;
for i = 2:(sampleNum - 2*corrLen - hLen - 1)
    temp = sum(Amp(i:(i+corrLen-1)));
    if temp > max_sum
        max_sum = temp;    %寻找最大值
        max_set = i;       %记录最大值位置
    end
end

X = max_set:(max_set+corrLen-1);
Y = Amp(X);    
echo_time = fix(sum(X.*Y)/sum(Y));
Q_sig_points = fix(corrLen/8);
Phi_set = (echo_time-Q_sig_points):(echo_time+Q_sig_points);
Phi_avr = sum(Phi(Phi_set))/((2*Q_sig_points+1));
end


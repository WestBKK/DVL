function [arrayR,arrayL] = DOP_beamform30(complxSig,phaType)
%% 接收波束形成

% 阵元加权因子,接收和发射相反
tf = strcmp(45,phaType);
if tf == 1 
    wphiL = [315 45 135 225];
    wphiR = [45 315 225 135];
elseif tf == 0
    wphiR = fliplr([0 90 180 270]);%
    wphiL = fliplr([270 180 90 0]);%
end
wR = [exp(1j*wphiR(1)./180*pi),exp(1j*wphiR(2)./180*pi),exp(1j*wphiR(3)./180*pi),exp(1j*wphiR(4)./180*pi)];
wL = [exp(1j*wphiL(1)./180*pi),exp(1j*wphiL(2)./180*pi),exp(1j*wphiL(3)./180*pi),exp(1j*wphiL(4)./180*pi)];
[x,~] = size(complxSig);
if x == 4 
    ele1R = complxSig(1,:).*wR(1);ele2R = complxSig(2,:).*wR(2);ele3R = complxSig(3,:).*wR(3);ele4R = complxSig(4,:).*wR(4);
    ele1L = complxSig(1,:).*wL(1);ele2L = complxSig(2,:).*wL(2);ele3L = complxSig(3,:).*wL(3);ele4L = complxSig(4,:).*wL(4);
    arrayR = ele1R + ele2R + ele3R + ele4R;
    arrayL = ele1L + ele2L + ele3L + ele4L;
else
    arrayR = complxSig;
    arrayL = complxSig;
end


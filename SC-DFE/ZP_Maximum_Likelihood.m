function Symbols4=ZP_Maximum_Likelihood(Symbol3,N,P,Block_Num,h,SNR)
Symbols4=zeros(N,1,Block_Num);
for a=1:Block_Num
    Symbols4(:,:,a)=Symbols3(:,:,a);
end   
end
function [Symbols3,H,h]=ZP_Channel(Symbols,N,Block_Num,L_C,SNR)
h=(1/sqrt(2*(L_C+1)))*(randn(1,L_C+1)+1i*randn(1,L_C+1));
%Generate the P by N toepliztz convolution matrix [H]p,n=h(p-n)
nr=randn(N+L_C,1,Block_Num);
ni=randn(N+L_C,1,Block_Num);
Noise=(sqrt(2)/2)*(nr+1i*ni);

H=zeros(N+L_C,N);  
for a=1:N+L_C
    for b=1:N
        if a-b<0 || a-b>L_C
            H(a,b)=0;
        else
            H(a,b)=h(a-b+1);
        end       
    end
end
Symbols3=zeros(N+L_C,1,Block_Num);
for a=1:Block_Num
    Symbols3(:,:,a)=H*Symbols(:,:,a)+(1/sqrt(SNR))*Noise(:,:,a);
end
end
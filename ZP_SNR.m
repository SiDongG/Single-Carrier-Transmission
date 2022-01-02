clear;clc;close all;
loop_Num=100;
L_C=4;%Channel Order
total=zeros(1,21);
Block_Num=50;P=68;N=64;
ratio=zeros(1,21);
for dB=0:20
    disp(dB);
    SNR=10^(dB/10);
    for loop=1:loop_Num
        [Bits,Symbols]=ZP_init(Block_Num,N);   
        [Symbols3,H]=ZP_Channel(Symbols,N,Block_Num,L_C,SNR);        
        Symbols4=ZP_equalization(Symbols3,N,P,Block_Num,H,2);    
        Bits_re=ZP_demod(Symbols4,Block_Num);             
        error=0;
        for count=1:length(Bits)
            if Bits(count)~=Bits_re(count)
                error=error+1;
            end
        end
        ratio(dB+1)=error/(Block_Num*N);
        total(dB+1)=total(dB+1)+ratio(dB+1);
    end
end
total=total/loop_Num;
figure()
semilogy(0:20,total);

xlabel('SNR(dB)');
ylabel('Ber');
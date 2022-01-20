clear;clc;close all;
loop_Num=1000;
L_C=4;%Channel Order
total=zeros(1,11,3);
Block_Num=50;P=68;N=64;
ratio=zeros(1,11,3);
for dB=0:2:20
    disp(dB);
    SNR=10^(dB/10);
    for loop=1:loop_Num
        [Bits,Symbols]=ZP_init(Block_Num,N);   
        [Symbols3,H]=ZP_Channel(Symbols,N,Block_Num,L_C,SNR);
        Symbols_ZF=ZP_equalization(Symbols3,N,P,Block_Num,H,1,SNR); 
        Bits_ZF=ZP_demod(Symbols_ZF,Block_Num); 
        Symbols_MMSE=ZP_equalization(Symbols3,N,P,Block_Num,H,2,SNR);    
        Bits_MMSE=ZP_demod(Symbols_MMSE,Block_Num);  
        Symbols_ML=ZP_equalization(Symbols3,N,P,Block_Num,H,3,SNR);    
        Bits_ML=ZP_demod(Symbols_ML,Block_Num);
        error_MMSE=0;error_ZF=0;error_ML=0;
        for count=1:length(Bits)
            if Bits(count)~=Bits_ZF(count)
                error_ZF=error_ZF+1;
            end
            if Bits(count)~=Bits_MMSE(count)
                error_MMSE=error_MMSE+1;
            end
            if Bits(count)~=Bits_ML(count)
                error_ML=error_ML+1;
            end
        end
        ratio(1,dB/2+1,1)=error_ZF/(Block_Num*N);
        total(1,dB/2+1,1)=total(1,dB/2+1,1)+ratio(1,dB/2+1,1);
        ratio(1,dB/2+1,2)=error_MMSE/(Block_Num*N);
        total(1,dB/2+1,2)=total(1,dB/2+1,2)+ratio(1,dB/2+1,2);
        ratio(1,dB/2+1,3)=error_ML/(Block_Num*N);
        total(1,dB/2+1,3)=total(1,dB/2+1,3)+ratio(1,dB/2+1,3);
    end
end
total=total/loop_Num;
figure()
hold on;box on;
plot(0:2:20,total(:,:,1),'k-');
plot(0:2:20,total(:,:,2),'g-');
plot(0:2:20,total(:,:,3),'r-');
set(gca,'Yscale','log');
ylim([1e-5 1]);
xlabel('SNR(dB)');
ylabel('Ber');
legend('ZF','MMSE','ML');
clear;clc;close all;
loop_Num=1000;
L_C=2;%Channel Order
total=zeros(1,5,3);
Block_Num=1000;P=4;N=2;
ratio=zeros(1,5,3);
step=4;
for dB=0:step:16
    disp(dB);
    SNR=10^(dB/10);
    for loop=1:loop_Num
        [Bits,Symbols]=ZP_init(Block_Num,N);   
        [Symbols3,H]=ZP_Channel(Symbols,N,Block_Num,L_C,SNR);
        Symbols_ZF=ZP_equalization(Symbols3,N,P,Block_Num,H,1,SNR); 
        Bits_ZF=ZP_demod(Symbols_ZF,Block_Num); 
        Symbols_MMSE=ZP_equalization(Symbols3,N,P,Block_Num,H,2,SNR);    
        Bits_MMSE=ZP_demod(Symbols_MMSE,Block_Num);  
        Bits_ML=ZP_ML(Symbols3,N,Block_Num,H);    
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
        ratio(1,dB/step+1,1)=error_ZF/(Block_Num*N);
        total(1,dB/step+1,1)=total(1,dB/step+1,1)+ratio(1,dB/step+1,1);
        ratio(1,dB/step+1,2)=error_MMSE/(Block_Num*N);
        total(1,dB/step+1,2)=total(1,dB/step+1,2)+ratio(1,dB/step+1,2);
        ratio(1,dB/step+1,3)=error_ML/(Block_Num*N);
        total(1,dB/step+1,3)=total(1,dB/step+1,3)+ratio(1,dB/step+1,3);
    end
end
total=total/loop_Num;
figure()
hold on;box on;
plot(0:4:16,total(:,:,1),'k-');
plot(0:4:16,total(:,:,2),'g-');
plot(0:4:16,total(:,:,3),'r-');
set(gca,'Yscale','log');
ylim([1e-3 1]);
xlabel('SNR(dB)');
ylabel('Ber');
legend('ZF','MMSE','ML');
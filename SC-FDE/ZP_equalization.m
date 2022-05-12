function Symbols4=ZP_equalization(Symbols3,N,P,Block_Num,H,Mode,SNR)
Symbols4=zeros(N,1,Block_Num);
if Mode==1   %Zero-forcing equalizer
    G_ZF=pinv(H); %Zero-forcing with pesudoinverse
    for a=1:Block_Num
        Symbols4(:,:,a)=G_ZF*Symbols3(:,:,a);
    end       
end
if Mode==2   %Minimum Mean Square Error Equalizer
    Var_n=1/SNR; %Noise and Symbol both equal to 1
    Var_s=1;
    G_MMSE=Var_s*H'/(Var_n*eye(P)+Var_s*(H*H'));
    for a=1:Block_Num
        Symbols4(:,:,a)=G_MMSE*Symbols3(:,:,a);
    end
end
if Mode==3   %Maximum Likelihood Equalizer 
    Var_n=1/SNR;
    G_ML=(H'*Var_n^-1*H)\(H'*Var_n^-1);
    for a=1:Block_Num
        Symbols4(:,:,a)=G_ML*Symbols3(:,:,a);
    end
end
end
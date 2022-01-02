function Symbols4=ZP_equalization(Symbols3,N,P,Block_Num,H,Mode)
Symbols4=zeros(N,1,Block_Num);
if Mode==1   %Zero-forcing equalizer
    G_ZP=pinv(H); %Zero-forcing with pesudoinverse
    for a=1:Block_Num
        Symbols4(:,:,a)=G_ZP*Symbols3(:,:,a);
    end       
end
if Mode==2   %Minimum Mean Square Error Equalizer
    Var_n=1; %Noise and Symbol both equal to 1
    Var_s=1;
    G_MMSE=Var_s^2*H'/(Var_n^2*eye(P)+Var_s^2*(H*H'));
    for a=1:Block_Num
        Symbols4(:,:,a)=G_MMSE*Symbols3(:,:,a);
    end
end
if Mode==3   %Maximum Likelihood Equalizer 
    
end
end
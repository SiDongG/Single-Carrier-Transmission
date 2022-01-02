function Bits_re=ZP_demod(Symbols4,Block_Num)
Bits_re=zeros(1,2*length(Symbols4)*Block_Num);
count=1;
while count<length(Symbols4)*Block_Num+1
        if real(Symbols4(count))>0 && imag(Symbols4(count))>0
            Bits_re(count*2-1)=0;
            Bits_re(count*2)=0;
        end
        if real(Symbols4(count)) <0 && imag(Symbols4(count))>0
            Bits_re(count*2-1)=0;
            Bits_re(count*2)=1;
        end
        if real(Symbols4(count)) <0 && imag(Symbols4(count))<0
            Bits_re(count*2-1)=1;
            Bits_re(count*2)=1;
        end
        if real(Symbols4(count)) >0 && imag(Symbols4(count))<0
            Bits_re(count*2-1)=1;
            Bits_re(count*2)=0;
        end
        count=count+1;
end
end
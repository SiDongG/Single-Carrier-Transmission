function [Bits_r,Difference]=ZP_ML(Symbols3,N,Block_Num,H)
Bits_r=zeros(1,2*N*Block_Num);
Difference=zeros(1,16);
for a=1:Block_Num
    Difference(1)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1+1i;1+1i]));
    Difference(2)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1+1i;-1+1i]));
    Difference(3)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1+1i;1-1i]));
    Difference(4)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1+1i;-1-1i]));
    Difference(5)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1+1i;1+1i]));
    Difference(6)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1+1i;-1+1i]));
    Difference(7)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1+1i;1-1i]));
    Difference(8)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1+1i;-1-1i]));
    Difference(9)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1-1i;1+1i]));
    Difference(10)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1-1i;-1+1i]));
    Difference(11)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1-1i;1-1i]));
    Difference(12)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[1-1i;-1-1i]));
    Difference(13)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1-1i;1+1i]));
    Difference(14)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1-1i;-1+1i]));
    Difference(15)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1-1i;1-1i]));
    Difference(16)=sum(abs(Symbols3(:,:,a)-H*(1/sqrt(2))*[-1-1i;-1-1i]));
    Position=find(Difference==min(Difference));
    Code=dec2bin(Position(1)-1,4);
    Bits_r(4*a-3)=str2double(Code(1));
    Bits_r(4*a-2)=str2double(Code(2));
    Bits_r(4*a-1)=str2double(Code(3));
    Bits_r(4*a)=str2double(Code(4));
end   
end
function Symbols2=ZP_zeropaddle(Symbols,Lzp,N,Block_Num)
%At each encoded symbol block, Lzp zero symbols are appended, for OFDM and
%Zp-only to have equal symbol rate Lzp=Lcp. 
Symbols2=zeros(N+Lzp,1,Block_Num);
for a=1:Block_Num
   Symbols2(:,:,a)=[Symbols(:,:,a);zeros(Lzp,1)];
end
end
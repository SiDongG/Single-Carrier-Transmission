function [Bits,Symbols]=ZP_init(Block_Num,N) 
Bits=randi(0:1,[1,Block_Num*N*2]); %L bits in the bit-stream 
count=1;
Symbols=zeros(N,1,Block_Num); %Organize symbols into blocks
while count<length(Bits)
        if (Bits(count)==0 && Bits(count+1)==0)
            Symbols((count+1)/2)=(1+1i)/sqrt(2);
        end
        if (Bits(count)==0 && Bits(count+1)==1)
            Symbols((count+1)/2)=(-1+1i)/sqrt(2);
        end
        if (Bits(count)==1 && Bits(count+1)==1)
            Symbols((count+1)/2)=(-1-1i)/sqrt(2);
        end
        if (Bits(count)==1 && Bits(count+1)==0)
            Symbols((count+1)/2)=(1-1i)/sqrt(2);
        end
        count=count+2;
end
end
function [ ms , med ] = run_test( A )

ms=zeros(1,100);
for i=0:99
    sub=A(i*10+1:i*10+10);
    sub=sub.^2;
    ms(i+1)=sum(sub)/10;
end;
med=median(ms);

end


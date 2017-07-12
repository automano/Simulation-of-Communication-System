function [BPSK,QPSK,QAM] = hw_3()
%%
uS = 1e-06;  %1us %twelve bits are to be transmitted in 12 microseconds
fc = 2e06;   %2 mega hertz frequency %required physical frequency
Wc = 2*pi*fc; %cosines and sines in all of the constellation has frequency of 2 mega hertz.
sample = [0 0 0 0 0 1 0 1 0 1 0 0];%the first twelve channel encoded bits
%
remat_times = 100; %repeat elements 100 times for plot
%%
%BPSK 
t_BPSK = 0:uS/remat_times: 1*uS - uS/remat_times;  %time domin for BPSK per uS
for i = 1:12
    if(sample(i)==0)%'0' => -cos(wt)
        BPSK(1,i*100-99:i*100) = -cos(Wc*t_BPSK);
    end
    
    if(sample(i)==1)%'0' => cos(wt)
        BPSK(1,i*100-99:i*100) = cos(Wc*t_BPSK);
    end
end


%%
%QPSK  
t_QPSK = 0:uS/remat_times: 2*uS - uS/remat_times;  %time domin for QPSK per uS
for i = 1:2:12

	%'11' => 1/sqrt(2)*cos(wt)+1/sqrt(2)*sin(wt)
    if(sample(i)==1 && sample(i+1)==1)
        QPSK(1,(i-1)*100+1:(i-1)*100+200) = 1/sqrt(2)*cos(Wc*t_QPSK)+1/sqrt(2)*sin(Wc*t_QPSK);
    end
	
    %'10' => 1/sqrt(2)*cos(wt)-1/sqrt(2)*sin(wt)
    if(sample(i)==1 && sample(i+1)==0)
        QPSK(1,(i-1)*100+1:(i-1)*100+200) = 1/sqrt(2)*cos(Wc*t_QPSK)-1/sqrt(2)*sin(Wc*t_QPSK);
    end
	
	%'00' => -1/sqrt(2)*cos(wt)-1/sqrt(2)*sin(wt)
    if(sample(i)==0 && sample(i+1)==0)
        QPSK(1,(i-1)*100+1:(i-1)*100+200) = -1/sqrt(2)*cos(Wc*t_QPSK)-1/sqrt(2)*sin(Wc*t_QPSK);
    end
	
    %'01' => -1/sqrt(2)*cos(wt)+1/sqrt(2)*sin(wt)
    if(sample(i)==0 && sample(i+1)==1)
        QPSK(1,(i-1)*100+1:(i-1)*100+200) = -1/sqrt(2)*cos(Wc*t_QPSK)+1/sqrt(2)*sin(Wc*t_QPSK);
    end
end

%%
%QAM
t_QAM = 0:uS/remat_times: 3*uS - uS/remat_times;  %time domin for QAM per uS
for i = 1:3:12

	%'111' => 1/sqrt(2)*cos(wt)+1/sqrt(2)*sin(wt)
    if(sample(i)==1 && sample(i+1)==1 && sample(i+2)==1)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/sqrt(2)*cos(Wc*t_QAM)+1/sqrt(2)*sin(Wc*t_QAM);
    end
	
	%'101' => 1/sqrt(2)*cos(wt)-1/sqrt(2)*sin(wt)
    if(sample(i)==1 && sample(i+1)==0 && sample(i+2)==1)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/sqrt(2)*cos(Wc*t_QAM)-1/sqrt(2)*sin(Wc*t_QAM);
    end
    
    %'001' => -1/sqrt(2)*cos(wt)-1/sqrt(2)*sin(wt)
    if(sample(i)==0 && sample(i+1)==0 && sample(i+2)==1)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/sqrt(2)*cos(Wc*t_QAM)-1/sqrt(2)*sin(Wc*t_QAM);
    end
    
    %'011' => -1/sqrt(2)*cos(wt)+1/sqrt(2)*sin(wt)
    if(sample(i)==0 && sample(i+1)==1 && sample(i+2)==1)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/sqrt(2)*cos(Wc*t_QAM)+1/sqrt(2)*sin(Wc*t_QAM);
    end
    
    %'110' => 1/2*cos(wt)
    if(sample(i)==1 && sample(i+1)==1 && sample(i+2)==0)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/2*cos(Wc*t_QAM);
    end
    
    %'010' => 1/2*sin(wt)
    if(sample(i)==0 && sample(i+1)==1 && sample(i+2)==0)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/2*sin(Wc*t_QAM);
    end
    
    %'100' => -1/2*sin(wt)
    if(sample(i)==1 && sample(i+1)==0 && sample(i+2)==0)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/2*sin(Wc*t_QAM);
    end
    
    %'000' => -1/2*cos(wt)
    if(sample(i)==0 && sample(i+1)==0 && sample(i+2)==0)
        QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/2*cos(Wc*t_QAM);
    end
 end




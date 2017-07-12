uS = 1e-06;  
fc = 2e06;  
Wc = 2*pi*fc; 
sample = [0 0 0 0 0 1 0 1 0 1 0 0];
remat_times = 100; 
t = 0:uS/remat_times:12*uS - uS/remat_times;  
t_BPSK=0:uS/remat_times:1*uS - uS/remat_times;  
t_QPSK=0:uS/remat_times:2*uS - uS/remat_times;  
t_QAM= 0:uS/remat_times:3*uS - uS/remat_times; 
for i = 1:12
    if(sample(i)==0)
        physical_signal_BPSK(1,i*100-99:i*100) = -cos(Wc*t_BPSK); 
    elseif(sample(i)==1)
        physical_signal_BPSK(1,i*100-99:i*100) = cos(Wc*t_BPSK);
    end
end
for i = 1:2:12
    if(sample(i)==1 && sample(i+1)==1)
        physical_signal_QPSK(1,(i-1)*100+1:(i-1)*100+200) = 1/sqrt(2)*cos(Wc*t_QPSK)+1/sqrt(2)*sin(Wc*t_QPSK);
    elseif(sample(i)==1 && sample(i+1)==0)
        physical_signal_QPSK(1,(i-1)*100+1:(i-1)*100+200) = 1/sqrt(2)*cos(Wc*t_QPSK)-1/sqrt(2)*sin(Wc*t_QPSK);
    elseif(sample(i)==0 && sample(i+1)==0)
        physical_signal_QPSK(1,(i-1)*100+1:(i-1)*100+200) = -1/sqrt(2)*cos(Wc*t_QPSK)-1/sqrt(2)*sin(Wc*t_QPSK);
    elseif(sample(i)==0 && sample(i+1)==1)
        physical_signal_QPSK(1,(i-1)*100+1:(i-1)*100+200) = -1/sqrt(2)*cos(Wc*t_QPSK)+1/sqrt(2)*sin(Wc*t_QPSK);
    end
end
for i = 1:3:12
    if(sample(i)==1 && sample(i+1)==1 && sample(i+2)==1)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/sqrt(2)*cos(Wc*t_QAM)+1/sqrt(2)*sin(Wc*t_QAM);
    elseif(sample(i)==1 && sample(i+1)==0 && sample(i+2)==1)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/sqrt(2)*cos(Wc*t_QAM)-1/sqrt(2)*sin(Wc*t_QAM);
    elseif(sample(i)==0 && sample(i+1)==0 && sample(i+2)==1)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/sqrt(2)*cos(Wc*t_QAM)-1/sqrt(2)*sin(Wc*t_QAM);
    elseif(sample(i)==0 && sample(i+1)==1 && sample(i+2)==1)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/sqrt(2)*cos(Wc*t_QAM)+1/sqrt(2)*sin(Wc*t_QAM);
    elseif(sample(i)==1 && sample(i+1)==1 && sample(i+2)==0)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/2*cos(Wc*t_QAM);
    elseif(sample(i)==0 && sample(i+1)==1 && sample(i+2)==0)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = 1/2*sin(Wc*t_QAM);
    elseif(sample(i)==1 && sample(i+1)==0 && sample(i+2)==0)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/2*sin(Wc*t_QAM);
    elseif(sample(i)==0 && sample(i+1)==0 && sample(i+2)==0)
        physical_signal_QAM(1,(i-1)*100+1:(i-1)*100+300) = -1/2*cos(Wc*t_QAM);
    end
end
figure;
subplot(3,1,1);plot(t,physical_signal_BPSK);axis([-uS 13*uS-uS/remat_times -1.2 1.2])
subplot(3,1,2);plot(t,physical_signal_QPSK);axis([-uS 13*uS-uS/remat_times -1.2 1.2])
subplot(3,1,3);plot(t,physical_signal_QAM);axis([-uS 13*uS-uS/remat_times -1.2 1.2])




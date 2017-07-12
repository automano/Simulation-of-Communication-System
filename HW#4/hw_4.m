clc
clear
close all;
%%
uS = 1e-06;  %1us %twelve bits are to be transmitted in 12 microseconds
fc = 2e06;   %2 mega hertz frequency %required physical frequency
Wc = 2*pi*fc; %cosines and sines in all of the constellation has frequency of 2 mega hertz.
remat_times = 100; %repeat elements 100 times for plot
%%
[BPSK,QPSK,QAM]=hw_3();
%%
%BPSK
t_BPSK = 0:uS/remat_times: 1*uS - uS/remat_times; 
t_delta = remat_times;
% instead of doing integral, we do sum
for i = 1:12
   sign = sum(BPSK(i*t_delta-99:i*t_delta).*cos(Wc*t_BPSK)); 
   if(sign>0)
       Channel_Decoder_BPSK(i) = 1;
   elseif(sign<0)
       Channel_Decoder_BPSK(i) = 0;
   end
end
%%
%QPSK
t_QPSK = 0:uS/remat_times: 2*uS - uS/remat_times; 
t_delta = 2*remat_times;
% instead of doing integral, we do sum
for i = 1:6
   sign_1 = sum(QPSK(i*t_delta-199:i*t_delta).*cos(Wc*t_QPSK));
   sign_2 = sum(QPSK(i*t_delta-199:i*t_delta).*sin(Wc*t_QPSK));
   if(sign_1>0&&sign_2>0)
       Channel_Decoder_QPSK(2*i-1) = 1;
       Channel_Decoder_QPSK(2*i) = 1;
   elseif(sign_1>0&&sign_2<0)
       Channel_Decoder_QPSK(2*i-1) = 1;
       Channel_Decoder_QPSK(2*i) = 0;
   elseif(sign_1<0&&sign_2>0)
       Channel_Decoder_QPSK(2*i-1) = 0;
       Channel_Decoder_QPSK(2*i) = 1;
   elseif(sign_1<0&&sign_2<0)
       Channel_Decoder_QPSK(2*i-1) = 0;
       Channel_Decoder_QPSK(2*i) = 0;
   end
end
%%
%QAM
t_QAM = 0:uS/remat_times: 3*uS - uS/remat_times; 
t_delta = 3*remat_times;
%instead of doing integral, we do sum
for i = 1:4
   sign_1 = sum(QAM(i*t_delta-299:i*t_delta).*cos(Wc*t_QAM));
   sign_2 = sum(QAM(i*t_delta-299:i*t_delta).*sin(Wc*t_QAM));
   Amplitude = sqrt(sign_1^2+sign_2^2); 
  if (Amplitude < 150)%small amplitude
   if(sign_1<0&&sign_2>0&&sign_2<1)
       Channel_Decoder_QAM(3*i-2) = 0;
       Channel_Decoder_QAM(3*i-1) = 0;
       Channel_Decoder_QAM(3*i) = 0;    
   elseif(sign_1>-1&&sign_1<0&&sign_2>0)
       Channel_Decoder_QAM(3*i-2) = 0;
       Channel_Decoder_QAM(3*i-1) = 1;
       Channel_Decoder_QAM(3*i) = 0;
   elseif(sign_1>0&&sign_1<1&&sign_2<0)
       Channel_Decoder_QAM(3*i-2) = 1;
       Channel_Decoder_QAM(3*i-1) = 0;
       Channel_Decoder_QAM(3*i) = 0;
   elseif(sign_1>0&&sign_2<0&&sign_2>-1)
       Channel_Decoder_QAM(3*i-2) = 1;
       Channel_Decoder_QAM(3*i-1) = 1;
       Channel_Decoder_QAM(3*i) = 0;
   end
  elseif (Amplitude > 75)%big amplitude
   if(sign_1>0&&sign_2>0)
       Channel_Decoder_QAM(3*i-2) = 1;
       Channel_Decoder_QAM(3*i-1) = 1;
       Channel_Decoder_QAM(3*i) = 1;    
   elseif(sign_1>0&&sign_2<0)
       Channel_Decoder_QAM(3*i-2) = 1;
       Channel_Decoder_QAM(3*i-1) = 0;
       Channel_Decoder_QAM(3*i) = 1;
   elseif(sign_1<0&&sign_2>0)
       Channel_Decoder_QAM(3*i-2) = 0;
       Channel_Decoder_QAM(3*i-1) = 1;
       Channel_Decoder_QAM(3*i) = 1;
   elseif(sign_1<0&&sign_2<0)
       Channel_Decoder_QAM(3*i-2) = 0;
       Channel_Decoder_QAM(3*i-1) = 0;
       Channel_Decoder_QAM(3*i) = 1;
   end
  end
end

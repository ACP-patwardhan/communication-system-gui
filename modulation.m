function [demod1_5,demod2_5,ber2,ter] = modulation(data1,data2,val)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
format 
ber1=zeros(1,15);
ber2=zeros(1,15);
SNR=-5:9;
switch val
    case '16 FSK'
        snr_w=(4)*(10.^(SNR/10));
        ter=(2)*qfunc(sqrt(2*snr_w));
        len1=length(data1);
        len2=length(data2);
        x1=ceil(len1/4);
        x2=ceil(len2/4);
        tbm1=zeros(1,4*x1);
        tbm2=zeros(1,4*x2);
        tbm1(1:len1)=data1;
        tbm2(1:len2)=data2;
        tbm1=reshape(tbm1,[],4);
        tbm2=reshape(tbm2,[],4);
        data1_tbm=bi2de(tbm1);
        data2_tbm=bi2de(tbm2);
        mod_sig1=fskmod(data1_tbm,16,200,40,30000);
        mod_sig2=fskmod(data2_tbm,16,200,40,30000);
        for i=-5:9
            er1=awgn(mod_sig1,i);
            er2=awgn(mod_sig2,i);
            demod1=fskdemod(er1,16,200,40,30000);
            demod2=fskdemod(er2,16,200,40,30000);
            [~,BER1]=biterr(demod1,data1_tbm);
            [~,BER2]=biterr(demod2,data2_tbm);
            ber1(i+6)=BER1;
            ber2(i+6)=BER2;
            if(i==2)
                data_tbd1=de2bi(demod1,4);
                data_tbd2=de2bi(demod2,4);
                tbd1=reshape(data_tbd1,1,[]);
                tbd2=reshape(data_tbd2,1,[]);
                tbd1=tbd1(1:len1);
                tbd2=tbd2(1:len2);
                demod1_5=tbd1;
                demod2_5=tbd2;
            end
        end
        
    case '16 QAM'
        snr_w=(4)*(10.^(SNR/10));
        ter=(3/4)*qfunc(sqrt((4/5).*snr_w));
        len1=length(data1);
        len2=length(data2);
        x1=ceil(len1/4);
        x2=ceil(len2/4);
        tbm1=zeros(1,4*x1);
        tbm2=zeros(1,4*x2);
        tbm1(1:len1)=data1;
        tbm2(1:len2)=data2;
        tbm1=reshape(tbm1,[],4);
        tbm2=reshape(tbm2,[],4);
        data1_tbm=bi2de(tbm1);
        data2_tbm=bi2de(tbm2);
        mod_sig1 = qammod(data1_tbm,16);
        mod_sig2 = qammod(data2_tbm,16);
        for i=-5:9
            er1=awgn(mod_sig1,i);
            er2=awgn(mod_sig2,i);
            demod1=qamdemod(er1,16);
            demod2=qamdemod(er2,16);
            [~,BER1]=biterr(data1_tbm,demod1);
            [~,BER2]=biterr(data2_tbm,demod2);
            ber1(i+6)=BER1;
            ber2(i+6)=BER2;
            if(i==2)
                data_tbd1=de2bi(demod1,4);
                data_tbd2=de2bi(demod2,4);
                tbd1=reshape(data_tbd1,1,[]);
                tbd2=reshape(data_tbd2,1,[]);
                tbd1=tbd1(1:len1);
                tbd2=tbd2(1:len2);
                demod1_5=tbd1;
                demod2_5=tbd2;
                  
            end
        end
        scatterplot(mod_sig1);
        
    case '16 PSK'
        SNR=15:29;
        snr_w=(10.^(SNR/10));
        ter=0.5*qfunc(sqrt(8*(snr_w))*sin(pi/16));
        len1=length(data1);
        len2=length(data2);
        x1=ceil(len1/4);
        x2=ceil(len2/4);
        tbm1=zeros(1,4*x1);
        tbm2=zeros(1,4*x2);
        tbm1(1:len1)=data1;
        tbm2(1:len2)=data2;
        tbm1=reshape(tbm1,[],4);
        tbm2=reshape(tbm2,[],4);
        data1_tbm=bi2de(tbm1);
        data2_tbm=bi2de(tbm2);
        mod_sig1=pskmod(data1_tbm,16);
        mod_sig2=pskmod(data2_tbm,16);
        for i=15:29
            er1=awgn(mod_sig1,i);
            er2=awgn(mod_sig2,i);
            demod1=pskdemod(er1,16);
            demod2=pskdemod(er2,16);
            [~,BER1]=biterr(data1_tbm,demod1);
            [~,BER2]=biterr(data2_tbm,demod2);
            ber1(i-14)=BER1;
            ber2(i-14)=BER2;
            if(i==20)
                data_tbd1=de2bi(demod1,4);
                data_tbd2=de2bi(demod2,4);
                tbd1=reshape(data_tbd1,1,[]);
                tbd2=reshape(data_tbd2,1,[]);
                tbd1=tbd1(1:len1);
                tbd2=tbd2(1:len2);
                demod1_5=tbd1;
                demod2_5=tbd2;
            end
        end
        scatterplot(mod_sig1);
        
        
    case '32 QAM'
        SNR=15:29;
        snr_w=(10.^(SNR/10));
        ter=(4/5)*(1-sqrt(1/32))*qfunc(sqrt((15/31).*snr_w));
        len1=length(data1);
        len2=length(data2);
        x1=ceil(len1/5);
        x2=ceil(len2/5);
        tbm1=zeros(1,5*x1);
        tbm2=zeros(1,5*x2);
        tbm1(1:len1)=data1;
        tbm2(1:len2)=data2;
        tbm1=reshape(tbm1,[],5);
        tbm2=reshape(tbm2,[],5);
        data1_tbm=bi2de(tbm1);
        data2_tbm=bi2de(tbm2);
        mod_sig1 = qammod(data1_tbm,32);
        mod_sig2 = qammod(data2_tbm,32);
        for i=15:29
            er1=awgn(mod_sig1,i,'measured');
            er2=awgn(mod_sig2,i,'measured');
            demod1=qamdemod(er1,32);
            demod2=qamdemod(er2,32);
            [~,BER1]=biterr(data1_tbm,demod1);
            [~,BER2]=biterr(data2_tbm,demod2);
            if(BER1<10^(-7))
                BER1=0;
            end
            if(BER2<10^(-7))
                BER2=0;
            end
            ber1(i-14)=BER1;
            ber2(i-14)=BER2;
            if(i==25)
                data_tbd1=de2bi(demod1,5);
                data_tbd2=de2bi(demod2,5);
                tbd1=reshape(data_tbd1,1,[]);
                tbd2=reshape(data_tbd2,1,[]);
                tbd1=tbd1(1:len1);
                tbd2=tbd2(1:len2);
                demod1_5=tbd1;
                demod2_5=tbd2;
            end
        end
end
ter=ter.*(ber2~=0);
figure()
semilogy(SNR,ter,'b');
hold on
semilogy(SNR,ber1,'rx');
hold on
semilogy(SNR,ber2,'gx');
xlabel('SNR (dB)')
ylabel('BER')
legend('Theoretical model','without coding','with coding');
title('BER curve')

end


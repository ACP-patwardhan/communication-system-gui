% 
% A = imread('sample_image.bmp');
% [m,n]=size(A);
% bm=dec2bin(A);
% s=str2num(bm);
% encoded_data=encode(s,7,4);
% decoded_data=decode(encoded_data,7,4);
% x=num2str(decoded_data);
% im=reshape(x,m,n);
% im=(im=='1');
% imshow(im)


[data,fs]=audio2bits('sample_audio.m4a');
au=bits2audio(data);
sound(au,fs);
 format longG
% data=text2bits('sample_text.txt');
 encoded_data=Encode('(7,4) hamming code',data);
[demod_1,demod_2,ber2,ter]=modulation(data,encoded_data,'32 QAM');
% len=length(encoded_data);
% x=ceil(len/4);
% d=zeros(1,4*x);
% d(1:len)=encoded_data;
% d=reshape(d,[],4);
% d=bi2de(d);
% mod_sig=pskmod(d,16);
% ersig=awgn(mod_sig,20);
% demod_sig=pskdemod(ersig,16);
% r=de2bi(demod_sig,4);
% r=reshape(r,1,[]);
% r=r(1:len);
decoded_data=Decode('(7,4) hamming code',demod_2,length(data));
% text=bits2text(decoded_data);
rdata=bits2audio(decoded_data);
sound(rdata,fs)
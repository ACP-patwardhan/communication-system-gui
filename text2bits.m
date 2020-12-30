function  data= text2bits(filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    C=fileread(filename);
    data=(reshape(dec2bin(C,8),1,[]));
    data=data+0-'0';
end


function [s,m,n] = im2bits(filename)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
A = imread(filename);
[m,n]=size(A);
bm=dec2bin(A);
s=str2num(bm);
end


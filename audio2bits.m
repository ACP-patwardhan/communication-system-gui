function [data,fs] = audio2bits(filename)
    [y,fs]=audioread(filename);
    data=de2bi(typecast(y(:,1),'uint8'),8);
    data=reshape(data,1,[]);
end


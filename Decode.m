function decoded_data = HCdecode(val,data,len)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% data=reshape(data,[],7);
% decoded_data=decode(data,7,4);
% decoded_data=reshape(decoded_data,1,[]);
decoded_data=[];
    switch val
        case '(7,4) hamming code'
            tbd=reshape(data,[],7);
            decoded_data=decode(tbd,7,4);
            decoded_data=reshape(decoded_data,1,[]);
            decoded_data=decoded_data(1:len);
        case 'BCH (127,64) code'
            tbd=reshape(data,[],127);
            decoded_data=bchdec(gf(tbd),127,64);
            decoded_data=decoded_data.x;
            decoded_data=reshape(decoded_data,1,[]);
            decoded_data=decoded_data(1:len);
    end
end


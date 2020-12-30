function coded_data = Encode(val,data)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%      len=length(data);
%      x=ceil(len/4);
%      tbc=zeros(1,4*x);
%      tbc(1:len)=data;
%     tbc=reshape(tbc,[],4);
%     coded_data=encode(tbc,7,4);
%     coded_data=reshape(coded_data,1,[]);
    switch val
        case '(7,4) hamming code'
            len=length(data);
            x=ceil(len/4);
            tbc=zeros(1,4*x);
            tbc(1:len)=data;
            tbc=reshape(tbc,[],4);
            coded_data=encode(tbc,7,4);
            coded_data=reshape(coded_data,1,[]);
        case 'BCH (127,64) code'
            len=length(data);
            x=ceil(len/64);
            tbc=zeros(1,64*x);
            tbc(1:len)=data;
            tbc=reshape(tbc,[],64);
            coded_data=bchenc(gf(tbc),127,64);
            coded_data=coded_data.x;
            coded_data=reshape(coded_data,1,[]);
            
    end
    
end


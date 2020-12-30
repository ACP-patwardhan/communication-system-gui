function text = bits2text(data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    op=reshape(data,[],8);
    ch=char(op+'0');
    text=char(bin2dec(ch))';
end


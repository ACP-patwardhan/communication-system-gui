function au = bits2audio(data)
    if(class(data)=="double")
        data=reshape(data,[],8);
        au=bi2de(data);
        
    else
        data=reshape(data,[],8);
        au=typecast(bi2de(data),'double');
    end
end


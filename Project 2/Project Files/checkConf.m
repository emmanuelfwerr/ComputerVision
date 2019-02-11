function [p] = checkConf(a)
    i=1;
    p=0;
    while(i < 13) 
        p = p + a(i); 
        i = i+1;
    end
end


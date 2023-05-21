function out = WhitePatchRetinex(in,para)
%%%% copyright: ofalling %%%%
    if( nargin < 2 )
        para = 0;
    end
    out = zeros(size(in));
    inDouble = double(in);
    L = [0 0 0];
    if ( para == 0 )
        for i = 1:3
        L(i) = max(max(in(:,:,i)));
        out(:,:,i) = inDouble(:,:,i)/L(i);
        end
    elseif ( para == 1 )% more robust algorithm
        np = 0.1 * size(in,1)*size(in,2);
        for i = 1:3
            H = imhist(in(:,:,i));
            j = 256;
            sum = 0;
            while( (sum < np)&(j > 1) )
                j = j-1;
                sum = sum + H(j);
            end
                L(i) = j;
                out(:,:,i) = inDouble(:,:,i)/L(i);
        end
    end
end
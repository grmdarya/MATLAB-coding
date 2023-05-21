function imp = toPolarLog(im1)
    % ѕеревод декартовых координат в пол€рно-логарифмический вид
    SZ=size(im1);
    R_1=ceil(SZ(1)/2); 
        R=ceil(50*log(R_1)); 
    for i=1:R_1 
        for j=1:R 
            x(i,j) =(exp((i-1)/50) * cos((j-1)*pi/180)); 
            y(i,j) =(exp((i-1)/50) * sin((j-1)*pi/180)); 
            sub_pix=uint32(0);
            for di=-0.4:0.1:0.5 
                for dj=-0.4:0.1:0.5 
                    if (round(R_1-y(i,j)+di)>0) 
                        ind_i=round(R_1-y(i,j)+di);  
                    else
                        ind_i=1;
                    end
                    if (round(R_1+x(i,j)+dj)>0) 
                        ind_j=round(R_1+x(i,j)+dj); 
                    else
                        ind_j=1;
                    end
                    sub_pix=sub_pix + uint32(im1(ind_i,ind_j)); 
                end
            end
            buf_sp=uint8(sub_pix/100); 
            imp(i,j)=uint8(buf_sp); 
        end
    end
end

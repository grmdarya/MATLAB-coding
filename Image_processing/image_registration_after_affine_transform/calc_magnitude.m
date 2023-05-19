function ABS = calc_magnitude(img)
    F=fft2(double(img));
    S=fftshift(F);
    L=log2(S);
    ABS=abs(L);
end

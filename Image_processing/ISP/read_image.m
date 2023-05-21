function image = read_image(path, depth, sizes, k)

d_file = fopen(path, 'rb');
buf_file = fread(d_file, depth);
fclose(d_file);
image = uint16(double(reshape(buf_file, sizes)') * ...
              (2^k-1) / (2^10-1));
%               (2^k-1) / (2^bit_count(max(buf_file))-1));
              
          
end
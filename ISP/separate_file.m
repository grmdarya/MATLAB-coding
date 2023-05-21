function separate_file(path, new_file_name, file_size)

d_files = fopen(path, 'rb');
files = fread(d_files, '*uint8');

filepath = fileparts(path);

num_file = 1;

for offset = file_size : file_size : size(files, 1)
    
    tmp_d_file = fopen([filepath '\' new_file_name '_' num2str(num_file) '.raw'], 'wb');
    fwrite(tmp_d_file, files(offset - file_size + 1 : offset));
    fclose(tmp_d_file);
    
    num_file = num_file + 1;
    
end

fclose(d_files);

end
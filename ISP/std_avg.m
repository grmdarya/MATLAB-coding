function stdAvg = std_avg(matrix, proportion)

% Standard deviation-weighted gray world

block_sizes = size(matrix) ./ [proportion(2) proportion(1)];
block_count = proportion(1) * proportion(2);

sigmas = zeros(1, block_count);
means  = zeros(1, block_count);

for i = 1 : proportion(2)
   
    for j = 1 : proportion(1)
       
        sigmas((i - 1) * proportion(2) + j) ...
            = std(double(matrix((i - 1) * block_sizes(1) + 1 : i * block_sizes(1), ...
                                (j - 1) * block_sizes(2) + 1 : j * block_sizes(2))), 1, 'all');
        
        means((i - 1) * proportion(2) + j) ...
            = mean(double(matrix((i - 1) * block_sizes(1) + 1 : i * block_sizes(1), ...
                                 (j - 1) * block_sizes(2) + 1 : j * block_sizes(2))), 'all');
        
    end
    
end

stdAvg = sum(sigmas / sum(sigmas) .* means);

end


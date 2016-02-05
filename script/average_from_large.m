function CF_NEW = average_from_large(CF,timesteps)
    CF_NEW = zeros(timesteps,1);
    if(length(CF) == 1)
       CF_NEW = CF(1)*ones(timesteps,1);
    elseif(length(CF) == 2)
        CF_NEW(1) = CF(1);
    else
        for i = 1:timesteps
            j = (i-1)*length(CF)/timesteps+1;
            k = i*length(CF)/timesteps;

            CF_NEW(i) = mean(CF(j:k));
        end
    end
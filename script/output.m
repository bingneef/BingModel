%% generate output

z = 1;
for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    
    flow_names = obj.flow_names;
    fprintf('\n%s %.2f\n',char(component_names(i)),x(z));
    %fprintf('K$/y: %.2f\n',obj.costs(x)/1000);
    z = z + 1;
    p = 1;
    c = 0;
    for j = 1:length(flow_names)
        string = char(flow_names(j));
        fprintf('%s\n',char(flow_names(j)));
        for k = 1:timesteps
            %if(x(z) > 0)
                if(string(end) == 'T')
                    fprintf('%.2f\t',x(z));
                else
                    fprintf('%.2f\t',-x(z));
                end
            %end
            if(strcmp(obj.class,'stor'))
                c(p) = x(z);
            end
            p = p + 1;
            z = z + 1;
        end 
        fprintf('\n');
    end
    if(strcmp(obj.class,'stor'))
        in = c(1:timesteps);
        out_raw = c(timesteps+1:end);
        
        out = zeros(size(in));
        for j = 1:length(flow_names)-1
            out = out + out_raw((j-1)*timesteps + 1:j*timesteps);
        end
        
        interaction = in - out;
        charge = 0;
        for j = 2:length(interaction)+1
            charge(j) = charge(j-1) + interaction(j-1);
        end
        charge = charge - min(charge);
        fprintf('%.2f\tCapacity\n',max(charge));
        
    end
    
end
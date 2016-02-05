%% initiate
%clc;

%% Select Components
component_output = {...
    'WIND',...
    'SOLAR',...
    'SOLAR_BETA',...
    'CSP',...
    'METHANE',...
    'COAL',...
    'COW',...
    ...%
    'ACDC',...
    'DCAC',...    
    'ELEC',...
    'DCAC_BETA',...
    'ACDC_BETA',...
    'ELEC_BETA',...
    'DCFC',...
    'PEMFC',...
    'METHANE_REFORMER',...
    'DUNG_GASIFIER',...
    'GAS_TURBINE',...
    ...%
    ...%
    'BATTERY',...
    'H2_STORAGE',...
    'C_STORAGE',...
    'CH4_STORAGE',...
    'SOFC',...
    ...%
    'H2_PIPELINE',...
    ...%
    'SINK'...
    };

flow_names = {'AC','DC','HEAT 25','HEAT 800','CH4','H2','C','W','Dung','AC_BETA','DC_BETA','H2_BETA','W_BETA'};

obj = components.('SINK');

flows = [obj.ac, obj.dc,obj.h2,obj.W,obj.ac_beta,obj.h2_beta];
demand = [demand_ac,demand_dc,demand_H2,demand_W,demand_ac_beta,demand_h2_beta];

for i = 1:length(flows)
    fprintf('%s: ',char(flow_names(flows(i))))
    for j = 1:length(component_output)
        obj = components.(char(component_output(j)));
        pos = find(obj.in==flows(i));
        pos2 = find(obj.out==flows(i));
        print = 0;
        
        offset = 1;
        if(strcmp(obj.class,'stor'))
            offset = 2;
        end

        vars_in = zeros(1,timesteps);
        vars_out = zeros(1,timesteps);
        if(~isempty(pos))
            print = 1;            
            vars_in = x(obj.c+(pos-1)*timesteps+offset:obj.c+pos*timesteps+offset-1);
        end
            
        if(~isempty(pos2))
            print = 1;
            vars_out = x(obj.c+(pos2+length(obj.in)-1)*timesteps+offset:obj.c+(pos2+length(obj.in))*timesteps+offset-1);
        end

        if(sum(vars_out) > 0 || sum(vars_in) > 0)
            fprintf('%s ',char(component_output(j)))
        end
    end
    
    if(sum(demand(:,i)) > 0)
        fprintf('DEMAND');
    end
    fprintf('\n');
    
    for j = 1:length(component_output)
        obj = components.(char(component_output(j)));
        pos = find(obj.in==flows(i));
        pos2 = find(obj.out==flows(i));
        print = 0;
        
        offset = 1;
        if(strcmp(obj.class,'stor'))
            offset = 2;
        end

        vars_in = zeros(1,timesteps)';
        vars_out = zeros(1,timesteps)';
        if(~isempty(pos))
            print = 1;            
            vars_in = x(obj.c+(pos-1)*timesteps+offset:obj.c+pos*timesteps+offset-1);
        end
            
        if(~isempty(pos2))
            print = 1;
            vars_out = x(obj.c+(pos2+length(obj.in)-1)*timesteps+offset:obj.c+(pos2+length(obj.in))*timesteps+offset-1);
        end
        
        if(sum(vars_out) > 0 || sum(vars_in) > 0)
            vars = vars_out - vars_in;
            for k = 1:length(vars)
                fprintf('%.2f\t',vars(k));
            end
            fprintf('\n');
        end
    end
    
    if(sum(demand(:,i))>0 || print == 2)
        for k = 1:length(demand(:,i))
            fprintf('%.2f\t',-demand(k,i));
        end
    end
    
    fprintf('\n\n');

end

for i = 1:length(component_names)   
    obj = components.(char(component_names(i)));
    fprintf('%s\t%.2f',char(component_names(i)),x(obj.c))
    if(strcmp(obj.class,'stor') && x(obj.c+1) > 0)
        fprintf('\t%.2f',x(obj.c+1))
    end
    fprintf('\t%.2f',x(obj.c:obj.c+obj.cols-1)'*obj.makeCostArray());
    fprintf('\n');
end

fprintf('\n\n');

factor = kron([1 -1 -1],eye(timesteps));
for i = 1:length(component_names)
     obj = components.(char(component_names(i)));
     if(strcmp(obj.class,'stor') && x(obj.c+1) > 0)
         fprintf('%s\n',char(component_names(i)))
         delta_soc = factor*x(obj.c+2:obj.c+obj.cols-1);
         
         soc = zeros(length(delta_soc+1),1);
         for j = 1:length(delta_soc)
             soc(j) = sum(delta_soc(1:j))/(obj.timesteps/24);
         end
         soc_corr = soc/x(obj.c+1);
         soc_corr = (soc_corr + 1 - max(soc_corr))*100;
         
         for j = 1:length(soc_corr)
            fprintf('%.2f\t',soc_corr(j))
         end
         fprintf('%.2f\t',soc_corr(1))
         fprintf('\n\n');
             
     end
end


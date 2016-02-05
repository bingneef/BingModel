classdef (Abstract) comp_blueprint
    
    properties
        timesteps;
        rows;
        cols;
        
        %used to link CAPEX to OPEX
        sim_days = 1;
        
        %standard lifetime
        lifetime = 25;
        response_factor;
        power_to_capacity = 0;
        
        CF;
        component;

        IC = 0;
        
        matrix;
        
        %which colums first var
        c;
        
        ac               = 1;
        dc               = 2;
        heat_25          = 3;
        heat_800         = 4;        
        ch4              = 5;
        h2               = 6;
        C                = 7;
        W                = 8;
        dung             = 9;
        ac_beta          = 10;
        dc_beta          = 11;
        h2_beta          = 12;
        W_beta           = 13;

        
        %in&out
        in;
        out;
        
        %ratios
        ratio_in;
        ratio_out; 
        ratio; %only for FC's
        
    end
    
    properties (Abstract)
        capex;
        opex;
        nvars;
        flow_names;        
        class;
        response_time;
    end
    
    methods
        
        function M = makeMaxMatrix(obj)
            
            M = zeros(obj.rows,obj.cols);
            M(:,1) = -obj.CF;
            
            m = [];
            for i = 1:obj.nvars
                if(i > length(obj.in))
                    m = [m,eye(obj.rows)];
                else
                    m = [m,zeros(obj.rows)];
                end
                
            end
            
            if(strcmp(obj.class,'fc'))
                M(:,2+obj.timesteps:end) = m;
            elseif(strcmp(obj.class,'stor'))
                M(:,3:end) = m;
            else
                M(:,2:end) = m;
            end
        end
        
        function M = makeResponseMatrix(obj)
            
            
            m = -eye(obj.timesteps) + circshift(eye(obj.timesteps),[0,1]);
            M = -obj.response_factor * ones(obj.timesteps,1);
            if(strcmp(obj.class,'fc'))
                M = [M zeros(obj.timesteps)];
            end
            
            for i = 1:length(obj.in)
                M = [M zeros(obj.timesteps)];
            end
            
            for i = 1:length(obj.out)
                M = [M m];
            end
            
            if(strcmp(obj.class,'stor'))
                M = zeros(1*obj.timesteps,obj.cols);
            end
            %disp(obj.class)
            %disp(M)
            
            %M = zeros(1*obj.timesteps,obj.cols-1);
            %start = length(obj.in)*obj.timesteps;
            
            %if(strcmp(obj.class,'fc'))
            %    start = start + obj.timesteps;
            %end
            
            %M = zeros(1*obj.timesteps,obj.cols-1);
            %M(1:2:end,start+1:2:end) = obj.response_factor;
            %M(2:2:end,start+1:2:end) = -1;
            %M(1:2:end,start+2:2:end) = -1;
            %M(2:2:end,start+2:2:end) = obj.response_factor;
           
        end
        
        %needs work
        function M = makeRatioMatrix(obj)
            M = [];
            
            ratio_comb = [obj.ratio_in;obj.ratio_out].^-1;
            
            if(~isempty(obj.ratio_in) && ~isempty(obj.ratio_out) && ~strcmp(obj.class,'fc'))
                if(strcmp(obj.class,'stor'))
                    M = zeros((length(obj.ratio_out)-2)*obj.timesteps,length(obj.ratio_out));
                    z = 1;
                    for i = 1:length(obj.ratio_out) - 1
                        for j = 0:obj.timesteps-1
                            m = [obj.ratio_out(i)^-1, zeros(1,obj.timesteps-1),-obj.ratio_out(i+1)^-1];

                            M(z,z:z+length(m)-1) = m;
                            z = z+1;
                        end
                    end
                else
                    M = zeros((length(ratio_comb)-1)*obj.timesteps,length(ratio_comb));
               
                    z = 1;
                    for i = 1:length(ratio_comb) - 1
                        for j = 0:obj.timesteps-1
                            m = [ratio_comb(i), zeros(1,obj.timesteps-1),-ratio_comb(i+1)];

                            M(z,z:z+length(m)-1) = m;
                            z = z+1;
                        end
                    end
                    M = [zeros(length(M(:,1)),1),M];
                end
                
                
            end

            
           
            
%             if(~isempty(obj.ratio_in) && ~isempty(obj.ratio_out) && ~strcmp(obj.class,'fc'))
%                 M = [zeros(obj.timesteps,1),sum(obj.ratio_in)*eye(obj.timesteps),-obj.ratio_out(1).^-1*eye(obj.timesteps)];
%             end
%             
%             if(length(obj.ratio_in) > 1 && ~strcmp(obj.class,'fc'))
%                 ratio = obj.ratio_in(1:2).^-1;
%                 M = [zeros(obj.timesteps,1),ratio(1)*eye(obj.timesteps),-ratio(2)*eye(obj.timesteps)];
%             end
%             
%             if(length(obj.ratio_out) > 1 && ~strcmp(obj.class,'fc'))
%                 ratio = obj.ratio_out(1:2).^-1;
%                 M = [zeros(obj.timesteps,1),ratio(1)*eye(obj.timesteps),-ratio(2)*eye(obj.timesteps)];
%             end
        end
        
        function M = makeStorMatrix(obj)
            
            M = ones(1,obj.cols-obj.timesteps);
            M(1:2) = 0;
            M(3:2+obj.timesteps) = -obj.ratio_out(1);
        end
        
        function M = makeCapacityToPowerMatrix(obj)
            M = [0, 0];
            if(obj.power_to_capacity > 0)
                M = [-obj.power_to_capacity,1];
            end
        end
        
        function M = makeCapacityMatrix(obj)
            
            M = zeros(obj.timesteps*(obj.timesteps-1),obj.cols-1);
            M(:,1) = -1;
            factor = [-1 1 1]*obj.sim_days*24/obj.timesteps;
            m0 = kron(factor,eye(obj.timesteps));
            m = m0;
            M(1:obj.timesteps,2:end) = m;
            
            for i = 2:obj.timesteps-1
                m = m + circshift(m0,-i+1);
                M((i-1)*obj.timesteps+1:i*obj.timesteps,2:end) = m;
            end
        end
        
        function M = makeDemandMatrix(obj,M,flow)
            
            non_vars = 1;
            if(strcmp(obj.class,'fc'))
                non_vars = 1+obj.timesteps;
            elseif(strcmp(obj.class,'stor'))
                non_vars = 2;
            end
            
            pos_in = find(obj.in == flow, 1);
            if(~isempty(pos_in))
                
                offset = (pos_in-1) * obj.timesteps;
                m = -1*eye(obj.timesteps);
                
                M((flow-1)*obj.timesteps + 1:flow*obj.timesteps,...
                    obj.c+offset+non_vars:obj.c+obj.timesteps + offset + (non_vars-1)) = m;
            end
            
            pos_out = find(obj.out == flow, 1);
            if(~isempty(pos_out))
                m = eye(obj.timesteps);
                offset = (pos_out-1) * obj.timesteps;
                
                M((flow-1)*obj.timesteps + 1:flow*obj.timesteps,...
                    obj.c+offset+obj.timesteps*length(obj.in)+non_vars:obj.c++offset+obj.timesteps+obj.timesteps*length(obj.in) + (non_vars-1)) = m;
            end
        end
        
        function [c,ceq] = makeFuelCellMatrix(obj,x,c,ceq)
            
            if(~strcmp(obj.class,'fc'))
                return;
            end
            
            z = obj.c+1;
            for i = 1:obj.timesteps
               %between margins utilisation
               c = [c;x(z)-obj.ratio(2,1);x(z) * -1 + obj.ratio(1,1)];
               
               for j = 1:length(obj.ratio)-1
                    k = j + 1;
                    n_in = z + obj.timesteps;
                    n_out = n_in + j*obj.timesteps;
                    
                    %ratio at outflow
                    ceq = [ceq;...
                        x(n_in) - 1/(((obj.ratio(2,k)-obj.ratio(1,k))/(obj.ratio(2,1)-obj.ratio(1,1)))*(x(z)-obj.ratio(1,1))+obj.ratio(1,k))*x(n_out)];
                end
               
               z = z + 1;
            end                 
            
        end
        
        function c = costs(obj,x)
            %m = -1*ones(obj.cols,1);
            %m(1) = 0;
            %m(2:1+obj.timesteps) = 1;
            
            %c = x(obj.c:obj.c+obj.cols-1)*m;
            
            %d = sum(x(obj.c+1:obj.c+obj.timesteps*length(obj.in)));
            
            
            m = obj.opex * ones(obj.cols,1)';
            m(1) = obj.capex;
            offset = 1;
            
            if(strcmp(obj.class,'stor'))
                offset = 2;
                m(2) = obj.capacity_ex * obj.sim_days * 24 / obj.timesteps;
            end
            
            c = x(obj.c) * obj.capex/obj.lifetime + ...
                sum(x(obj.c+offset:obj.c+obj.cols-1))*obj.opex/100*24*obj.sim_days*365/obj.timesteps;
               
            c = x(obj.c:obj.c+obj.cols-1)*m;
        end
        
        function y = vars(obj,x)
            y = x(obj.c+1:obj.c+obj.timesteps);
        end
        
        function S = varList(obj)
            S = obj.flow_names;
        end
        
        function W = getOut(obj,x)            
            W = sum(x(obj.c + 1 : obj.c + obj.timesteps*length(obj.in)));
        end
        
        function W = getIn(obj,x)
            W = sum(x(obj.c + obj.timesteps*length(obj.in) + 1 : obj.c + obj.cols - 1));
        end
        
        function rf = responseFactor(obj)
            rf = obj.sim_days*24*60*60/(obj.response_time*obj.timesteps);
            if(rf > 1)
                rf = 1;
            end
        end

        function [M,ic] = makeICMatrix(obj)
            ic = obj.IC;
            M = zeros(1,obj.cols);
            M(1) = 1;
        end
        
        function m = makeCostArray(obj)
            m = obj.opex * ones(obj.cols,1) * obj.sim_days*24/obj.timesteps;
            m(1) = obj.capex;
            
            if(strcmp(obj.class,'stor'))
                m(2) = obj.capacity_ex;
            elseif(strcmp(obj.class,'fc'))
                m(2:obj.timesteps+1) = 0;
            end

        end
            
        
    end
    
end
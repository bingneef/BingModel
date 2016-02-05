classdef fc_sofc < comp_blueprint
    properties
        nvars = 4;
        flow_names = {'UTILISATION','CH4 IN','DC OUT','H2 OUT','WASTE'};        
        capex = 5;
        opex = 1;   
        response_time = 0;
        class = 'fc';
    end
    
    methods
        function obj = fc_sofc(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps*(obj.nvars+1) + 1;
            
            obj.in = [obj.ch4];
            obj.out = [obj.dc,obj.h2,obj.W];
            
            obj.ratio = [...
                60,0.55,0.25,0.20;...
                95,0.70,0.05,0.25...
                ];
            %obj.response_factor = obj.responseFactor();
            obj.response_factor = 0.5;
        end
        
%         function [c,d] = costs(obj,x)
%             
%             c = x(obj.c) * obj.capex/obj.lifetime + ...
%                 sum(x(obj.c+obj.timesteps+1:obj.c+obj.cols-1))*obj.opex/100*24*obj.sim_days*365/obj.timesteps;
%             d = 0;
%         end
    end
end
classdef stor_battery < comp_blueprint
    properties
        nvars = 3;
        flow_names = {'DC IN','DC OUT','WASTE'};        
        capex = 0;
        opex = 1.27;%0.02;   
        response_time = 0;
        capacity_ex = 126.663636364;%2.30;
        class = 'stor';
        
        
    end
    
    methods
        function obj = stor_battery(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            
            obj.lifetime = 10;
            obj.power_to_capacity = 6;
            
            obj.timesteps = timesteps;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.nvars * obj.timesteps + 2;
            
            obj.in = obj.dc;
            obj.out = [obj.dc,obj.W];
            
            obj.ratio_in = [1];
            obj.ratio_out = [0.80;0.20];
            obj.response_factor = obj.responseFactor();
        end
    end
end
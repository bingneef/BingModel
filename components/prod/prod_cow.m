classdef prod_cow < comp_blueprint
    properties
        nvars = 1;
        flow_names = {'DUNG OUT'};        
        capex = 50;
        opex = 50;   
        response_time = 0;
        class = 'prod';
    end
    
    methods
        function obj = prod_cow(comp,CF,timesteps)
            obj.CF = CF;
            obj.component = comp;
            obj.timesteps = timesteps;
            
            obj.lifetime = 20;
            
            obj.rows = obj.timesteps;
            obj.cols = obj.timesteps + 1;
            
            obj.in = [];
            obj.out = obj.dung;
            obj.response_factor = obj.responseFactor();
        end
    end
end
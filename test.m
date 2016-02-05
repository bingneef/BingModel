x1 = [];
factor = ones(2,1);

for i = 1:length(component_names)
    obj = components.(char(component_names(i)));
    offset = 1;
    if(strcmp(obj.class,'stor'))
        offset = 2;
    end
    
    states = x(obj.c:obj.c+offset-1)';
    timevars = x(obj.c+offset:obj.c+obj.cols-1)';
    
    x1 = [x1;states;kron(timevars,factor)];
end

save('test.mat','x1');

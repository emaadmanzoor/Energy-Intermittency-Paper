function [ optimal_vars, optimal_val, objfunc, objcons, ...
    x_1, x_2, y_t, y_s ] = optimize ( parameters )

%% Optimize

% set up
x0 = [1 1];     % Make a starting guess at the solution
%options = optimoptions(@fmincon,'Algorithm','sqp');

objcons = @(obj_vars) constraints(obj_vars(1), obj_vars(2), parameters);

objfunc = @(obj_vars) obj_f(obj_vars(1), obj_vars(2), parameters);

[optimal_vars, optimal_val] = ... 
    fmincon(@(obj_vars) objfunc(obj_vars),x0,[],[],[],[],[0 0],[],@(obj_vars) objcons(obj_vars));


%% Info

xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;

p_t = optimal_vars(1);
p_s = optimal_vars(2);
x_1 = (2*p_1)^(-1)*(p_t*xi_1 + p_s*xi_1);
x_2 = (2*p_2)^(-1)*(p_t*xi_2_t + p_s*xi_2_s);
y_t = xi_1*x_1 + xi_2_t*x_2;
y_s = xi_1*x_1 + xi_2_s*x_2;

[x_1 x_2, y_t, y_s];

end
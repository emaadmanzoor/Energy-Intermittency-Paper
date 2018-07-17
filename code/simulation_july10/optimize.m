function [ optimal_vars, optimal_val, objfunc, objcons, ...
    p_t, p_s, y_t, y_s ] = optimize ( parameters, debug )

%% Optimize

% set up
x0 = [1 1];     % Make a starting guess at the solution
options = optimoptions(@fmincon,'MaxFunctionEvaluations', 6000);

objcons = @(obj_vars) constraints(obj_vars(1), obj_vars(2), parameters);

objfunc = @(obj_vars) obj_f(obj_vars(1), obj_vars(2), parameters);

if ~debug
    [optimal_vars, optimal_val] = fmincon(@(obj_vars) objfunc(obj_vars), ...
        x0,[],[],[],[],[0 0],[],@(obj_vars) objcons(obj_vars), options);
else
    
    xi_1   = parameters.xi_1; 
    xi_2_t = parameters.xi_2_t;
    xi_2_s = parameters.xi_2_s;
    alpha  = parameters.alpha;
    beta   = parameters.beta;
    budget = parameters.budget;
    p_1    = parameters.p_1;
    p_2    = parameters.p_2;
    
    % profit first-order max
    p_t = -(p_2*xi_1 - p_1*xi_2_s)/(xi_1*(xi_2_s - xi_2_t));
    p_s = (p_2*xi_1 - p_1*xi_2_t)/(xi_1*(xi_2_s - xi_2_t));
    
    % utility first-order max
    y_t = alpha*budget/p_t;
    y_s = beta*budget/p_s;
    
    % solutions for x
    x_2 = (y_t - y_s)/(xi_2_t - xi_2_s);
    x_1 = (y_t - xi_2_t*x_2)/xi_1;
    
    optimal_vars = [x_1, x_2];
    optimal_val = 0;
    
end

%% Info

xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;

x_1 = optimal_vars(1);
x_2 = optimal_vars(2);
y_t = xi_1*x_1 + xi_2_t*x_2;
y_s = xi_1*x_1 + xi_2_s*x_2;
p_t = -(p_2*xi_1 - p_1*xi_2_s)/(xi_1*(xi_2_s - xi_2_t));
p_s = (p_2*xi_1 - p_1*xi_2_t)/(xi_1*(xi_2_s - xi_2_t));

end
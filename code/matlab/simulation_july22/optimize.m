function [ optimal_vars, optimal_val, objfunc, objcons ] = optimize ( parameters )

%% Optimize

% set up
price_coeffs_est = ones(1,24);     % Make a starting guess at the solution
options = optimoptions(@fmincon,'MaxFunctionEvaluations', 5000, 'Algorithm', 'interior-point');

objcons = @(obj_vars) constraints(obj_vars, parameters);

objfunc = @(obj_vars) obj_f(obj_vars, parameters);


[optimal_vars, optimal_val] = fmincon(@(obj_vars) objfunc(obj_vars), ...
    price_coeffs_est, [],[],[],[],zeros(1,24),[], ...
    @(obj_vars) objcons(obj_vars), options);



end
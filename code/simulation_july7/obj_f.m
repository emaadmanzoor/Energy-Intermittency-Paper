function [ obj_value ] = obj_f ( p_t, p_s, parameters )

xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;


% supply
x_1 = (p_1)^(-1)*(p_t*xi_1 + p_s*xi_1);
x_2 = (p_2)^(-1)*(p_t*xi_2_t + p_s*xi_2_s);
y_t_supply = xi_1*x_1 + xi_2_t*x_2;
y_s_supply = xi_1*x_1 + xi_2_s*x_2;

% demand
y_t_demand = alpha*budget/p_t;
y_s_demand = beta*budget/p_s;

% output used
y_t = min(y_t_supply, y_t_demand);
y_s = min(y_s_supply, y_s_demand);


% utility max
% umax_t = y_t - alpha*budget/p_t;
% umax_s = y_s - beta*budget/p_s;

profit = (y_t*p_t + y_s*p_s) - (p_1*x_1^2/2 + p_2*x_2^2/2);
utility = y_t^alpha * y_s*beta;

output_diff_t = (y_t_supply - y_t_demand).^2;
output_diff_s = (y_s_supply - y_s_demand).^2;

%obj_value = pmax_1.^2 + pmax_2.^2 + umax_t.^2 + umax_s.^2;

obj_value = -utility;





end

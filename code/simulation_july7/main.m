
parameters.xi_1   = 4.0001; 
parameters.xi_2_t = 6;
parameters.xi_2_s = 2;
parameters.alpha  = 0.7;
parameters.beta   = 0.3;
parameters.budget = 100;
parameters.p_1    = 0.5; % not used
parameters.p_2    = 0.5; % not used


%% Optimize

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = optimize ( parameters );


%% Load results

% exog
xi_1   = parameters.xi_1; 
xi_2_t = parameters.xi_2_t;
xi_2_s = parameters.xi_2_s;
alpha  = parameters.alpha;
beta   = parameters.beta;
budget = parameters.budget;
p_1    = parameters.p_1;
p_2    = parameters.p_2;

% endog
p_t = optimal_vars(1);
p_s = optimal_vars(2);
x_1 = (2*p_1)^(-1)*(p_t*xi_1 + p_s*xi_1);
x_2 = (2*p_2)^(-1)*(p_t*xi_2_t + p_s*xi_2_s);


%% Check results

%%% objectives
profit = (y_t*p_t + y_s*p_s) - (p_1*x_1^2 + p_2*x_2^2);
utility = (y_t^alpha + y_s^beta);

disp('')
fprintf('\nProfit: %f\n', profit)
fprintf('Utility: %f\n', utility)


%% Parameter effects params

delta = 0.001;
xi_1_init = 4;
xi_2_t_init = 6;
xi_2_s_init = 2;


%% Parameter effects: xi_1

parameters.xi_1 = xi_1_init;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

x_1_temp = x_1;
x_2_temp = x_2;
y_t_temp = y_t;
y_s_temp = y_s;

parameters.xi_1 = xi_1_init + delta;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

[(x_1 - x_1_temp)/delta (x_2 - x_2_temp)/delta ...
    (y_t - y_t_temp)/delta (y_s - y_s_temp)/delta]


%% Parameter effects: xi_2_t

parameters.xi_2_t = xi_2_t_init;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

x_1_temp = x_1;
x_2_temp = x_2;
y_t_temp = y_t;
y_s_temp = y_s;


parameters.xi_2_t = xi_2_t_init + delta;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

[(x_1 - x_1_temp)/delta (x_2 - x_2_temp)/delta ...
    (y_t - y_t_temp)/delta (y_s - y_s_temp)/delta]


%% Parameter effects: xi_2_s

parameters.xi_2_s = xi_2_s_init;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

x_1_temp = x_1;
x_2_temp = x_2;
y_t_temp = y_t;
y_s_temp = y_s;


parameters.xi_2_s = xi_2_s_init + delta;

[ optimal_vars, optimal_val, objfunc, objcons, x_1, x_2, y_t, y_s ] = ...
    optimize ( parameters );

[(x_1 - x_1_temp)/delta (x_2 - x_2_temp)/delta ...
    (y_t - y_t_temp)/delta (y_s - y_s_temp)/delta]




%% Check solution

% x_1 = (2*p_1)^(-1)*(p_t*xi_1 + p_s*xi_1)
% x_2 = (2*p_2)^(-1)*(p_t*xi_2_t + p_s*xi_2_s)
% 
% y_t = xi_1*x_1 + xi_2_t*x_2;
% y_s = xi_1*x_1 + xi_2_s*x_2;
% 
% profit = (y_t*p_t + y_s*p_s) - (p_1*x_1^2 + p_2*x_2^2)
% utility = (y_t^alpha + y_s^beta)
% 



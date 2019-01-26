
%% Params

% Initial Prices
p_1 = 10;
p_2 = 10;
xi_1_d = 5;
xi_1_n = 5;
xi_2_d = 10;
xi_2_n = 4;

% cobb-douglas utiltiy
alpha = 0.3;
beta = 0.7;
budget = 50;


%% Objectives

% Profit
profit = @(x) max([output_d(x)*inv_demand_d(x) ...
        + output_n(x)*inv_demand_n(x) - (cost_x(x)), 0]);

output_d = @(x) xi_1_d.*x(1) + xi_2_d.*x(2);
output_n = @(x) xi_1_n.*x(1) + xi_2_n.*x(2);
    
% Utility
utility = @(x) output_d(x).^alpha * output_n(x).^beta;

% Objective
neg_profit = @(x) -profit(x)*1000;
neg_utility = @(x) -utility(x)*1000;
objfunc = @(obj_vars) neg_profit(obj_vars(1:2));


%% Optimization

% run
x0 = ones(1,6);     % Make a starting guess at the solution
options = optimoptions(@fmincon,'Algorithm','sqp');

constraints = @(obj_vars) confun(obj_vars, p_1, p_2, xi_1_d, xi_1_n, xi_2_d, ...
    xi_2_n, alpha, beta, budget);

[x1,fval] = ... 
fmincon(@(obj_vars) objfunc(obj_vars),x0,[],[],[],[],[],[],@(obj_vars) constraints(obj_vars),options);



%%
log_X_ratio = log(X(:,1)./X(:,2));
log_P_ratio = log(p_1./range_temp);

x = X(1,:);
revenue = output_d(x)*inv_demand_d(x) + output_n(x)*inv_demand_n(x);
costs   = x(1)*p_1 + x(2)*p_2;

plot(-log_P_ratio', log_X_ratio)
title('Log Input Differences versus (-1) * Log Price Differences')
ylabel('Log(X_{constant}/X_{intermittent})')
xlabel('-Log(P_{constant}/P_{intermittent})')

[b,bint,r,rint,stats] = regress(log_X_ratio, [- log_P_ratio', ones(n,1)]);
estimated_lxd = [-log_P_ratio', ones(n,1)]*b;

hold on;
plot(-log_P_ratio', estimated_lxd, '--')
hold off;

text(mean(-log_P_ratio)+0.05, mean(log_X_ratio)*1.2, ['R^2 = ' num2str(stats(1))])




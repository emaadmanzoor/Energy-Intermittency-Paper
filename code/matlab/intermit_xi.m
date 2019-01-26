
% Initial Prices
p_1 = 10;
p_2 = 10;
c_1 = 0.5;
c_2 = 0.5;
xi_1_d = 5;
xi_1_n = 5;
xi_2_d = 10;
xi_2_n = 4;

% cobb-douglas utiltiy
alpha = 0.3;
beta = 0.7;
budget = 50;

% cost function
eta_1 = 3;
eta_2 = 3;


n = 20;
range_temp = linspace(0.7*xi_1_n, 1.3*xi_1_n, n);    
X = [];
    

for i = 1:n
    
    xi_1_n = range_temp(i);

    % Output function
    output_d = @(x) xi_1_d.*x(1) + xi_2_d.*x(2);
    output_n = @(x) xi_1_n.*x(1) + xi_2_n.*x(2);

    % Input cost functions
    cost_x = @(x) (p_1*x(1)^2 + p_2*x(2)^2); %(p_1 + log(x(1)))*x(1) + (p_2 + log(x(2)))*x(2);
    
    % Demand functions
    demand_d = @(x) (alpha*budget)/x(3);
    demand_n = @(x) (beta*budget)/x(4);
    
    inv_demand_d = @(x) (alpha*budget)/output_d(x);   %15 - log(output_d(x)+1);
    inv_demand_n = @(x) (beta*budget)/output_n(x);   %15 - log(output_n(x)+1);
    %inv_demand_d = @(x) 1500 - output_d(x)^2% log(output_d(x)+1);
    %inv_demand_n = @(x) 1500 - output_n(x)^2% log(output_n(x)+1);
    
    % Profit
    revenue_d = @(x) min([output_d(x), demand_d(x)])*x(3);
    revenue_n = @(x) min([output_n(x), demand_n(x)])*x(4);
    profit = @(x) output_d(x)*inv_demand_d(x) + output_n(x)*inv_demand_n(x) ... 
        - (cost_x(x));
    
    % Utility
    utility = @(x) output_d(x).^alpha * output_n(x).^beta;

    % Objective
    neg_profit = @(x) -profit(x)*1000;
    neg_utility = @(x) -utility(x)*10000;
    obj = @(x) neg_utility(x);
    
    
    %% Run
    options = optimoptions(@fmincon,'Algorithm','sqp');

    constraints = @(obj_vars) confun(obj_vars, p_1, p_2, c_1, c_2, xi_1_d, ...
        xi_1_n, xi_2_d, xi_2_n, alpha, beta, budget, eta_1, eta_2);

    [result,fval] = ... 
    fmincon(@(obj_vars) obj(obj_vars),[1 1 1 1],[],[],[],[],...
    [0 0 0 0],[],@(obj_vars) constraints(obj_vars),options);


    X(i, :) = result;
    
end


%%
Z = X(:,1)./X(:,2);
W = xi_1_d./range_temp';

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




%%% Algebraic Solutions 

syms xi_1_t xi_1_s xi_2_t xi_2_s p_1 p_2 p_t p_s x_1 x_2
syms alpha beta budget y_t y_s
syms sigma p_t_opt


assume([p_t > 0, p_s > 0, alpha + beta == 1, alpha > 0, beta > 0, ...
    alpha < 1, beta < 1, budget > 0, p_1 > 0, p_2 > 0, ...
    xi_1_s > 0, xi_2_s > 0, xi_1_t > 0, xi_2_t > 0, sigma > 0, x_1 >= 0, x_2 >= 0])


%% Profit maximization

[x_1_prof, x_2_prof] = solve(p_t*xi_1_t + p_s*xi_1_s - 2*p_1*x_1 == 0 ,...
                           p_t*xi_2_t + p_s*xi_2_s - 2*p_2*x_2 == 0, x_1, x_2)
                       

%% Utility max

[x_1_util, x_2_util] = solve( ...
    p_t == (alpha*budget)/(xi_1_t*x_1 + xi_2_t*x_2), ...
    p_s == (beta*budget)/(xi_1_s*x_1 + xi_2_s*x_2), ...
    ...%(alpha*budget)*(xi_1_t./(xi_1_t*x_1 + xi_2_t*x_2)) + (beta*budget)*(xi_1_s./(xi_1_s*x_1 + xi_2_s*x_2)) == 0, ...
    ...%(alpha*budget)*(xi_2_t./(xi_1_t*x_1 + xi_2_t*x_2)) + (beta*budget)*(xi_2_s./(xi_1_s*x_1 + xi_2_s*x_2)) == 0, ...
    (xi_1_t*x_1 + xi_2_t*x_2)*p_t + (xi_1_s*x_1 + xi_2_s*x_2)*p_s == budget, x_1, x_2)
    
               
%% Central Planner Welfare maximization

[x_1_cent, x_2_cent] = solve(...
    [(alpha*budget)*(xi_1_t/(xi_1_t*x_1 + xi_2_t*x_2)) + (beta*budget)*(xi_1_s/(xi_1_s*x_1 + xi_2_s*x_2)) + ...
    p_t*xi_1_t + p_s*xi_1_s - 2*p_1*x_1 == 0,  ...
    (alpha*budget)*(xi_2_t/(xi_1_t*x_1 + xi_2_t*x_2)) + (beta*budget)*(xi_2_s/(xi_1_s*x_1 + xi_2_s*x_2)) + ...
    p_t*xi_2_t + p_s*xi_2_s - 2*p_2*x_2 == 0, ...
    y_t == (xi_1_t*x_1 + xi_2_t*x_2), ...
    y_s == (xi_1_t*x_1 + xi_2_t*x_2)], ...
    [x_1, x_2])
      

% multiplied by Y_s*Y_t with linear costs
[x_1_cent, x_2_cent] = solve(...
    [(alpha*budget)*((xi_1_t*x_1 + xi_2_t*x_2)*xi_1_t) + ...
        (beta*budget)*(xi_1_s*(xi_1_t*x_1 + xi_2_t*x_2)) + ...
        (p_t*xi_1_t + p_s*xi_1_s - 2*p_1*x_1)*(xi_1_t*x_1 + xi_2_t*x_2)*(xi_1_t*x_1 + xi_2_t*x_2) == 0, ...
    (alpha*budget)*((xi_1_t*x_1 + xi_2_t*x_2)*xi_2_t) + ...
        (beta*budget)*(xi_2_s*(xi_1_t*x_1 + xi_2_t*x_2)) + ...
        (p_t*xi_2_t + p_s*xi_2_s - 2*p_2*x_2)*(xi_1_t*x_1 + xi_2_t*x_2)*(xi_1_t*x_1 + xi_2_t*x_2) == 0], ...
    [x_1, x_2])


%% Cobb-Douglas decentralized

x_1_opt = (p_t*xi_1_t + p_s*xi_1_s) / (2*p_1);
x_2_opt = (p_t*xi_2_t + p_s*xi_2_s) / (2*p_2);
p_t_opt = (alpha*budget)/(xi_1_t*x_1_opt + xi_2_t*x_2_opt);
p_s_opt = (beta*budget)/(xi_1_s*x_1_opt + xi_2_s*x_2_opt);


solve(...
xi_1_t*(p_t*xi_1_t + p_s*xi_1_s) / (2*p_1) + ...
xi_2_t*(p_t*xi_2_t + p_s*xi_2_s) / (2*p_2) == ...
alpha*budget/p_t, p_t)

%% CES decentralized

S = solve(...
    [xi_1_t*x_1 + xi_2_t*x_2 == (alpha/p_t)^sigma * (budget)/(alpha^sigma * p_t^(1-sigma) + beta^sigma * p_s^(1-sigma)), ...
    xi_1_s*x_1 + xi_2_s*x_2 == (beta/p_s)^sigma  * (budget)/(alpha^sigma * p_t^(1-sigma) + beta^sigma * p_s^(1-sigma)), ...
    (p_t*xi_1_t + p_s*xi_1_s) / (2*p_1) == x_1, ...
    (p_t*xi_2_t + p_s*xi_2_s) / (2*p_2) == x_2], ...
    [x_1, x_2, p_t, p_s], 'ReturnConditions', true)

%% Lagrangian

syms lambda

L = alpha*log(xi_1_t*x_1 + xi_2_t*x_2) + beta*log(xi_1_s*x_1 + xi_2_s*x_2) ...
    - lambda*(p_t*(xi_1_t*x_1 + xi_2_t*x_2) + p_s*(xi_1_s*x_1 + xi_2_s*x_2));

L_x1 = diff(L, x_1);
L_x2 = diff(L, x_2);
L_lambda = diff(L, lambda);
l_alpha = diff(L, alpha);

L_x1_x1 = diff(L_x1, x_1);
L_x1_x2 = diff(L_x1, x_2);
L_x1_lambda = diff(L_x1, lambda);

L_x2_x2 = diff(L_x2, x_2);
L_x2_lambda = diff(L_x2, lambda);

L_lambda_lambda = diff(L_lambda, lambda);


%% Assuming X_1 equally productive at day and night

syms xi_1

y_t = xi_1*x_1 + xi_2_t*x_2;
y_s = xi_1*x_1 + xi_2_s*x_2;

% based on linear cost

%profit max 
p_t_opt = p_1/xi_1 - p_s;

S = solve([y_t - y_s == alpha*budget/(p_t_opt) - beta*budget/(p_s)], [x_2])

x_2_opt = simplify(S);
 
S = solve([xi_1*x_1 * xi_2_t*x_2_opt == alpha*budget/(p_t_opt)], x_1)

x_1_opt = simplify(S);

S = solve([xi_1*x_1 * xi_2_s*x_2_opt == beta*budget/(p_s)], x_1)

x_1_opt_2 = simplify(S);







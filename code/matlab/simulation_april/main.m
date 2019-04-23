%%% Model %%%
% Linear cost
% CES Utility
% Two Periods


%% CES Numerical Sim

alpha = [0.3, 0.7];
xi_1  = [1, 1];
xi_2  = [0, 1];

sigma = 2;
phi   = (sigma - 1)/sigma;
budget = 1e4;

x_1_cost_param = 95*0.9;
x_2_cost_param = 50;

% Prices
xi_mat   = [xi_1; xi_2];
cost_mat = [x_1_cost_param; x_2_cost_param];
prices   = xi_mat\cost_mat;

% Price Index
P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

% Quantities
Y = ((alpha'./prices).^(sigma)) * (budget/P);
X = (xi_mat')\Y


%% CD Numerical Sim

alpha = [0.3, 0.7];
xi_1  = [1, 1];
xi_2  = [0, 1];

budget = 1;

x_1_cost_param = 95*0.9;
x_2_cost_param = 50;

% Prices
xi_mat   = [xi_1; xi_2];
cost_mat = [x_1_cost_param; x_2_cost_param];
prices   = xi_mat\cost_mat;

% Quantities
Y = ((alpha'./prices).^(1))*budget;
X = (xi_mat')\Y


%% Price (Cost) Elasticity Sim

n = 500;
results = zeros(n,2); 
cost_multiplier = linspace(0.5,2.5,n);

for i = 1:n
    
    alpha = [0.3, 0.7];
    xi_1  = [1,   1];
    xi_2  = [0.1, 1];

    sigma = 5;
    phi   = (sigma - 1)/sigma;
    budget = 1;

    x_1_cost_param = 95*cost_multiplier(i);
    x_2_cost_param = 50;

    % Prices
    xi_mat   = [xi_1; xi_2];
    cost_mat = [x_1_cost_param; x_2_cost_param];
    prices   = xi_mat\cost_mat;
    
    if any(prices<0)
        continue
    end
    
    % Price Index
    P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

    % Quantities
    Y = ((alpha'./prices).^(sigma)) * (budget/P);
    X = (xi_mat')\Y;
    
    results(i,:) = X';
    
end    
    
output = [];
output(1,:) = 95*cost_multiplier'./50;
output(2,:) = results(:,1)./results(:,2);

% subset to positive quantities
ind = ~any(output <= 0);
output = output(:,ind);

% relationship between log prices and quantities
plot(log(output(2,:)), log(output(1,:)))
ylabel('Log Difference in Prices')
xlabel('Log Difference in Quantities')

    
%% Sigma Effects Sim

n = 100;
results = zeros(n,2); 
sigma_range = linspace(0.01,2,n);

for i = 1:n
   
    alpha = [0.3, 0.7];
    xi_1  = [1, 1];
    xi_2  = [0, 1];

    sigma = sigma_range(i);
    phi   = (sigma - 1)/sigma;
    budget = 1;

    x_1_cost_param = 95*0.9;
    x_2_cost_param = 50;

    % Prices
    xi_mat   = [xi_1; xi_2];
    cost_mat = [x_1_cost_param; x_2_cost_param];
    prices   = xi_mat\cost_mat;
    
    if any(prices<0)
        continue
    end
    
    % Price Index
    P = ((1/2) * (prices'.^(1-sigma))*(alpha'.^sigma)).^(1/(1-sigma));

    % Quantities
    Y = ((alpha'./prices).^(sigma)) * (budget/P);
    X = (xi_mat')\Y;
    
    results(i,:) = X';
    
end    
    
output = [];
output(1,:) = sigma_range';
output(2,:) = results(:,1)./results(:,2);

% subset to positive quantities
ind = ~any(output <= 0);
output = output(:,ind);

% relationship between log prices and quantities
plot((output(1,:)), log(output(2,:)))
xlabel('Elasticity of Substitution (\sigma)')
ylabel('Log Difference in Quantities')

%% Scratch - Standard

syms xi_1t xi_1s xi_2t xi_2s xi_1
syms c_1 c_2 tau
syms p_t p_s
syms P I
syms alpha_t alpha_s sigma
syms Z_t Z_s
syms gamma 
syms PS_c_1
syms beta c_beta

syms sigma;
sigma = 1;
xi_mat = [xi_1t xi_1s; xi_2t 0];
p = inv(xi_mat)*[c_1+tau;c_2];
% p_t = p(1);
% p_s = p(2);
eta = inv(xi_mat);
X = (inv(xi_mat.'))*([alpha_t/p(1); alpha_s/p(2)].^(sigma));
Z = xi_mat.'*X;
 
assume([c_1 > 0, c_2 > 0, xi_1t > 0, xi_2t > 0, xi_1s > 0, xi_2s > 0,   ...
    alpha_t > 0, alpha_s > 0, gamma > 0, PS_c_1 < 0,                    ...
    xi_2t/c_2 > xi_1t/c_1, xi_1s/c_1 > xi_2s/c_2,                       ...
    (((alpha_s*(xi_1s/c_1 - xi_2s/c_2))/                                ...
    ((alpha_t)*(xi_2t/c_2 - xi_1t/c_1))) > xi_2s/xi_2t),                ...     
    (((alpha_s*(xi_1s/c_1 - xi_2s/c_2))/                                ...
    ((alpha_t)*(xi_2t/c_2 - xi_1t/c_1))) < xi_1s/xi_1t),                ...
    xi_1s*xi_2t - xi_1t*xi_2s > 0,                                      ...
    c_1*xi_2s - c_2*xi_1s < 0,                                          ...
    c_1*xi_2t - c_2*xi_1t > 0]);


sol = solve(gamma*(diff(X(1), tau))                                   ...
    == diff(X(1)*tau, tau) +            ...
    (-Z.'*diff(p, tau)), tau)
    
expand(simplify(sol))

%%

assume([beta > 0, c_beta > 0]);

sol2 = solve(gamma*(diff(X(1), beta))                                   ...
    == diff(X(1)*gamma, beta) - c_beta +            ...
    (-Z.'*diff(p, beta)), beta)

simplify(subs(sol2, tau, gamma), 'Steps', 3000)

%% Scratch beta

syms xi_1t xi_1s xi_2t xi_2s xi_1
syms c_1 c_2 tau
syms p_t p_s
syms P I
syms alpha_t alpha_s sigma
syms Z_t Z_s
syms gamma 
syms PS_c_1
syms beta c_beta

xi_mat = [xi_1t xi_1s; xi_2t*(1+beta) xi_2s*(1+beta)];
p = inv(xi_mat)*[c_1+tau;c_2];
p_t = p(1);
p_s = p(2);
eta = inv(xi_mat);
X = (inv(xi_mat.'))*([alpha_t/p(1); alpha_s/p(2)]);
Z = xi_mat.'*X;
 
assume([c_1 > 0, c_2 > 0, xi_1t > 0, xi_2t > 0, xi_1s > 0, xi_2s > 0,   ...
    alpha_t > 0, alpha_s > 0, gamma > 0, PS_c_1 < 0,                    ...
    xi_2t/c_2 > xi_1t/c_1, xi_1s/c_1 > xi_2s/c_2,                       ...
    (((alpha_s*(xi_1s/c_1 - xi_2s/c_2))/                                ...
    ((alpha_t)*(xi_2t/c_2 - xi_1t/c_1))) > xi_2s/xi_2t),                ...     
    (((alpha_s*(xi_1s/c_1 - xi_2s/c_2))/                                ...
    ((alpha_t)*(xi_2t/c_2 - xi_1t/c_1))) < xi_1s/xi_1t),                ...
    xi_1s*xi_2t - xi_1t*xi_2s > 0,                                      ...
    c_1*xi_2s - c_2*xi_1s < 0,                                          ...
    c_1*xi_2t - c_2*xi_1t > 0]);

diff_X1_beta = simplify(diff(X(1), beta), 'Steps', 100)

    
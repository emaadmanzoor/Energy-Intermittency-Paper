%%% Model %%%
% Linear cost
% CES Utility
% Two Periods


%% CES Numerical Sim

alpha = [0.6, 0.4];
xi_1  = [1, 1];
xi_2  = [1, 0.1]*1.00;

sigma = 0.5;
phi   = (sigma - 1)/sigma;
budget = 1;

x_1_cost_param = 104.3*1.00;
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


%% Hessian

f_ab = (sim_function([1.01,1.01]) - sim_function([1.01, 0.99])        ...
    - sim_function([0.99, 1.01]) + sim_function([0.99, 0.99])) ...
    / (4*0.02*0.02);

f_aa = (-sim_function([0.99, 1.0]) + 2*sim_function([1, 1]) ...
    - sim_function([1.01, 1]))/(0.01^2);


f_bb = (-sim_function([1.0, 0.99]) + 2*sim_function([1, 1]) ...
    - sim_function([1.0, 0.99]))/(0.01^2);

% g = tax X1
g_ab = f_ab(1);
g_aa = f_aa(1);
g_bb = f_bb(1);

g_Hes = [g_aa, g_ab; g_ab, g_bb];

eig(-g_Hes)



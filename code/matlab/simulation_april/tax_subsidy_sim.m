%% Simulation to find the optimal tax + research combination
% Cobb-Douglas, 2 Periods
% Cost of research given by c_beta*beta

beta   = 1;
c_beta = 0.00001;
gamma  =  0.00116*100;
tau    = gamma;

n = 100;
results = zeros(n,3); 
tau_range  = linspace(0,2.5,n);
beta_range = linspace(0.5,2.5,n);

for i = 1:n

    % Variable params
    tau = tau_range(i);
    
    % Parameters
    alpha = [0.3, 0.7];
    xi_1  = [1, 1];
    xi_2  = [0, 1];
    sigma = 1;
    phi   = (sigma - 1)/sigma;
    budget = 1;
    c_1 = 95*0.9;
    c_2 = 50;

    % Prices
    xi_mat   = [xi_1; xi_2*(1+beta)];
    cost_mat = [c_1*(1+tau); c_2];
    prices   = xi_mat\cost_mat;

    % Price Index
    P = 1;
    
    % Quantities
    Y = ((alpha'./prices).^(sigma)) * (budget/P);
    X = (xi_mat')\Y;
    
    % Expand parameters
    alpha_t = alpha(1);
    alpha_s = alpha(2);
    xi_1t = xi_1(1);
    xi_1s = xi_1(2);
    xi_2t = xi_2(1);
    xi_2s = xi_2(2);
    
    % Partial G(B) / Partial X_1
    diff_X1_beta = - (alpha_t*c_2*xi_1s*xi_2s)/(- c_2*xi_1s +    ...
        tau*xi_2s + c_1*(xi_2s + beta*xi_2s) + beta*tau*xi_2s)^2 ...
        - (alpha_s*c_2*xi_1t*xi_2t)/(c_1*xi_2t - c_2*xi_1t +     ...
        tau*xi_2t + beta*c_1*xi_2t + beta*tau*xi_2t)^2;
    diff_GB_X1 = c_beta*(1/diff_X1_beta);
    
    results(i,1) = X(1);
    results(i,2) = X(2);
    results(i,3) = gamma + diff_GB_X1;

end


%% Plots

figure;
hold on;
plot(tau_range, tau_range)
plot(tau_range, results(:,3))
















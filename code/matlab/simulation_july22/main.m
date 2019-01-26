
%%%%% Time period is from 0 to 1  %%%%%
%%%%% Broken up into 24 hr chunks %%%%%


%% Parameters

parameters.alpha = @(t) 1.75-(2.*t-1).^2/2;
parameters.xi_1  = @(t) cos(t.*3-2)/2 + 1.5;
parameters.xi_2  = @(t) sin(t.*6-.5)/2 + 1.5;

parameters.phi =  2;
parameters.budget = 1;

parameters.x_1_cost_param = 0.6;
parameters.x_2_cost_param = 1;

% plots
figure;
 
subplot(2,1,1); 
fplot(parameters.alpha, [0 1])
title('\alpha')

subplot(2,1,2); hold on; 
fplot(parameters.xi_1, [0 1])
fplot(parameters.xi_2, [0 1])
title('Conversion Rates')
legend('\xi_1', '\xi_2')
ylabel('Energy per Input Unit')
xlabel('Time')



%% Optimize

disp('Optimizing...')
[ optimal_vars, optimal_val, objfunc, objcons ] = optimize ( parameters );


%% Get results

% unpack params
price_coeffs = optimal_vars;

alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

% 
x_1_cost_param = parameters.x_1_cost_param;
x_2_cost_param = parameters.x_2_cost_param;

phi   = parameters.phi;
sigma = 1 / (1-phi);

% 
price_coeffs_positive = sum(price_coeffs > 0) == length(price_coeffs);

X_1 = (1/x_1_cost_param)*xi_1(linspace(0,1,24))*price_coeffs'/24;
X_2 = (1/x_2_cost_param)*xi_2(linspace(0,1,24))*price_coeffs'/24;

Y = (1/24)*(xi_1(linspace(0,1,24))*X_1 + xi_2(linspace(0,1,24))*X_2);
I = price_coeffs*Y'/24;

% price index
P = ((1/24)*(price_coeffs.^(1-sigma))*(alpha(linspace(0,1,24))'.^sigma)).^(1/(1-sigma));

Y_demand = ((price_coeffs./(alpha(linspace(0,1,24)))).^(-sigma)) .* (P.^(1-sigma));
U = (1/24)*(alpha(linspace(0,1,24))*(Y.^phi)').^(1/phi);


%%
figure;
grid('on')

subplot(3, 1, 1);
plot(linspace(0,1,24), optimal_vars)
title('Price')
ylabel('Price')

subplot(3, 1, 2);  hold on;
plot(linspace(0,1,24), Y)
plot(linspace(0,1,24), Y_demand)
title('Energy Quantity Supplied and Demanded')
legend('Supply', 'Demand')
ylabel('Quantity')


subplot(3, 1, 3); 
plot(linspace(0,1,24), optimal_vars.*Y_demand)
title('Cost of Energy Use')
ylabel('Time')

% plot(linspace(0,1,24), Y - Y_demand)
% title('Difference between Supply and Demand')
% ylabel('Quantity')
% xlabel('Time')


%% Plot

X_1_energy = (1/24)*(xi_1(linspace(0,1,24))*X_1);
X_2_energy = (1/24)*(xi_2(linspace(0,1,24))*X_2);


figure; 
h = area(linspace(0,1, 24), [X_1_energy', X_2_energy'], ...
    'FaceAlpha', 0.7);
legend('X_1 Energy Output', 'X_2 Energy Output')
title('Energy Output over Time')
ylabel('Quantity')
xlabel('Time')




%%




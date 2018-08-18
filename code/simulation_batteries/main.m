
%%%%% Time period is from 0 to 1  %%%%%
%%%%% Broken up into 24 hr chunks %%%%%


%% Parameters

parameters.alpha = @(t) 1.75-(2.*t-1).^2/2;
parameters.xi_1  = @(t) cos(t.*3-2)/2 + 1.5;
parameters.xi_2  = @(t) sin(t.*6-.5)/2 + 1.5;

parameters.phi = 0.5;
parameters.budget = 1;

parameters.x_1_cost_param = 10;
parameters.x_2_cost_param = 1;

parameters.storage_decay = 0.00;

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
price_coeffs = optimal_vars(1:24);

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

% Input
X_1 = optimal_vars(25);%(1/x_1_cost_param)*xi_1(linspace(0,1,24))*price_coeffs'/24;
X_2 = optimal_vars(26);%(1/x_2_cost_param)*xi_2(linspace(0,1,24))*price_coeffs'/24;

% Output
G = (1/24)*(xi_1(linspace(0,1,24))*X_1 + xi_2(linspace(0,1,24))*X_2);
Z = optimal_vars(27:50);

Y = G + Z;
I = price_coeffs*Y'/24;

% price index
P = ((1/24)*(price_coeffs.^(1-sigma))*(alpha(linspace(0,1,24))'.^sigma)).^(1/(1-sigma));

Y_demand = ((price_coeffs./(alpha(linspace(0,1,24)))).^(-sigma)) .* (P.^(1-sigma));
U = (1/24)*(alpha(linspace(0,1,24))*(Y.^phi)').^(1/phi);

% storage
stored_energy = zeros(1,24);
stored_energy(1) = -Z(1); % initial z should be negative to add charge

energy_avail = zeros(1,24); % 1 if available else 0
energy_avail(1) = Z(1) < 0;

for i = 2:24
    stored_energy(i) = stored_energy(i-1)*(1-parameters.storage_decay) - Z(i);
    energy_avail(i) = Z(i) < G(i) + stored_energy(i);
end



%%
figure;
grid('on')

subplot(3, 1, 1);
plot(linspace(0,1,24), price_coeffs)
title('Price')
ylabel('Price')

subplot(3, 1, 2);  hold on;
plot(linspace(0,1,24), Y)
plot(linspace(0,1,24), Y_demand)
title('Energy Quantity Supplied and Demanded')
legend('Supply', 'Demand')
ylabel('Quantity')


subplot(3, 1, 3); 
plot(linspace(0,1,24), price_coeffs.*Y_demand)
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

subplot(2, 1, 1); hold on;
h = area(linspace(0,1, 24), [Z', X_1_energy', X_2_energy'], ...
    'FaceAlpha', 0.7);
legend('Battery', 'X_1 Energy Output', 'X_2 Energy Output')
title('Energy Output over Time')
ylabel('Quantity')
xlabel('Time')

subplot(2, 1, 2); hold on;
plot(linspace(0,1,24), Z);
plot(linspace(0,1,24), stored_energy);
legend('Z', 'Energy Stored')
title('Energy Output over Time')
ylabel('Quantity')
xlabel('Time')


%%




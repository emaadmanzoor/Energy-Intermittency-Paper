
%%%%%%% Doesn't work well %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters

parameters.alpha = @(t) 1.75-(2.*t-1).^2/2;
parameters.xi_1  = @(t) 1.5 + 0.*t;
parameters.xi_2  = @(t) 1.9869 - 0.6816*(t-0.5) - 8.764*(t-.5).^2 + 4.089*(t-0.5).^2;

figure; hold on;
fplot(parameters.alpha, [0 1])
fplot(parameters.xi_1, [0 1])
fplot(parameters.xi_2, [0 1])
hold off;

parameters.phi =  2;
parameters.budget = 100;


%% Optimize

disp('Optimizing...')
[ optimal_vars, optimal_val, objfunc, objcons ] = optimize ( parameters )


%% Get results

price_coeffs = optimal_vars;

alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

phi   = parameters.phi;
sigma = 1 / (1-phi);

poly_coeffs = polyfit(linspace(0,1,7), price_coeffs, 6);
p = @(t) poly_coeffs(1).*(t.^6) +  poly_coeffs(2).*(t.^5) + poly_coeffs(3).*(t.^4) + ...
    poly_coeffs(4).*(t.^3) + poly_coeffs(5).*(t.^2) + ...
    poly_coeffs(6).*(t.^1) + poly_coeffs(7).*(t.^0);
X_1 = integral(@(t) xi_1(t).*p(t), 0, 1);
X_2 = integral(@(t) xi_2(t).*p(t), 0, 1);

Y = @(t) xi_1(t).*X_1 + xi_2(t).*X_2;
U = (integral(@(t) alpha(t).*(Y(t).^phi), 0, 1).^(1/phi));
I = integral(@(t) p(t).*Y(t), 0, 1);

P = integral(@(t) p(t).^(1-sigma) .* alpha(t).^sigma, 0, 1).^(1/(1-sigma));
Y_demand = @(t) ((p(t)./alpha(t)).^(-sigma)) .* (P.^(1-sigma));


%%

fplot(p, [0 1])


%% Output

q_diff = @(t) (2.*(Y(t) - Y_demand(t))).^4;

figure; hold on;
fplot(Y, [0 1]);
fplot(Y_demand, [0 1]);
fplot(q_diff, [0 1])

%% Plot

fplot(p, [0 1])

X_1_energy = @(t) X_1.*(xi_1(t));
X_2_energy = @(t) X_2.*(xi_2(t));



% figure; hold on;
% 
% plot(linspace(0,1,100), X_1_energy(linspace(0,1,100)))
% plot(linspace(0,1,100), X_2_energy(linspace(0,1,100)))

figure; 
h = area(linspace(0,1,100)', ...
    [X_1_energy(linspace(0,1,100))', X_2_energy(linspace(0,1,100))']);


%% Prices versus X

output_ratio = @(t) X_1_energy(t) ./ X_2_energy(t)


%fplot(

%% Scratch

p = polyfit(linspace(0,1,7), price_coeffs, 6);
x2 = linspace(0,1,100);
y2 = polyval(p,x2);
plot(linspace(0,1,7),price_coeffs,'p', x2,y2)






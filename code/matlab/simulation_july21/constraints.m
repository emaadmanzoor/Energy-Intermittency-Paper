function [ c, ceq ] = constraints( price_coeffs, parameters )


%% Unpack

% funcs
alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

% constants
phi   = parameters.phi;
sigma = 1/(1-phi);
budget = parameters.budget;


%% Condition

% price
poly_coeffs = polyfit(linspace(0,1,7), price_coeffs, 6);
p = @(t) poly_coeffs(1).*(t.^6) +  poly_coeffs(2).*(t.^5) + poly_coeffs(3).*(t.^4) + ...
    poly_coeffs(4).*(t.^3) + poly_coeffs(5).*(t.^2) + ...
    poly_coeffs(6).*(t.^1) + poly_coeffs(7).*(t.^0);
price_positive = sum(p(linspace(0,1,100)) > 0) == 100;
price_coeffs_positive = sum(price_coeffs > 0) == length(price_coeffs);

% budget
X_1 = integral(@(t) xi_1(t).*p(t), 0, 1);
X_2 = integral(@(t) xi_2(t).*p(t), 0, 1);

Y = @(t) xi_1(t).*X_1 + xi_2(t).*X_2;
I = integral(@(t) p(t).*Y(t), 0, 1);

% price index
P = integral(@(t) p(t).^(1-sigma) .* alpha(t).^sigma, 0, 1).^(1/(1-sigma));
Y_demand = @(t) ((p(t)./alpha(t)).^(-sigma)) .* (P.^(1-sigma));



%% <= constraints

budget_constraint = I - budget;

c = [budget_constraint];


%% == constraints

ceq = [1 - price_positive, 1 - price_coeffs_positive];


end


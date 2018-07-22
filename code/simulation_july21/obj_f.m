function [ obj_value ] = obj_f ( price_coeffs, parameters )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Unpack parameters

alpha = parameters.alpha;
xi_1  = parameters.xi_1;
xi_2  = parameters.xi_2;

phi   = parameters.phi;
sigma = 1 / (1-phi);

%% Find utility

poly_coeffs = polyfit(linspace(0,1,7), price_coeffs, 6);
p = @(t) poly_coeffs(1).*(t.^6) +  poly_coeffs(2).*(t.^5) + poly_coeffs(3).*(t.^4) + ...
    poly_coeffs(4).*(t.^3) + poly_coeffs(5).*(t.^2) + ...
    poly_coeffs(6).*(t.^1) + poly_coeffs(7).*(t.^0);

X_1 = integral(@(t) xi_1(t).*p(t), 0, 1);
X_2 = integral(@(t) xi_2(t).*p(t), 0, 1);

Y = @(t) xi_1(t).*X_1 + xi_2(t).*X_2;
U = (integral(@(t) alpha(t).*(Y(t).^phi), 0, 1).^(1/phi));

% price index
P = integral(@(t) p(t).^(1-sigma) .* alpha(t).^sigma, 0, 1).^(1/(1-sigma));
Y_demand = @(t) ((p(t)./alpha(t)).^(-sigma)) .* (P.^(1-sigma));

% quantity mismatch
q_diff = @(t) (3.*(Y(t) - Y_demand(t))).^4;
q_diff_total = integral(q_diff, 0, 1);

obj_value = 1*q_diff_total;


end

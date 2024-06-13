% crossing-coupling 
% Define parameters
C1 = 1e-18;
C2 = 1e-18;
Cm = 0.1e-18;
e = 1.602176634e-19;
xy = e/C1 * (1/(1-Cm^2/C1*C2));
cp = e/Cm * (1/(C1*C2/Cm^2-1));

x_range = linspace(-xy, xy, 1000);
y_range = sqrt(xy^2 + cp^2);

% Calculate energy levels
epsilon_plus = sqrt(x_range.^2 + cp);
epsilon_minus = -sqrt(x_range.^2 + cp);

% Plot the energy levels
figure;
hold on;

% Plot the axes
plot([-xy, xy], [0, 0], 'k--'); % x-axis
plot([0, 0], [-y_range, y_range], 'k--'); % y-axis

% Plot the energy levels
plot(x_range, x_range, 'b', 'LineWidth', 1.5); % Linear energy level
plot(x_range, -x_range, 'b', 'LineWidth', 1.5); % Linear energy level
plot(x_range, epsilon_plus, 'r', 'LineWidth', 1.5); % Curved energy level
plot(x_range, epsilon_minus, 'r', 'LineWidth', 1.5); % Curved energy level

% Dashed lines for coupling
plot([-xy, xy], [cp, cp], 'k--');
plot([-xy, xy], [-cp, -cp], 'k--');


hold off;
xlabel('Vg1/eV');
ylabel('Vg2/eV');
title('Energy Coupling in Double QD transistor');
axis equal;
grid on;


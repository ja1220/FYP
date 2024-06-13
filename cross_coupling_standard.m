% crossing-coupling 
% Define parameters

xy = 2;
cp = 1;

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

% Add text labels
text(xy, -0.1*cp, '\Delta', 'HorizontalAlignment', 'right');
text(-0.1*xy, y_range, '\epsilon - E', 'HorizontalAlignment', 'left');

% Labels for energy levels
text(xy*0.75, xy*0.75, '\epsilon_a', 'HorizontalAlignment', 'right', 'Color', 'b');
text(xy*0.75, -xy*0.75, '\epsilon_b', 'HorizontalAlignment', 'right', 'Color', 'b');
text(0.1*xy, xy*0.75, '\epsilon_+', 'HorizontalAlignment', 'left', 'Color', 'r');
text(0.1*xy, -xy*0.75, '\epsilon_-', 'HorizontalAlignment', 'left', 'Color', 'r');

% Label for coupling potential 2V
plot([-xy*2/3, -xy*2/3], [-cp, cp], 'k<->', 'LineWidth', 1);
text(-xy*2/3 - 0.1*xy, 0, '2V', 'HorizontalAlignment', 'center');

% Annotations for y-axis and x-axis
text(xy*1.05, 0, 'V_{g1}/eV', 'HorizontalAlignment', 'left');
text(0, y_range*1.05, 'V_{g2}/eV', 'HorizontalAlignment', 'right');

hold off;
xlabel('V_{g1}/eV');
ylabel('V_{g2}/eV');
title('Energy Coupling in Double QD Transistor');
axis equal;
grid on;

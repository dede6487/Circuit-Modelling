% Stability regions for BDF1, BDF2, and BDF3

% Define a grid of complex values
[x, y] = meshgrid(-3:0.01:3, -3:0.01:3);
z = x + 1i*y;

% BDF-1 Stability Function: R(z) = 1 / (1 - z)
R_bdf1 = 1 ./ (1 - z);

% BDF-2 Stability Function: R(z) = (2 - z) / (2 - z - z^2)
R_bdf2 = (2 - z) ./ (2 - z - z.^2);

% BDF-3 Stability Function: R(z) = (6 - 6z + z^2) / (6 - 11z + 6z^2 - z^3)
R_bdf3 = (6 - 6*z + z.^2) ./ (6 - 11*z + 6*z.^2 - z.^3);

% Create figure
figure;
hold on;

% Plot stability region for BDF-1
contour(x, y, abs(R_bdf1), [1 1], 'r', 'LineWidth', 2);

% Plot stability region for BDF-2
contour(x, y, abs(R_bdf2), [1 1], 'g', 'LineWidth', 2);

% Plot stability region for BDF-3
contour(x, y, abs(R_bdf3), [1 1], 'b', 'LineWidth', 2);

% Labels and title
xlabel('Re(z)');
ylabel('Im(z)');
title('Stability Regions for BDF1, BDF2, and BDF3');
legend('BDF1', 'BDF2', 'BDF3');

% Grid and axis properties
axis equal;
grid on;
xlim([-3, 3]);
ylim([-3, 3]);
hold off;

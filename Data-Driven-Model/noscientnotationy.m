function dummy = noscientnotationy(h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ax = ancestor(h, 'axes');
ax.YAxis.Exponent = 0;
ax.YAxis.TickLabelFormat = '%.0f';
end


function [ ] = plot_series( h )

figure;
x = 0: length(h)-1;
stem(x,h,'filled');axis([0 length(h)-1 -1 1.5]);
xlabel('n');ylabel('X[n]');title('h(n)');

figure;
zplane(h);legend('Zero','Pole');
title('Zero and Pole Locations');

end


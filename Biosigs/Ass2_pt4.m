len = 20; % length of vector
x = zeros(len,1); % initalise impulse
x(1) = 1; % add impulse
y = zeros(len,1); % initialise ouput vector
for n = (1: len) % loop to fill out signal response
    if n == 1 % used for the first n-1 term
        y(n) = 0.98*x(n);
    else % used for every n-1 term after the inital one
        y(n) = .98*x(n) + 1.83*x(n-1) - .92*y(n-1);
    end
end
% plot graph
plot(x, 'r-')
hold on 
plot(y, 'b-')
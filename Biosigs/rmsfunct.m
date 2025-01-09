function ans = rmsfunct(n) % function to calculate the rms of a siganl
    x = n.^2*sqrt(2);% let x be the square of each element in the array n, times root 2
    N = size(n);% let N be the size of x
    ans =sqrt(1/N(2)*sum(x.^2)); % ans equal ro the rms, done with the given function in the problem
end
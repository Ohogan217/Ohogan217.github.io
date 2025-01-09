function v = Gauss_Elimination_tp(A,b)
    % v = Gauss_Elimination_tp(A, b):
    % Solve system of linear equations expressed in
    % matrix -vector form Av = b for unknown vector v
    % using Gaussian Elimination with partial pivoting.
    % Input A = square matrix of coefficients.
    % Input b = vector of constants.
    % Output v = solution vector.
    % Version 3: created 14/01/21. Author: P.F. Curran
    %            modified 14/04/22. Editor: O. Hogan
    
     [xdim, ydim] = size(A);
    if xdim ~=ydim
        error('must be a square matrix')
        return
    end
    xdim = size(A); n = xdim(1); Id = eye(n);
    A1 = A; b1 = b;
    for m = 1:n-1
        % partial pivot
        row_index = [m:n];
        [~, Ir] = max(abs(A1(row_index, row_index)));
        row_num = Ir(1); 
        p = [1:n]; 
        p(m) = m-1+row_num; 
        p(m-1+row_num) = m;
        P = Id(p,:);
        A1 = P*A1; b1 = P*b1;
        % eliminate
        I_vec = zeros(1,n); I_vec(1,m) = 1;
        L1 = Id - ([zeros(m,1); A1(m+1:n,m)]*I_vec)/A1(m,m);
        A1 = L1*A1; b1 = L1*b1;
    end
    % back substitution
    v = zeros(n,1);
    for m = 0:n-1
        v(n-m,1) = (b1(n-m,1) - (A1(n-m,:)*v))/A1(n-m,n-m);
    end
end

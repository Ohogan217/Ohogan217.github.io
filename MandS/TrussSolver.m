function TrussSolver()

% INPUTS

COORD = [0 0; 4.5 0; 9 0; 13.5 0; 18 0; 22.5 0; 27 0; 4.5 4.5; 9 4.5; 13.5 4.5; 18 4.5; 22.5 4.5];
CON = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 8 9; 9 10; 10 11; 11 12; 1 8; 2 8; 3 8; 3 9; 4 9; 4 10; 4 11; 5 11; 5 12; 6 12; 7 12];
EQ = [22 23; 1 2; 3 4; 5 6; 7 8; 9 10; 11 24; 12 13; 14 15; 16 17; 18 19; 20 21];
NR = 3;
NE = size(CON,1);
NN = size(COORD,1);
EA = [3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9 3.024e9]';
Pf = [0 0 0 0 0 -1000000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
Ur = [0 0 0]';


%----CALCULATIONS----

%Structural Information
NOS = NE+NR-2*NN;
NOK = 2*NN-NR;

%Length of Element
L = zeros(NE,1);
for k = 1:NE
    i = CON(k,1);
    j = CON(k,2);
    dx = COORD(j,1)-COORD(i,1);
    dy = COORD(j,2)-COORD(i,2);
    L(k) = sqrt(dx^2+dy^2);
end

%id Array
ID = zeros(NE,4);
for k = 1:NE
    i = CON(k,1);
    j = CON(k,2);
    ID(k,1:2) = EQ(i,1:2);
    ID(k,3:4) = EQ(j,1:2);
end

%Stiffness Matrix
NDOF = 2*NN;
K = zeros(NDOF,NDOF);
for k = 1:NE
    i = CON(k,1);
    j = CON(k,2);
    dx = COORD(j,1)-COORD(i,1);
    dy = COORD(j,2)-COORD(i,2);
    a = [-dx/L(k) -dy/L(k) dx/L(k) dy/L(k)];
    ES = a'.*EA(k)/L(k)*a;
    for m = 1:4
        for n = 1:4
            mi = ID(k,m);
            ni = ID(k,n);
            K(mi, ni) = K(mi, ni)+ES(m,n);
        end
    end
end
Kff(1:NOK, 1:NOK) = K(1:NOK, 1:NOK);
Kfr(1:NOK, 1:NDOF-NOK) = K(1:NOK, NOK+1:NDOF);
Krf = Kfr';
Krr(1:NDOF-NOK, 1:NDOF-NOK) = K(NOK+1:NDOF, NOK+1:NDOF);

%Deformation
Uf = Kff\Pf;
U = [Uf; Ur];

%Internal Forces
N = zeros(NE,1);
for k = 1:NE
    i = CON(k,1);
    j = CON(k,2);
    dx = COORD(j,1)-COORD(i,1);
    dy = COORD(j,2)-COORD(i,2);
    a = [-dx/L(k) -dy/L(k) dx/L(k) dy/L(k)];
    u = zeros(4,1);
    for m = 1:4
        u(m) = U(ID(k,m));
    end
    N(k) = EA(k)/L(k).*a*u;
end

%Support Reactions
R = Krf*Uf + Krr*Ur

f1 = figure();
f1.WindowState = 'maximized';
NCOORD = zeros(size(COORD));
scale = 20
for n = 1:NN
    NCOORD(n,1) = COORD(n,1) + scale*U(EQ(n,1));
    NCOORD(n,2) = COORD(n,2) + scale*U(EQ(n,2));
end
for k = 1:NE
    i = CON(k,1);
    j = CON(k,2);
    x = [COORD(i,1) COORD(j,1)];
    y = [COORD(i,2) COORD(j,2)];
    plot(x,y, 'Color', [0 0 0], 'LineWidth', 1);
    hold on
    ux = [NCOORD(i,1) NCOORD(j,1)];
    uy = [NCOORD(i,2) NCOORD(j,2)];
    plot(ux, uy, 'r--', 'LineWidth', 2);
    hold on
end
xlim([0-5, max(COORD(:,1))+5]);
ylim([0-5, max(COORD(:,2))+5]);

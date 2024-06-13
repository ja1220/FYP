%%
clear

Omega = 2*pi*1; % Rabi frequency of the driving field
Delta = 2*pi*0; % detuning of the |g>-|e> transition

% Hamiltonian of an atom driven by monochromatic light
H = (1/2)*[Delta         Omega;
           Omega        -Delta];
       
Psi_e=[1;0]; %excited state
Psi_g=[0;1]; %ground state
psi_0 = Psi_g; %initial state

N=10000;
t_total = 4;
dt = t_total/N;
T = 0:dt:t_total;

[W,E] = eig(H);
e = diag(E);
P_e = T*0;
P_g = T*0;

for ni = 1:length(T)
    t = T(ni);
    u = exp(-1i*e*t);
    U = diag(u); %Time evolution operator
    psi_t = W * U / W * psi_0;
    P_e(ni) = abs(psi_t(1))^2;
    P_g(ni) = abs(psi_t(2))^2;
end

plot(T,P_e); %probability in excited state
%plot(T,P_g); %probability in ground state
axis([0 t_total 0 1]);
title('Rabi Oscillation')
xlabel('Time(us)')
ylabel('Pe')
hold on


% Define the file name
file_name='Refout4.txt';
fileID = fopen(file_name,'r');
tline1 = fgetl(fileID);    %%skip line
formatSpec = '%f %f %f';
sizeA = [3 Inf];   
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A_org(:,1:2)=(A([1 3],:))';
[C,ia,ic] = unique(A_org(:,1:2),'rows');
A = (A_org(ia,:))';
clear A_org  C  ia ic;

disp("here A is")
disp(A)

Vd = 2*A(1,:);
C  = A(2,:);

disp("here Vd is")
disp(Vd)
disp("here C is")
disp(C)

plot(Vd,C)
xlim([-0.5 0.5])
xlabel('Vds/V')
ylabel('Ids/nA')
title('Coulomb Blockade IV characteristics inside SET')


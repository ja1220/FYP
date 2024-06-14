clear;
clc;


% prompt = 'What is the name of the file? \n';
% file_name = input(prompt,'s');
file_name='Refoutwhole10.txt';
fileID = fopen(file_name,'r');
tline1 = fgets(fileID);    %%skip line
formatSpec = '%f %f %f %f %f %f';
sizeA = [6 Inf];   
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A_org(:,1:3)=(A([4 5 6],:))';
[C,ia,ic] = unique(A_org(:,1:2),'rows');
A = (A_org(ia,:))';
clear A_org  C  ia ic;

file_name='Refoutwhole2.txt';
fileID = fopen(file_name,'r');
tline1 = fgets(fileID);    %%skip line
formatSpec = '%f %f %f %f %f %f';
sizeA1 = [6 Inf];   
A1 = fscanf(fileID,formatSpec,sizeA1);
fclose(fileID);
A1_org(:,1:3)=(A1([4 5 6],:))';
[C1,ia1,ic1] = unique(A1_org(:,1:2),'rows');
A1 = (A1_org(ia1,:))';
clear A1_org  C1  ia1 ic1;

file_name='Refoutwhole3.txt';
fileID = fopen(file_name,'r');
tline2 = fgets(fileID);    %%skip line
formatSpec = '%f %f %f %f %f %f';
sizeA2 = [6 Inf];   
A2 = fscanf(fileID,formatSpec,sizeA2);
fclose(fileID);
A2_org(:,1:3)=(A2([4 5 6],:))';
[C2,ia2,ic2] = unique(A2_org(:,1:2),'rows');
A2 = (A2_org(ia2,:))';
clear A2_org  C2  ia2 ic2;

Vg2 = A(1,:);
Vg3  = A(2,:);
C = A(3,:);
C1 = A1(3,:);
C2 = A2(3,:);

threshold = 0.5e-11;
cols0 = C > threshold;
cols1 = C1 > threshold;
cols2 = C2 > threshold;
Array01 = A(1,cols0);
Array02 = A(2,cols0);

Array11 = A1(1,cols1);
Array12 = A1(2,cols1);

Array21 = A2(1,cols2);
Array22 = A2(2,cols2);

Array1 = [Array01 Array11 Array21];
Array2 = [Array02 Array12 Array22];

figure;
plot(Array01, Array02, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
hold on
plot(Array11, Array12, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'y', 'MarkerFaceColor', 'y');
hold on
plot(Array21, Array22, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g');
xlabel('Vg2/V')
ylabel('Vg3/V')
title('Degenerate points')
grid on;




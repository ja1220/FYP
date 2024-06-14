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

% Vg = A(1,:);
% Vgas = A(2,:);
%Vd = 2*A(1,:);
%Vg1 = A(1,:);
Vg2 = A(1,:);
Vg3  = A(2,:);
C = A(3,:);
C1 = A1(3,:);
C2 = A2(3,:);
% nonZeroRows = any(C1 ~= 0);
% CombinedData = C;
% CombinedData(nonZeroRows,:) = C1(nonZeroRows,:);
% nonZeroRows1 = any(C2 ~= 0);
% CombinedData1 = CombinedData;
% CombinedData1(nonZeroRows1,:) = C2(nonZeroRows1,:);
% clear A A1 A2;
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

%Array1 = [Array01 Array11 Array21];
%Array2 = [Array02 Array12 Array22];

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
%%
Vg2_sorted = unique(Vg2); % return the unique value
Vg3_sorted = unique(Vg3);
%Vg3_sorted = unique(Vg3);
clear Vg Vgas;
%Vg1_size = size(Vg1_sorted,2); % get the number of columns as size
Vg2_size = size(Vg2_sorted,2);
Vg3_size = size(Vg3_sorted,2);

% Identify logical indices where array1 is not equal to 0
%  indices_to_keep = C ~= 0;
%  filtered_Vg1_sorted = Vg1_sorted(indices_to_keep);
%  filtered_Vg2_sorted = Vg2_sorted(indices_to_keep);
%  filtered_Vg3_sorted = Vg3_sorted(indices_to_keep);
% 
%  Vg1_size = size(filtered_Vg1_sorted,2); % get the number of columns as size
%  Vg2_size = size(filtered_Vg2_sorted,2);
%  Vg3_size = size(filtered_Vg3_sorted,2);
%  clear Vg Vgas;

% Vg_diff_matrix=zeros(Vd_size-1,Vg_size);
% Vd_diff_matrix=zeros(Vd_size-1,Vg_size);
C_matrix=reshape(CombinedData1,[Vg2_size Vg3_size]);
%Vg3_matrix = reshape(Vg3_sorted,[Vg1_size Vg2_size]);
[Vg2_matrix, Vg3_matrix]=meshgrid(Vg2_sorted, Vg3_sorted);


%%
% plotting coulomb diamonds
figure;
s0=surf(Vg2_matrix,Vg3_matrix,C_matrix);
s0.LineStyle='none';
view(2);
colorbar;
% plotbrowser('on');
propertyeditor('on');
xlabel('Vg2/V');
ylabel('Vg3/V'); 
zlabel('Ids/A');


%%
% plotting coulomb diamonds
figure;
s0=surf(xData,yData,zData);
s0.LineStyle='none';
view(2);
colorbar;
% plotbrowser('on');
propertyeditor('on');
xlabel('Vg2/V');
ylabel('Vg3/V'); 
zlabel('Ids/A');

%%
threshold = 0.5e-11;
cols0 = zData > threshold;
cols1 = zData2 > threshold;
cols2 = zData3 > threshold;
Array01 = xData(cols0);
Array02 = yData(cols0);

Array11 = xData2(cols1);
Array12 = yData2(cols1);

Array21 = xData3(cols2);
Array22 = yData3(cols2);

Array1 = [Array01 Array11 Array21];
Array2 = [Array02 Array12 Array22];

figure;
plot(Array1, Array2, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'r');
xlabel('Vg2/V')
ylabel('Vg3/V')
title('Degenerate points')
grid on;



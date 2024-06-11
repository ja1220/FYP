clear;
clc;


% prompt = 'What is the name of the file? \n';
% file_name = input(prompt,'s');
file_name='Refout.txt';
fileID = fopen(file_name,'r');
tline1 = fgetl(fileID);    %%skip line
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];   
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);
A_org(:,1:3)=(A([1 3 4],:))';
[C,ia,ic] = unique(A_org(:,1:2),'rows');
A = (A_org(ia,:))';
clear A_org  C  ia ic;


% Vg = A(1,:);
% Vgas = A(2,:);
Vd = 2*A(1,:);
Vg = A(2,:);
C  = A(3,:);
clear A;
Vg_sorted = unique(Vg); % return the unique value
Vd_sorted = unique(Vd);
clear Vg Vgas;
Vd_size = size(Vd_sorted,2); % get the number of columns as size
Vg_size = size(Vg_sorted,2);


% Vg_diff_matrix=zeros(Vd_size-1,Vg_size);
% Vd_diff_matrix=zeros(Vd_size-1,Vg_size);
C_matrix=reshape(C,[Vg_size Vd_size]);
[Vg_matrix Vd_matrix]=meshgrid(Vd_sorted,Vg_sorted);

%%
% plotting coulomb diamonds
figure;
s0=surf(Vd_matrix,Vg_matrix,C_matrix);
s0.LineStyle='none';
view(2);
colorbar;
% plotbrowser('on');
propertyeditor('on');
xlabel('Vg/V');
ylabel('Vd/V'); 
zlabel('Ids/A');

%%
%plotting the graph of Ids-Vds of single SET
figure;
plot(Vd_matrix,C_matrix);
colorbar;
%propertyeditor('on');
xlabel('Vgs/V')
ylabel('Ids/A')

%%
%plot single electron trap
clear;
clc;


% prompt = 'What is the name of the file? \n';
% file_name = input(prompt,'s');
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


% Vg = A(1,:);
% Vgas = A(2,:);
Vd = 2*A(1,:);
%Vg = A(2,:);
C  = A(2,:);
clear A;
Vd_sorted = unique(Vd); % return the unique value
%Vd_sorted = unique(Vd);
clear Vg Vgas;
Vd_size = size(Vd_sorted,2); % get the number of columns as size
%Vg_size = size(Vg_sorted,2);


% Vg_diff_matrix=zeros(Vd_size-1,Vg_size);
% Vd_diff_matrix=zeros(Vd_size-1,Vg_size);
%C_matrix=reshape(C,Vd_size);
[Vd_matrix]=meshgrid(Vd_sorted);

%plotting the graph of Ids-Vds of single SET
figure;
plot(Vd_matrix,C);
colorbar;
%propertyeditor('on');
xlabel('Vds/V')
ylabel('Ids/A')

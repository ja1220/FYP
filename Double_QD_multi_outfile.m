% Prompt the user to select multiple files
[filenames, pathname] = uigetfile({'*.txt'}, 'Select text files', 'MultiSelect', 'on');

% Check if the user canceled the file selection
if isequal(filenames, 0)
    disp('User canceled the file selection');
else
    if ischar(filenames)
        filenames = {filenames}; % Ensure filenames is a cell array
    end
    
    % Initialize cell arrays to store data from each file
    allDataTables = cell(1, numel(filenames));
    
    % Loop through each selected file
    for i = 1:numel(filenames)
        % Construct the full file path
        fullFilePath = fullfile(pathname, filenames{i});
        
        % Open the file
        fid = fopen(fullFilePath, 'r');
        
        % Check if the file opened successfully
        if fid == -1
            error('Error opening the file: %s', fullFilePath);
        end
        
        % Read the header line
        headerLine = fgetl(fid);
        
        % Split the header line into individual column names
        headers = strsplit(headerLine, '\t');
        
        % Remove any empty or whitespace-only headers
        headers = headers(~cellfun('isempty', strtrim(headers)));
        
        % Read the data
        data = textscan(fid, repmat('%f', 1, length(headers)), 'Delimiter', '\t');
        
        % Close the file
        fclose(fid);
        
        % Convert the cell array to a table and assign column names
        dataTable = array2table(cell2mat(data), 'VariableNames', headers);
        
        % Store the data table in the cell array
        allDataTables{i} = dataTable;
    end
    
    % Combine all data tables into one (assuming they have the same structure)
    combinedDataTable = vertcat(allDataTables{:});
    
    % Display the combined data (optional)
%     disp(combinedDataTable);
    
    % Prompt the user to select columns for x-axis, y-axis, and z-axis
    [xIndex, xOK] = listdlg('PromptString', 'Select x-axis data', ...
                            'SelectionMode', 'single', ...
                            'ListString', headers);
    if ~xOK
        disp('User canceled x-axis selection');
        return;
    end
    
    [yIndex, yOK] = listdlg('PromptString', 'Select y-axis data', ...
                            'SelectionMode', 'single', ...
                            'ListString', headers);
    if ~yOK
        disp('User canceled y-axis selection');
        return;
    end

    [zIndex, zOK] = listdlg('PromptString', 'Select z-axis data', ...
                            'SelectionMode', 'single', ...
                            'ListString', headers);
    if ~zOK
        disp('User canceled z-axis selection');
        return;
    end
    
    % Extract the selected columns for x, y, and z data
    xData = combinedDataTable{:, xIndex};
    yData = combinedDataTable{:, yIndex};
    zData = combinedDataTable{:, zIndex};
    
    % Set values in xData and yData that are less than 1e-10 to 0
    xData(abs(xData) < 1e-10) = 0;
    yData(abs(yData) < 1e-10) = 0;
    
    % Find unique rows based on x and y data
    [uniqueXYData, uniqueIdx] = unique([xData, yData], 'rows');
    
    % Use uniqueIdx to filter xData, yData, and zData
    xData = xData(uniqueIdx);
    yData = yData(uniqueIdx);
    zData = zData(uniqueIdx);
    
    % Retrieve the number of unique numbers in xData and yData
    numUniqueX = numel(unique(xData));
    numUniqueY = numel(unique(yData));
    
    % Display the number of unique numbers
%     fprintf('Number of unique numbers in xData: %d\n', numUniqueX);
%     fprintf('Number of unique numbers in yData: %d\n', numUniqueY);
    
    % Determine the reshaping dimensions based on unique values
    if xData(numUniqueY) == xData(1)
        % If the xData at the position of numUniqueY equals the first xData element
        % Use numUniqueY as the number of rows and numUniqueX as the number of columns
        reshapeRowNo = numUniqueY;
        reshapeColNo = numUniqueX;
    else
        % Otherwise, use numUniqueX as the number of rows and numUniqueY as the number of columns
        reshapeRowNo = numUniqueX;
        reshapeColNo = numUniqueY;
    end
    
    % Reshape xData, yData, and zData into matrices of the determined size
    xData = reshape(xData, [reshapeRowNo, reshapeColNo]);
    yData = reshape(yData, [reshapeRowNo, reshapeColNo]);
    zData = reshape(zData, [reshapeRowNo, reshapeColNo]);
end

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

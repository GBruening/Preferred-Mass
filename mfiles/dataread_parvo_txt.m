function P = dataread_parvo_txt(filename)

% textscan assumes data is either rectangular or has a regular pattern
% number of col in parvo file, if you don't change 
numcols = 15;

[fid,message] = fopen(filename);
txt_col = textscan(fid, repmat('%s',1,numcols));
fclose(fid);

for c = 1:numcols
    for i = 1:length(txt_col{c})
        txt{i,c} = txt_col{c}{i};
    end
end

txt = deblank(txt);

% find column names
colnames = txt(strcmp('TIME',txt(:,1)),:);
colnames = regexprep(colnames', '[/]', '_'); % replace / with _
colnames = regexprep(colnames', '[%]', ''); % remove %, ex. %CHO becomes CHO

% Convert data from string to double
num = cellfun(@str2double, txt, 'uniformoutput',0);

% Find row of transition from header info to data
data_start = find(strcmp('----------',txt(:,1)))+1;
data_end = find(strcmp('Max',txt(:,1)))-1;

% Convert num cellarray to data vector and put in data structure P
numcolvar = sum(~strcmp('',colnames));
for c = 1:numcolvar
    eval(['P.' colnames{c} ' = cell2mat(num(data_start:data_end,c));']);
end

%% Read in times from summary
[a, b] = ind2sub(size(txt),find(strcmp('Summary',txt)));


% finds all block names from summary
b = 1;
while ~isempty(regexp(txt{a+1,b}, '\w*=','match'))
    P.blocknames{b} = char(regexp(txt{a+1,b}, '\w*=','match'));  
    i_equal = strfind(P.blocknames{b},'=');
    P.blocknames{b}=P.blocknames{b}(1:i_equal-1);
    b=b+1;
end

% finds all block times from summary
b=1;
while ~isempty(regexp(txt{a+1,b}, '\w*=','match'))
    P.writtentimes(b,1:2) = regexp(txt{a+1,b}, '[0-9]*:[0-9]*','match');
    for c = 1:2
        i_colon = strfind(P.writtentimes{b,c},':');
        P.blocktimes(b,c) = minsec2decmin([str2double(P.writtentimes{b,c}(1:i_colon-1)), str2double(P.writtentimes{b,c}(i_colon+1:end))]);
    end
    b=b+1;
end

%% Extract basic info from txt, put into struct

P.info.subjcode = txt{var_index('Name',txt,1),var_index('Name',txt,2)+1};
P.info.subjage = str2double(txt{var_index('Age',txt,1),var_index('Age',txt,2)+1});
P.info.subjgender = txt{var_index('Sex',txt,1),var_index('Sex',txt,2)+1};
P.info.subjht_in = str2double(txt{var_index('Height',txt,1),var_index('Height',txt,2)+1});
P.info.subjht_cm = str2double(txt{var_index('Height',txt,1),var_index('Height',txt,2)+3});
P.info.subjwgt_lb = str2double(txt{var_index('Weight',txt,1),var_index('Weight',txt,2)+1});
P.info.subjwgt_kg = str2double(txt{var_index('Weight',txt,1),var_index('Weight',txt,2)+3});
P.info.tech = txt{var_index('Tech',txt,1),var_index('Tech',txt,2)+1};
P.info.insptemp_C = str2double(txt{13,3});
P.info.baropressure_mmhg = str2double(txt{13,8});
P.info.inspO2 = str2double(txt{15,3});
P.info.inspCO2 = str2double(txt{15,7});
P.info.stpd2btps = str2double(txt{17,4});
P.info.baseO2 = str2double(txt{19,3});
P.info.baseCO2 = str2double(txt{19,7});
P.info.measO2 = str2double(txt{19,11});
P.info.measCO2 = str2double(txt{19,15});

P.info.colunits_pre = txt(find(strcmp('TIME',txt(:,1)))+1,:);
P.info.colunits = txt(find(strcmp('TIME',txt(:,1)))+2,:);

%% function get_indices of variable name
function ind = var_index(var_name,txt,dim)
[a, b] = ind2sub(size(txt),strmatch(var_name,txt,'exact'));
if dim ==1
    ind = a;
else
    ind = b;
end

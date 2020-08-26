function P = dataread_parvo_xls(filename)

[num, txt, raw] = xlsread(filename); %reads in xls file. num is numerical data, txt is header, raw is everything. All cell arrays.
txt = deblank(txt);

%reads variable names
[var_row, j] = ind2sub(size(txt),find(strcmp('VO2',txt))); %This will identify which rows var names are on. 
colnames = txt(var_row,:);

% remove columns of blanks headers. This occurs if the meta data has more columns than the data.
colnames = colnames(~strcmp('',colnames)); 
colnames = regexprep(colnames', '[/]', '_'); % replace / with _
colnames = regexprep(colnames', '[%]', ''); % remove %, ex. %CHO becomes CHO

% find first row and last row of all numbers, data
data_start = find(sum(~isnan(num),2) == length(colnames),1, 'first');
data_end = find(sum(~isnan(num),2) == length(colnames),1, 'last');

for c = 1:length(colnames)
    eval(['P.' colnames{c} ' = num(data_start:data_end,c);']);
end

%% Read in times from summary
[a, b] = ind2sub(size(txt),find(strcmp('Summary',txt)));
summary = txt{a+1,1}; 

% finds all block names from summary
P.blocknames = regexp(summary, '\w*=','match'); 
for b = 1:length(P.blocknames)
    i_equal = strfind(P.blocknames{b},'=');
   P.blocknames{b}=P.blocknames{b}(1:i_equal-1);
end

% finds all block times from summary
P.writtentimes = regexp(summary, '[0-9]*:[0-9]*','match');
for ct = 1:length(P.blocknames)*2 
    i_colon = strfind(P.writtentimes{ct},':');
    if mod(ct,2) == 1, c = 1; else c = 2; end
    P.blocktimes(ceil(ct/2),c) = minsec2decmin([str2double(P.writtentimes{ct}(1:i_colon-1)), str2double(P.writtentimes{ct}(i_colon+1:end))]);
end

%% Extract basic info from headerinfo, put into struct

P.info.subjcode = raw{var_index('Name',txt,1),var_index('Name',txt,2)+1};
P.info.subjage = raw{var_index('Age',txt,1),var_index('Age',txt,2)+1};
P.info.subjgender = raw{var_index('Sex',txt,1),var_index('Sex',txt,2)+1};
P.info.subjht_in = raw{var_index('Height',txt,1),var_index('Height',txt,2)+1};
P.info.subjht_cm = raw{var_index('Height',txt,1),var_index('Height',txt,2)+3};
P.info.subjwgt_lb = raw{var_index('Weight',txt,1),var_index('Weight',txt,2)+1};
P.info.subjwgt_kg = raw{var_index('Weight',txt,1),var_index('Weight',txt,2)+3};
P.info.tech = raw{var_index('Tech',txt,1),var_index('Tech',txt,2)+1};
P.info.insptemp_C = raw{var_index('Insp. temp.',txt,1),var_index('Insp. temp.',txt,2)+1};
P.info.baropressure_mmhg = raw{var_index('Baro. pressure',txt,1),var_index('Baro. pressure',txt,2)+1};
P.info.inspO2 = raw{var_index('Insp. O2',txt,1),var_index('Insp. O2',txt,2)+1};
P.info.inspCO2 = raw{var_index('Insp. CO2',txt,1),var_index('Insp. CO2',txt,2)+1};
P.info.stpd2btps = raw{var_index('STPD to BTPS',txt,1),var_index('STPD to BTPS',txt,2)+1};
P.info.baseO2 = raw{var_index('Base O2',txt,1),var_index('Base O2',txt,2)+1};
P.info.baseCO2 = raw{var_index('Base CO2',txt,1),var_index('Base CO2',txt,2)+1};
P.info.measO2 = raw{var_index('Measured O2',txt,1),var_index('Measured O2',txt,2)+1};
P.info.measCO2 = raw{var_index('Measured CO2',txt,1),var_index('Measured CO2',txt,2)+1};

P.info.colunits = raw(var_row+2,:);

%% function get_indices of variable name
function ind = var_index(var_name,txt,dim)
[a, b] = ind2sub(size(txt),strmatch(var_name,txt,'exact'));
if dim ==1
    ind = a;
else
    ind = b;
end


%Which Data, Pilot or Second
clear all

for L = [3,2,1]
    DataSets={'Pilot' 'ArcT' '2018'};
    DataSetsSelect=DataSets{L};
    cd('d:\Users\Gary\Google Drive\Preferred Mass\mfiles');
    clearvars -except DataSetsSelect
    
    DataRead;
    
    Analyze;
    
end
    
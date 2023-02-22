%% Change a .set EEG file into a .erp file.  Add event list and extract bin-based epochs.
% %Open EEGLAB 
% [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

%Load eeglab_data.set and store in the EEG structure. You can type EEG in the command line to see the fields it contains.
% EEG = pop_loadset('eeglab_data.set',  '/home/Matlab/eeglab/sample_data/');

%set folder to save ERPsets
ERPsetsFolder = 'C:\\Users\\mattokaren3\\Box\\Project_FlickerHealthyYoungAdults\\Data Analysis\\EEG\\Data Analysis\\ERPLAB Analysis\\ERPsets\\ColorChangeOnly\\';

%set event list file
elistFile = 'C:\Users\mattokaren3\Box\Project_FlickerHealthyYoungAdults\Data Analysis\EEG\Data Analysis\ERPLAB Analysis\AttentionTaskEventListColorChangeOnly.txt';
ndatasets = length(ALLEEG) % number of datasets loaded in EEGLAB
%% Select subject

% Loop thru every participant
% for(iSubject = 1:ndatasets)

%% Load next dataset
%if iSubject > 1
    % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, iSubject,'retrieve',CURRENTSET,'study',1); 
    % Does iSubject always = CURRENTSET + 1 ?
% end

% select dataset
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',2,'study',1); 
subjectID = ['S' EEG.subject];

% Create eventlist
EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'List', elistFile, 'SendEL2', 'EEG', 'UpdateEEG', 'askUser', 'Warning', 'on' ); % GUI: 19-Feb-2023 22:13:04
% EEG  = pop_overwritevent( EEG, 'codelabel'  );
setElistFname = [ERPsetsFolder subjectID ' BDF file_elist.set'];
newSetName = [subjectID ' BDF file_elist']
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew',setElistFname,'overwrite','on','gui','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'setname',newSetName,'savenew',setElistFname,'overwrite','on','gui','off'); 
% [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 12,'setname','S21 BDF file_elist','savenew','C:\\Users\\mattokaren3\\Box\\Project_FlickerHealthyYoungAdults\\Data Analysis\\EEG\\Data Analysis\\ERPLAB Analysis\\ERPsets\\ColorChangeOnly\\S21 BDF file_elist.set','overwrite','on','gui','off'); 

%% Extract bin-based epochs
EEG = pop_epochbin( EEG , [-50.0  700.0],  'pre'); % GUI: 19-Feb-2023 22:26:39
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'savenew',[ERPsetsFolder 'S11 BDF file_elist.set'],'overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 14,'savenew','C:\\Users\\mattokaren3\\Box\\Project_FlickerHealthyYoungAdults\\Data Analysis\\EEG\\Data Analysis\\ERPLAB Analysis\\ERPsets\\ColorChangeOnly\\S23 BDF file_elist_be.set','overwrite','on','gui','off'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,'savenew','C:\\Users\\mattokaren3\\Box\\Project_FlickerHealthyYoungAdults\\Data Analysis\\EEG\\Data Analysis\\ERPLAB Analysis\\ERPsets\\ColorChangeOnly\\S23 BDF file_elist_be.set','overwrite','on','gui','off'); 


%%
% ERP = pop_averager( ALLEEG , 'Criterion', 'good', 'DQ_custom_wins', 0, 'DQ_flag', 1, 'DQ_preavg_txt', 0, 'DSindex', 14, 'ExcludeBoundary',...
%  'on', 'SEM', 'on' );
% ERP = pop_savemyerp(ERP, 'erpname', 'S3_ERP_ColorChange_P300', 'filename', 'S3_ERP_ColorChange_P300.erp', 'filepath',...
%  'C:\Users\mattokaren3\Box\Project_FlickerHealthyYoungAdults\Data Analysis\EEG\Data Analysis\ERPLAB Analysis\ERPsets\ColorChangeOnly', 'Warning',...
%  'on');
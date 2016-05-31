function varargout = SRP_DataCleanup(varargin)
% SRP_DATACLEANUP MATLAB code for SRP_DataCleanup.fig
%      SRP_DATACLEANUP, by itself, creates a new SRP_DATACLEANUP or raises the existing
%      singleton*.
%
%      H = SRP_DATACLEANUP returns the handle to a new SRP_DATACLEANUP or the handle to
%      the existing singleton*.
%
%      SRP_DATACLEANUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRP_DATACLEANUP.M with the given input arguments.
%
%      SRP_DATACLEANUP('Property','Value',...) creates a new SRP_DATACLEANUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SRP_DataCleanup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SRP_DataCleanup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SRP_DataCleanup

% Last Modified by GUIDE v2.5 04-Apr-2016 14:46:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SRP_DataCleanup_OpeningFcn, ...
                   'gui_OutputFcn',  @SRP_DataCleanup_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SRP_DataCleanup is made visible.
function SRP_DataCleanup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SRP_DataCleanup (see VARARGIN)

% Choose default command line output for SRP_DataCleanup
handles.output = hObject;
handles.appliedthresh=0;
handles.sessioncolors=[1 0 0;0 0 1;0 1 0;1 0 1;0 1 1];
MasterSRPData=guidata(SRPAnalysis_Master);
checkprocessed=isfield(MasterSRPData,'processed_loaded');
checkunvetted=isfield(MasterSRPData,'unvetted_loaded');
checkvetted=isfield(MasterSRPData,'vetted_loaded');
checkguioptions=isfield(MasterSRPData,'guioptions_loaded');
if checkprocessed==1
    handles.processed_loaded=MasterSRPData.processed_loaded;
else
    handles.processed_loaded=0;
end

if checkunvetted==1
    handles.unvetted_loaded=MasterSRPData.unvetted_loaded;
else
    handles.unvetted_loaded=0;
end

if checkvetted==1
    handles.vetted_loaded=MasterSRPData.vetted_loaded;
else
    handles.vetted_loaded=0;
end

if checkguioptions==1
    handles.guioptions_loaded=MasterSRPData.guioptions_loaded;
else
    handles.guioptions_loaded=0;
end

if handles.processed_loaded == 1
    handles.Processed_Data=MasterSRPData.MainStructure;
end
if handles.unvetted_loaded == 1
    handles.Unvetted_Data=MasterSRPData.Master_SRPData_Loaded.MasterSRPData;
end
if handles.vetted_loaded == 1
    handles.Vetted_Data=MasterSRPData.Cleaned_SRPData_Loaded.Cleaned_SRPData;
end
if handles.guioptions_loaded==1
    handles.saved_options=MasterSRPData.GUI_Options_Loaded;
end
handles.minloc=0;
handles.maxloc=0;
handles.error=0;
handles.setblind=0;
handles.currentdata_loaded=0;
handles.usesmoothing=0;
handles.smoothingwindow=50;
handles.removeartifacts=0;
handles.usehemi=1;
handles.separateflipflops=0;
handles.ylim=false;
handles.BlindGroup={'Combined Blind Group'};
handles.realgroups='';
SRP_Options_working=getappdata(0,'SRP_options');
SrpThresh = str2num(SRP_Options_working{6,2});
handles.day1thresh=SrpThresh;
set(handles.day1_thresh,'String',num2str(SrpThresh));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SRP_DataCleanup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SRP_DataCleanup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SRPDC_useloaded.
function SRPDC_useloaded_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_useloaded (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_useloaded




uservalue=get(hObject,'Value');
handles.usefilelist=0;
if uservalue==1
    
    set(handles.SRPDC_useprocessed,'Value',0);
    set(handles.SRPDC_useprocessed,'Enable','off');
    if handles.unvetted_loaded ~= 1
        msgbox('The necessary original unvetted reference file is not loaded.','Error');
        return;
    end
        
    if handles.vetted_loaded ~= 1
        msgbox('There is no vetted reference file loaded.','Error');
        set(handles.SRPDC_useloaded,'Value',0);
        return;
    end
   checkreferencedata=isfield(handles,'MasterSRPData');
   if checkreferencedata == 1
       handles=rmfield(handles,'MasterSRPData');
       handles.MasterSRPData=handles.Unvetted_Data;
   else
       handles.MasterSRPData=handles.Unvetted_Data;
   end
       
    checktempstorage=isfield(handles,'TempLoaded_Cleaned');
    %currentdata_loaded = 1 then processed data is in memory
    %currentdata_loaded = 2 then loaded data is in memory
    if handles.currentdata_loaded == 1
        check_current_vars(1,1)=isfield(handles,'Cleaned_SRPData');
        check_current_vars(1,2)=isfield(handles,'blindfilelist');
        check_current_vars(1,3)=isfield(handles,'randomizekey');
        check_current_vars(1,4)=isfield(handles,'blindfilenames');
        check_current_vars(1,5)=isfield(handles,'randomizedfilenames');
        check_current_vars(1,6)=isfield(handles,'fileassociations');
        check_current_vars(1,7)=isfield(handles,'day1threshtracker');
        if sum(check_current_vars(1,1:5))==5
            handles.TempProcessed_Cleaned=handles.Cleaned_SRPData;
            blinddata=get(handles.SRPDC_blind_data,'Value');
            if blinddata==1
                handles=flushblindfilelist(handles);
                if handles.usefilelist~=0  
                    for i = 1:length(handles.modified_fileindex)
                        handles.blindfilenames{handles.modified_fileindex(1,i),1}=handles.modified_filelist{1,i};
                    end
                else
                    handles.blindfilenames=get(SRPDC_filelist,'String');
                end
            end
            handles.TempProcessed_blindfilelist=handles.blindfilelist;
            handles.TempProcessed_randomizekey=handles.randomizekey;
            handles.TempProcessed_blindfilenames=handles.blindfilenames;
            handles.TempProcessed_randomizedfilenames=handles.randomizedfilenames;
            
            checknotes=isfield(handles,'notepad_txt');
            if checknotes==1
                handles.TempProcessed_notepad_txt=handles.notepad_txt;
            end
            handles=rmfield(handles,{'Cleaned_SRPData','blindfilelist','randomizekey','blindfilenames','randomizedfilenames'});
        end
        if check_current_vars(1,6)==0
            for i = 1:groupnum
                groupfile_length=handles.grouplengths(i,1);
                SRP_Options_working=getappdata(0,'SRP_options');
                srpdays = str2num(SRP_Options_working{7,2});
                animaltracker=1;
                if i == 1
                    for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.fileassociations(filetracker,1)=i;
                            handles.fileassociations(filetracker,2)=animaltracker;
                            filetracker=filetracker+1;
                        end
                        animaltracker=animaltracker+1;
                    end
                else
                     for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.fileassociations(filetracker,1)=i;
                            handles.fileassociations(filetracker,2)=animaltracker;
                            filetracker=filetracker+1;
                        end
                        animaltracker=animaltracker+1;
                     end
                end
            end 
        else
            handles.TempProcessed_fileassociations=handles.fileassociations;
        end
        if check_current_vars(1,7)==0
            listbox_groups=fieldnames(handles.MasterSRPData);
            delname1='GroupNames';
            delname2='SrpThresh';
            delname3='srpdays';
            delname4='AmpGain';
            delname5='grpcolors';
            listbox_groups(strcmp((delname1),listbox_groups)) = [];
            listbox_groups(strcmp((delname2),listbox_groups)) = [];
            listbox_groups(strcmp((delname3),listbox_groups)) = [];
            listbox_groups(strcmp((delname4),listbox_groups)) = [];
            listbox_groups(strcmp((delname5),listbox_groups)) = [];

            [groupnum ~]=size(listbox_groups);
            filetracker=1;
            for i = 1:groupnum
                groupfile_length=length(handles.groupfiles_processed{i,:,:});
                SRP_Options_working=getappdata(0,'SRP_options');
                srpdays = str2num(SRP_Options_working{7,2});
                if i == 1
                    for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.day1threshtracker(filetracker,1)=1;
                            handles.day1threshtracker(filetracker,2)=1;
                            filetracker=filetracker+1;
                        end
                    end
                else
                     for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.day1threshtracker(filetracker,1)=1;
                            handles.day1threshtracker(filetracker,2)=1;
                            filetracker=filetracker+1;
                        end
                     end
                end
            end
            set(handles.applythresh_background,'BackgroundColor',[1 0 0]);
        else
            handles.TempProcessed_day1threshtracker=handles.day1threshtracker;
        end
        
    end
    if checktempstorage==0
%                     %Flush permanent changes to cleaned_srpdata so all changes are in temporary
%     %memory until written to cleaned_srpdata (for plotting) again.
% 
%     sessionnum=

                
                confirmoptions=isfield(handles.saved_options,'randomizekey');
                if confirmoptions==0
                    msgbox('The file you selected was not a proper options file','Error');
                    set(hObject,'Value',0);
                    return
                end

                checknotes=isfield(handles.saved_options,'notepad_txt');
                if checknotes==1
                    handles.notepad_txt=handles.saved_options.notepad_txt;
                end

                handles.Cleaned_SRPData=handles.Vetted_Data;
                set(handles.sessioninspector,'Value',0);
                set(handles.dayavg,'Value',1);
                set(handles.Right_Hemi,'Value',0);
                set(handles.Left_Hemi,'Value',1);
                set(handles.SRPDC_separateflipflops,'Value',0);
                blinddata=get(handles.SRPDC_blind_data,'Value');
                
                if blinddata==1
                    set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
                    listbox_groups=fieldnames(handles.MasterSRPData);
                    delname1='GroupNames';
                    delname2='SrpThresh';
                    delname3='srpdays';
                    delname4='AmpGain';
                    delname5='grpcolors';
                    listbox_groups(strcmp((delname1),listbox_groups)) = [];
                    listbox_groups(strcmp((delname2),listbox_groups)) = [];
                    listbox_groups(strcmp((delname3),listbox_groups)) = [];
                    listbox_groups(strcmp((delname4),listbox_groups)) = [];
                    listbox_groups(strcmp((delname5),listbox_groups)) = [];
                    handles.groupnames_processedSRP=listbox_groups;
                    [groupnum ~]=size(listbox_groups);
                    for i = 1:groupnum
                        handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                        groupfile_length=length(handles.groupfiles{i,:,:});
                        if i == 1
                            
                            handles.grouplengths(i,1)=groupfile_length;
                        else
                            
                            handles.grouplengths(i,1)=sum(handles.grouplengths)+groupfile_length;
                        end
                    end
                    %Generate blind filelist
                    
                    handles.randomizekey=handles.saved_options.randomizekey;
                    [~,handles.sortkey]=sort(handles.randomizekey);
                    if isfield(handles.saved_options,'guiblindfilelist')
                        handles.blindfilelist=handles.saved_options.guiblindfilelist;
                    else
                        handles.blindfilelist=handles.saved_options.blindfilelist;
                    end
                    handles.randomizedfilenames=handles.blindfilelist(1,handles.randomizekey);
                    handles.blindfilenames=handles.saved_options.blindfilenames;
                    %handles.resortedfilenames=handles.randomizedfilenames(1,handles.sortkey);
                    
                    check_vars(1,1)=isfield(handles.saved_options,'fileassociations');
                    check_vars(1,2)=isfield(handles.saved_options,'day1threshtracker');
                    if check_vars(1,1)==0
                        msgbox('Missing fileassociations variable');
                    else
                       handles.fileassociations=handles.saved_options.fileassociations;
                    end
                    if check_vars(1,2)==0
                        msgbox('Missing day1threshtracker variable');
                    else
                        handles.day1threshtracker=handles.saved_options.day1threshtracker;
                    end
                    
                    set(handles.SRPDC_filelist,'String',handles.blindfilenames);
                    handles.setblind=1;
                    handles.currentdata_loaded=2;
                else
                    set(handles.SRPDC_useloaded,'Enable','off');
                    listbox_groups=fieldnames(handles.MasterSRPData);
                    delname1='GroupNames';
                    delname2='SrpThresh';
                    delname3='srpdays';
                    delname4='AmpGain';
                    delname5='grpcolors';
                    listbox_groups(strcmp((delname1),listbox_groups)) = [];
                    listbox_groups(strcmp((delname2),listbox_groups)) = [];
                    listbox_groups(strcmp((delname3),listbox_groups)) = [];
                    listbox_groups(strcmp((delname4),listbox_groups)) = [];
                    listbox_groups(strcmp((delname5),listbox_groups)) = [];
                    set(handles.SRPDC_grouplist,'String',listbox_groups);


                    handles.groupnames_processedSRP=listbox_groups;
                    [groupnum ~]=size(listbox_groups);
                    for i = 1:groupnum
                        handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                    end
                    set(handles.SRPDC_filelist,'String',handles.groupfiles{1,:,:});
                    set(handles.SRPDC_filelist,'Value',1); 
                    handles.currentdata_loaded=2;
                end  
                
                
    else
        set(handles.sessioninspector,'Value',0);
        set(handles.dayavg,'Value',1);
        set(handles.Right_Hemi,'Value',0);
        set(handles.Left_Hemi,'Value',1);
        set(handles.SRPDC_separateflipflops,'Value',0);
        blinddata=get(handles.SRPDC_blind_data,'Value');
        handles.Cleaned_SRPData=handles.TempLoaded_Cleaned;
        if blinddata==1
                set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
                listbox_groups=fieldnames(handles.MasterSRPData);
                delname1='GroupNames';
                delname2='SrpThresh';
                delname3='srpdays';
                delname4='AmpGain';
                delname5='grpcolors';
                listbox_groups(strcmp((delname1),listbox_groups)) = [];
                listbox_groups(strcmp((delname2),listbox_groups)) = [];
                listbox_groups(strcmp((delname3),listbox_groups)) = [];
                listbox_groups(strcmp((delname4),listbox_groups)) = [];
                listbox_groups(strcmp((delname5),listbox_groups)) = [];
                handles.groupnames_processedSRP=listbox_groups;
                check_grplength=isfield(handles,'grouplengths');
                if check_grplength==1
                    handles=rmfield(handles,'grouplengths');
                end
                [groupnum ~]=size(listbox_groups);
                for i = 1:groupnum
                    handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                    groupfile_length=length(handles.groupfiles{i,:,:});
                    if i == 1
                        handles.grouplengths(i,1)=groupfile_length;
                    else
                        handles.grouplengths(i,1)=sum(handles.grouplengths)+groupfile_length;
                    end
                end
                handles.blindfilelist=handles.TempLoaded_blindfilelist;
                handles.fileassociations=handles.TempLoaded_fileassociations;
                handles.day1threshtracker=handles.TempLoaded_day1threshtracker;
                %Generate blind filelist
                totalfile_length=length(handles.blindfilelist);
                handles.randomizekey=handles.TempLoaded_randomizekey;
                [~,handles.sortkey]=sort(handles.randomizekey);
                handles.blindfilenames=handles.TempLoaded_blindfilenames;
                handles.randomizedfilenames=handles.TempLoaded_randomizedfilenames;
                set(handles.SRPDC_filelist,'String',handles.blindfilenames);
                handles.setblind=1;
                handles.currentdata_loaded=2;
        else
                set(handles.SRPDC_useprocessed,'Enable','off');
                listbox_groups=fieldnames(handles.MasterSRPData);
                delname1='GroupNames';
                delname2='SrpThresh';
                delname3='srpdays';
                delname4='AmpGain';
                delname5='grpcolors';
                listbox_groups(strcmp((delname1),listbox_groups)) = [];
                listbox_groups(strcmp((delname2),listbox_groups)) = [];
                listbox_groups(strcmp((delname3),listbox_groups)) = [];
                listbox_groups(strcmp((delname4),listbox_groups)) = [];
                listbox_groups(strcmp((delname5),listbox_groups)) = [];
                set(handles.SRPDC_grouplist,'String',listbox_groups);

                handles.groupnames_processedSRP=listbox_groups;
                [groupnum ~]=size(listbox_groups);
                for i = 1:groupnum
                    handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                end
                set(handles.SRPDC_filelist,'String',handles.groupfiles{1,:,:});
                set(handles.SRPDC_filelist,'Value',1); 
                handles.currentdata_loaded=2;
        end  
    end
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        selectedfile=get_correct_filenum(handles);
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    else
        selectedfile=get_correct_filenum(handles);
        selectedgroup = get(handles.SRPDC_grouplist,'Value');
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
    end
    set(handles.filelist_dayselection,'Visible','on');
    set(handles.applythresh_background,'Visible','on');
    set(handles.SRPDC_applythresh,'Visible','on');
    set(handles.text46,'Visible','on');
    set(handles.day1_thresh,'Visible','on');
    set(handles.SRPDC_removethresh,'Visible','on');
    set(handles.text43,'Visible','on');
    set(handles.custom_search_string,'Visible','on');
else
    set(handles.SRPDC_useprocessed,'Enable','on');
    handles=clear_gui_plots(handles);
    set(handles.SRPDC_revealnames,'Value',0);
    if handles.currentdata_loaded >= 1
        if handles.vetted_loaded==1
            if isfield(handles,'TempLoaded_Cleaned')==1
                handles=rmfield(handles,'TempLoaded_Cleaned');
            end
            handles.TempLoaded_Cleaned=handles.Cleaned_SRPData;
            blinddata=get(handles.SRPDC_blind_data,'Value');
            if blinddata==1
                handles=updatefilelist(handles);
            end
            check_blind_vars=isfield(handles,'blindfilelist');
            if check_blind_vars==1
                handles.TempLoaded_blindfilelist=handles.blindfilelist;
                handles.TempLoaded_randomizekey=handles.randomizekey;
                handles.TempLoaded_blindfilenames=handles.blindfilenames;
                handles.TempLoaded_randomizedfilenames=handles.randomizedfilenames;
                handles=rmfield(handles,{'Cleaned_SRPData','blindfilelist','randomizekey','blindfilenames','randomizedfilenames'});
            else
                handles=rmfield(handles,{'Cleaned_SRPData'});
            end
            check_vars(1,1)=isfield(handles,'fileassociations');
            check_vars(1,2)=isfield(handles,'day1threshtracker');
            if check_vars(1,1)==0
                msgbox('Missing fileassociations variable');
            else
                handles.TempLoaded_fileassociations=handles.fileassociations;
                handles=rmfield(handles,'fileassociations');
            end
            if check_vars(1,2)==0
                msgbox('Missing day1threshtracker variable');
            else
                handles.TempLoaded_day1threshtracker=handles.day1threshtracker;
                handles=rmfield(handles,'day1threshtracker');
            end
            
        end 
    end
    set(handles.filelist_dayselection,'Visible','off');
    set(handles.SRPDC_filelist,'String','No Data Loaded');
    set(handles.SRPDC_grouplist,'String','No Data Loaded');
    set(handles.applythresh_background,'Visible','off');
    set(handles.SRPDC_applythresh,'Visible','off');
    set(handles.text46,'Visible','off');
    set(handles.day1_thresh,'Visible','off');
    set(handles.SRPDC_removethresh,'Visible','off');
    set(handles.text43,'Visible','off');
    set(handles.custom_search_string,'Visible','off');
end






guidata(hObject, handles);

% --- Executes on button press in SRPDC_useprocessed.
function SRPDC_useprocessed_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_useprocessed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_useprocessed
uservalue=get(hObject,'Value');
handles.usefilelist=0;
if uservalue==1
    set(handles.SRPDC_useloaded,'Enable','off');
    if handles.processed_loaded~=1
        msgbox('No processed data found in Vetting GUI Memory.','Error');
        return;
    end
    
   checkreferencedata=isfield(handles,'MasterSRPData');
    if checkreferencedata == 1
        handles=rmfield(handles,'MasterSRPData');
        handles.MasterSRPData=handles.Processed_Data;
    else
       handles.MasterSRPData=handles.Processed_Data;
    end
        
    checktempstorage=isfield(handles,'TempProcessed_Cleaned');
    if handles.currentdata_loaded == 2
        check_current_vars(1,1)=isfield(handles,'Cleaned_SRPData');
        check_current_vars(1,2)=isfield(handles,'blindfilelist');
        check_current_vars(1,3)=isfield(handles,'randomizekey');
        check_current_vars(1,4)=isfield(handles,'blindfilenames');
        check_current_vars(1,5)=isfield(handles,'randomizedfilenames');
        check_current_vars(1,6)=isfield(handles,'fileassociations');
        check_current_vars(1,7)=isfield(handles,'day1threshtracker');
        if sum(check_current_vars)==5
            handles.TempLoaded_Cleaned=handles.Cleaned_SRPData;
            blinddata=get(handles.SRPDC_blind_data,'Value');
            if blinddata==1
                handles=flushblindfilelist(handles);
                if handles.usefilelist~=0  
                    for i = 1:length(handles.modified_fileindex)
                        handles.blindfilenames{handles.modified_fileindex(1,i),1}=handles.modified_filelist{1,i};
                    end
                else
                    handles.blindfilenames=get(SRPDC_filelist,'String');
                end
            end
            handles.TempLoaded_blindfilelist=handles.blindfilelist;
            handles.TempLoaded_randomizekey=handles.randomizekey;
            handles.TempLoaded_blindfilenames=handles.blindfilenames;
            handles.TempLoaded_randomizedfilenames=handles.randomizedfilenames;
            handles=rmfield(handles,{'Cleaned_SRPData','blindfilelist','randomizekey','blindfilenames','randomizedfilenames'});
        end
        
        
        if check_current_vars(1,6)==0
            for i = 1:groupnum
                groupfile_length=handles.grouplengths(i,1);
                SRP_Options_working=getappdata(0,'SRP_options');
                srpdays = str2num(SRP_Options_working{7,2});
                animaltracker=1;
                if i == 1
                    for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.fileassociations(filetracker,1)=i;
                            handles.fileassociations(filetracker,2)=animaltracker;
                            filetracker=filetracker+1;
                        end
                        animaltracker=animaltracker+1;
                    end
                else
                     for j=1:srpdays:groupfile_length
                        for day=1:srpdays
                            handles.fileassociations(filetracker,1)=i;
                            handles.fileassociations(filetracker,2)=animaltracker;
                            filetracker=filetracker+1;
                        end
                        animaltracker=animaltracker+1;
                     end
                end
            end 
        else
            handles.TempLoaded_fileassociations=handles.fileassociations;
        end
        
        if check_current_vars(1,7)==0
            %generate new tracker
        else
            handles.TempLoaded_day1threshtracker=handles.day1threshtracker;
        end
        
                
    end
    if checktempstorage==0
        %If the user checks use processed and there are no temporary
        %processed files loaded in memory then check if there are original
        %processed files loaded in memory.
            if handles.processed_loaded==1
                %If there are original processed files loaded in memory
                %then set "working_variables" to original processed data.
                %"working_variables" are the variables used for many
                %functions in the GUI and can be processed data or loaded data.
                
                %Since there are no temporary processed files found and
                %since we are in the "use processed data" section then this
                %means this is the first time the user has selected this
                %option so we need to generate the first instance of
                %Cleaned_SRPData which (at this point) will be equal to the
                %raw data file. AKA, no vetting has been done at this
                %point.
                handles.Cleaned_SRPData=handles.MasterSRPData;
                
                %Setting default values for initial vetting options for
                %processed data.
                set(handles.sessioninspector,'Value',0);
                set(handles.dayavg,'Value',1);
                set(handles.Right_Hemi,'Value',0);
                set(handles.Left_Hemi,'Value',1);
                set(handles.SRPDC_separateflipflops,'Value',0);
                blinddata=get(handles.SRPDC_blind_data,'Value');
                %blinddata indicates whether or not the user has selected
                %to blind the data via the "Blind Data" checkbox.
                
                %handles.setblind indicates whether or not the gui is
                %showing blind data.  0 is false, 1 is true.
                if blinddata==1
                    %If the user has indicated they want the data blind
                    %(AKA blinddata==1) and the gui has not yet actually
                    %blinded the data (AKA handles.setblind=0) then let's
                    %actually blind the data.
                    
                    %Do not display actual group names, instead only display
                    %the default "Blind Group" which contains all group
                    %files in random order.
                    set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
                    
                    %We will get the group number by extracting the
                    %fieldnames from MasterSRPData.
                    listbox_groups=fieldnames(handles.MasterSRPData);
                    
                    %There are some fields that are not group names (and will thus
                    %give us an innacurate group number) so we delete them
                    %here.
                    delname1='GroupNames';
                    delname2='SrpThresh';
                    delname3='srpdays';
                    delname4='AmpGain';
                    delname5='grpcolors';
                    listbox_groups(strcmp((delname1),listbox_groups)) = [];
                    listbox_groups(strcmp((delname2),listbox_groups)) = [];
                    listbox_groups(strcmp((delname3),listbox_groups)) = [];
                    listbox_groups(strcmp((delname4),listbox_groups)) = [];
                    listbox_groups(strcmp((delname5),listbox_groups)) = [];
                    
                    %at this point, the listbox_groups variable only
                    %contains the group names.
                    
                    %We will now store these group names (which are the
                    %processed data group names since we are in the use
                    %processed code right now) into a proper variable to
                    %keep track of processed data group names.
                    handles.groupnames_processedSRP=listbox_groups;
                    
                    %The group number is determined by taking the size of
                    %the listbox_groups variable.
                    [groupnum ~]=size(listbox_groups);
                    
                    %At this point we have two main "working variables"
                    %which are MasterSRPData and Cleaned_SRPData which are
                    %equal.  We will use Cleaned_SRPData to extract the
                    %file names from each group by using the groupnum
                    %variable.
                    filetracker=1;
                    for i = 1:groupnum
                        %for each group, extract the filename data into a
                        %new variable called handles.groupfiles_processed.
                        
                        %handles.groupfiles_processed{A,B,C} where A is the group
                        %number and B and C contain filename information.
                        
                        %(handles.groupnames_processedSRP{i,1}) allows us
                        %to extract the correct group fieldnames for each
                        %for-loop pass from the Cleaned_SRPData structure.
                        handles.groupfiles_processed{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                        
                        %For each group, keep track of the number of files
                        %WARNING: I might need to change from using the
                        %length function to the size function to prevent
                        %errors when using a small number of files.
                        groupfile_length=length(handles.groupfiles_processed{i,:,:});
                        
                        %If this is the first pass through this for loop
                        %which is extracting filenames for the groups and
                        %since the user has indicated they want to blind
                        %the data (see above lines of code) then we need to
                        %generate the first instance of the blindfilelist
                        %variable and the grouplengths variable.
                        
                        %blindfilelist will contain every filename from
                        %every group in linear order.
                        
                        %grouplengths will let us know at which point the
                        %filenames inside blind filelist switch from one
                        %group to another group... for instance if there
                        %3 groups total and there are 30 files in group 1,
                        %40 files in group 2, and 50 files in group 3 then 
                        %grouplengths will = [30;70;120]
                        %This lets us know that files 1-30 in the blind
                        %filelist are from group 1, files 31-70 are from
                        %group 2, and 71-120 are from group 3.  This is
                        %used to allow the user to correctly modify/display data 
                        %when working with blind data.
                        
                        %To save work for the user, we only want to eventually
                        %look at data that passes the threshold applied to the
                        %day 1 files.  To do this, we need to keep track of
                        %which animal files are in which groups.  We will
                        %generate this variable here also.
                        
                        %We will need to pull a few options from memory 
                        SRP_Options_working=getappdata(0,'SRP_options');
                        srpdays = str2num(SRP_Options_working{7,2});
                        
                        animaltracker=1;
                        if i == 1
                            for j=1:srpdays:groupfile_length
                                for day=1:srpdays
                                    %fileassociations, column 1 = group num
                                    %fileassociations, column 2 =
                                    %associated animals... example:
                                    %2 groups, group 1 has 3 animals, group
                                    %2 has 1 animal. Since srpdays in this
                                    %example is 2, each file will have 2
                                    %associated files.
                                    %STRUCTURE:
                                    %1 1
                                    %1 1
                                    %1 2
                                    %1 2
                                    %1 3
                                    %1 3
                                    %2 1
                                    %2 1
                                    handles.fileassociations(filetracker,1)=i;
                                    handles.fileassociations(filetracker,2)=animaltracker;
                                    handles.day1threshtracker(filetracker,1)=1;
                                    handles.day1threshtracker(filetracker,2)=1;
                                    filetracker=filetracker+1;
                                end
                                animaltracker=animaltracker+1;
                            end
                            handles.blindfilelist=handles.groupfiles_processed{i,:,:};
                            handles.grouplengths(i,1)=groupfile_length;
                        else
                             for j=1:srpdays:groupfile_length
                                for day=1:srpdays
                                    
                                    %fileassociations, column 1 = group num
                                    %fileassociations, column 2 =
                                    %associated animals... example:
                                    %2 groups, group 1 has 3 animals, group
                                    %2 has 1 animal. Since srpdays in this
                                    %example is 2, each file will have 2
                                    %associated files.
                                    %STRUCTURE:
                                    %1 1
                                    %1 1
                                    %1 2
                                    %1 2
                                    %1 3
                                    %1 3
                                    %2 1
                                    %2 1
                                    handles.fileassociations(filetracker,1)=i;
                                    handles.fileassociations(filetracker,2)=animaltracker;
                                    handles.day1threshtracker(filetracker,1)=1;
                                    handles.day1threshtracker(filetracker,2)=1;
                                    filetracker=filetracker+1;
                                end
                                animaltracker=animaltracker+1;
                            end
                            %Since blindfilelist will exist at this point,
                            %we can append filenames with the code below.
                            handles.blindfilelist=[handles.blindfilelist handles.groupfiles_processed{i,:,:}];
                            handles.grouplengths(i,1)=handles.grouplengths(i-1)+groupfile_length;
                        end
                    end
                    
                    
                   
                    
                    
                    
                    %At this point, we have blindfilelist generated which
                    %contains all of the filenames from all the groups in
                    %linear order.
                    
                    %We will now generate a random permutation for the file
                    %order so the user will not be able to guess the
                    %correct file due to the linear order of the
                    %blindfilelist variable.
                    
                    %First we get the total number of files in
                    %blindfilelist.
                    totalfile_length=length(handles.blindfilelist);
                    
                    %using this information we generate our "key" which
                    %contians the random order of files from 1 to
                    %totalfile_length which is stored int he randomizekey
                    %variable.
                    handles.randomizekey=randperm(totalfile_length);
                    
                    
                    %Now that we have our randomize key, we will generate a
                    %random filename list.
                    handles.randomizedfilenames=handles.blindfilelist(1,handles.randomizekey);
                    
                    
                    %Although our filenames are now random, we only want
                    %the user to ever see generic names that do not actualy
                    %reveal the true filename. To accomplish this, we will
                    %create a linear list continaing filenames "Blind File #".
                    
                    %blindfilecolors is not currently used.
                    for i = 1:totalfile_length
                        handles.blindfilenames{i,1}=sprintf('Blinded File %s',num2str(i));
                        handles.blindfilecolors(i,1:3)=[1 1 1];
                    end
                    
                    %OVERVIEW:
                    %When the user selects (for example) "Blind File 3"
                    %from the file list, we must be able to translate the
                    %blind file location (which would be 3) to the correct
                    %random permutation filename.  To accomplish this we
                    %would take "3" and then check that against the
                    %randomizedfilenames which could (for example)
                    %correspond to Actual_File_15 by using our randomizekey
                    %variable.  We can then use the grouplengths variable
                    %to know that Actual_File_15 is found in (for example)
                    %group 1.  With this information we can now correctly display or
                    %modify Actual_File_15 whenever the user interacts with
                    %"Blind File 3".

                    %We now want to populate the listbox "SRPDC_filelist"
                    %with the blindfilenames variable.
                    set(handles.SRPDC_filelist,'String',handles.blindfilenames);
                    
                    %Now that the user is blind to the data, we will set
                    %the indicator to 1 (true).
                    handles.setblind=1;
                    
                    %Now that the processed data is loaded into the
                    %"working variables" we will set currentdata_loaded to
                    %1 which indicates that "processed data" is currently
                    %in memory.  A value of 2 would indicate that "loaded
                    %data" is currently in memory.
                    handles.currentdata_loaded=1;
                    
                    %We will store the grouplengths information in memory
                    %for later use...
                    handles.grouplengths_processed=handles.grouplengths;
                    
                    %Set working variable equal to stored variable
                    handles.groupfiles=handles.groupfiles_processed;
                else
                    %If the user selects "use processed data" and they have
                    %indicated that they do not want the data to be blind
                    %then we will display the group and file data to the
                    %user.
                    
                    %First we need to extract the groups from the
                    %fieldnames of handles.MasterSRPData
                    
                    listbox_groups=fieldnames(handles.MasterSRPData);
                    %Some of the filednames are not group names and must be
                    %removed.
                    delname1='GroupNames';
                    delname2='SrpThresh';
                    delname3='srpdays';
                    delname4='AmpGain';
                    delname5='grpcolors';
                    listbox_groups(strcmp((delname1),listbox_groups)) = [];
                    listbox_groups(strcmp((delname2),listbox_groups)) = [];
                    listbox_groups(strcmp((delname3),listbox_groups)) = [];
                    listbox_groups(strcmp((delname4),listbox_groups)) = [];
                    listbox_groups(strcmp((delname5),listbox_groups)) = [];
                    
                    %Since listbox_groups only contains group names for the
                    %processed data, set the group listbox to display
                    %listbox_groups.
                    set(handles.SRPDC_grouplist,'String',listbox_groups);

                    %We will store the group name information for the
                    %processed data in a variable called
                    %groupnames_processedSRP for later use.
                    handles.groupnames_processedSRP=listbox_groups;
                    
                    %Since listbox_groups now only contains group names, we
                    %can determine the number of groups with the size
                    %function.
                    [groupnum ~]=size(listbox_groups);
                    
                    
                    %For each group, we will extract the filenames from
                    %Cleaned_SRPData (which at this point is equal to the
                    %unvetted raw data).
                    for i = 1:groupnum
                        handles.groupfiles_processed{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
                    end
                    
                    %The program default displays the first group, so we
                    %will set the filelist listbox to show the first group
                    %filenames.
                    set(handles.SRPDC_filelist,'String',handles.groupfiles_processed{1,:,:});
                    
                    %The program default selects the first file in the
                    %list, so we will set that value here.
                    set(handles.SRPDC_filelist,'Value',1);
                    
                    
                    %Now that the processed data is loaded into the
                    %"working variables" we will set currentdata_loaded to
                    %1 which indicates that "processed data" is currently
                    %in memory.  A value of 2 would indicate that "loaded
                    %data" is currently in memory.
                    handles.currentdata_loaded=1;
                    
                    %Flush working variable and fill with stored data
                    check_grpfiles=isfield(handles,'groupfiles');
                    if check_grpfiles==1
                        handles=rmfield(handles,'groupfiles');
                    end
                    handles.groupfiles=handles.groupfiles_processed;
                end  
            else
                %If there is no processed data found in memory, then let
                %the user know and uncheck the "use processed data" box.
               msgbox('There is no newly processed data loaded.','Error');
               set(hObject,'Value',0);
            end
    else
        %If there is temporary processed data found in memory (which
        %indicates that we have at some point in the past unchecked the
        %"use processed box") we will pull the correct data from the
        %temporary processed data variables to allow the user to resume
        %their vetting session of the data.
        
        %First set all the options back to intial default settings...
        set(handles.sessioninspector,'Value',0);
        set(handles.dayavg,'Value',1);
        set(handles.Right_Hemi,'Value',0);
        set(handles.Left_Hemi,'Value',1);
        set(handles.SRPDC_separateflipflops,'Value',0);
        
        
        %Next, we will check if there is currently data in the "working variable" 
        %Cleaned_SRPData.  If there is we will clear it and repopulate it
        %with the data stored in the temporary processed variable.
        
        check_cleaned=isfield(handles,'Cleaned_SRPData');
        if check_cleaned == 1
            handles=rmfield(handles,'Cleaned_SRPData');
        end
        handles.Cleaned_SRPData=handles.TempProcessed_Cleaned;
        
        %Determine if the user would like to blind the data before it
        %is displayed.
        blinddata=get(handles.SRPDC_blind_data,'Value');
        
        %If the user has indicated they want the data blind
        %(AKA blinddata==1) and the gui has not yet actually
        %blinded the data (AKA handles.setblind=0) then let's
        %actually blind the data.
        if blinddata==1
                %Do not display actual group names, instead only display
                %the default "Blind Group" which contains all group
                %files in random order.
                set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
                
                %Extract the blindfilelist from the temporary processed
                %data variable. This variable contains all the file
                %information from all groups in linear oder.
                handles.blindfilelist=handles.TempProcessed_blindfilelist;
                
                %Extract the fileassociation and threshtracker variables
                %from temporary processed data
                handles.fileassociations=handles.TempProcessed_fileassociations;
                handles.day1threshtracker=handles.TempProcessed_day1threshtracker;
                
                %Extract the randomizekey from the temporary processed data
                %variable. This variable contains the key information to
                %correctly move between the blindfilelist and
                %randomizedfilenames variables.
                handles.randomizekey=handles.TempProcessed_randomizekey;
                
                %Extract the blindfilenames from the temporary processed
                %data variable.  This variable contains generic filename
                %strings such as "Blind Filename #".
                handles.blindfilenames=handles.TempProcessed_blindfilenames;
                
                %Extract the randomized filenames from the temporary processed
                %data variable.  This prevents the user from guessing the
                %filename due to the linear oder of the blindfilelist
                %variable.
                handles.randomizedfilenames=handles.TempProcessed_randomizedfilenames;
                
                %Display the generic filenames in the filelist listbox.
                set(handles.SRPDC_filelist,'String',handles.blindfilenames);
                
                %Since the data is now blind, set the indicator in the
                %options.
                handles.setblind=1;
                
                %Now that the processed data is loaded into the
                %"working variables" we will set currentdata_loaded to
                %1 which indicates that "processed data" is currently
                %in memory.  A value of 2 would indicate that "loaded
                %data" is currently in memory.
                handles.currentdata_loaded=1;
                
                %Extract group length information from stored memory.
                %Clear group lengths if this variable currently exists.
                check_grplength=isfield(handles,'grouplengths');
                if check_grplength==1
                    handles=rmfield(handles,'grouplengths');
                    handles.grouplengths=handles.grouplengths_processed;
                else

                    handles.grouplengths=handles.grouplengths_processed;
                end
        else
            %If there is temporary processed data found in memory (which
            %indicates that we have at some point in the past unchecked the
            %"use processed box") we will pull the correct data from the
            %temporary processed data variables to allow the user to resume
            %their vetting session of the data.
            
            %At this point, the user has indicated they do not want the
            %data to be blind (see if check above).
            
            %First set all the options back to intial default settings...
            set(handles.sessioninspector,'Value',0);
            set(handles.dayavg,'Value',1);
            set(handles.Right_Hemi,'Value',0);
            set(handles.Left_Hemi,'Value',1);
            set(handles.SRPDC_separateflipflops,'Value',0);


            %Next, we will check if there is currently data in the "working variable" 
            %Cleaned_SRPData.  If there is we will clear it and repopulate it
            %with the data stored in the temporary processed variable.

            check_cleaned=isfield(handles,'Cleaned_SRPData');
            if check_cleaned == 1
                handles=rmfield(handles,'Cleaned_SRPData');
            end
            handles.Cleaned_SRPData=handles.TempProcessed_Cleaned;
        
            
            %Show processed groups to user.  We have previously generated
            %this information on the first time "use processed data" was
            %checked, so we will pull that information from memory.
            set(handles.SRPDC_grouplist,'String',handles.groupnames_processedSRP);


            %The program default displays the first group, so we
            %will set the filelist listbox to show the first group
            %filenames.
            set(handles.SRPDC_filelist,'String',handles.groupfiles{1,:,:});
            
            %The program default selects the first file in the
            %list, so we will set that value here.
            set(handles.SRPDC_filelist,'Value',1); 
            
            %Now that the processed data is loaded into the
            %"working variables" we will set currentdata_loaded to
            %1 which indicates that "processed data" is currently
            %in memory.  A value of 2 would indicate that "loaded
            %data" is currently in memory.
            handles.currentdata_loaded=1;
        end  
    end
    %Update plots
    
    %If data is blind, then use file decoding functions.
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        %Get selected blind file
        selectedfile=get_correct_filenum(handles);
        %Use blind file to determine the corresponding actual file and
        %group
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
        
        %update plots
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    else
        %If data is not blind, use regular file functions.
        %Get file number
        selectedfile=get_correct_filenum(handles);
        
        %Get group number
        selectedgroup = get(handles.SRPDC_grouplist,'Value');
        
        %Update plot
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
    end
    
    %Display the radio button for user selection.
    set(handles.filelist_dayselection,'Visible','on');
    set(handles.applythresh_background,'Visible','on');
    set(handles.SRPDC_applythresh,'Visible','on');
    set(handles.text46,'Visible','on');
    set(handles.day1_thresh,'Visible','on');
    set(handles.SRPDC_removethresh,'Visible','on');
    set(handles.text43,'Visible','on');
    set(handles.custom_search_string,'Visible','on');
    
else
    %The user has unchecked the "use processed data box" indicating that
    %they would like to store the current vetting session into temporary
    %memory and possibly want to vet the loaded data.
    
    %The first thing we will do is store all current "working data"
    %variables into temporary memory...
    
    %For error checking, make sure that the current data in memory is in
    %fact processed data.
    if handles.currentdata_loaded == 1
        %Check for previously saved data
        if isfield(handles,'TempProcessed_Cleaned')==1
            handles=rmfield(handles,'TempProcessed_Cleaned');
        end
        
        %All of the variables saved will be necessary to recreate the
        %user's vetting session when they re-check the "use processed data"
        %box.
            handles.TempProcessed_Cleaned=handles.Cleaned_SRPData;
            
            
            %Clear plots and uncheck reveal true filenames.
            handles=clear_gui_plots(handles);
            set(handles.SRPDC_revealnames,'Value',0);
            %Check if data is currently blind...
            blinddata=get(handles.SRPDC_blind_data,'Value');
            if blinddata==1
                handles=updatefilelist(handles);
            end
            check_blind_vars=isfield(handles,'blindfilelist');
            if check_blind_vars==1
                handles.TempProcessed_blindfilelist=handles.blindfilelist;
                handles.TempProcessed_randomizekey=handles.randomizekey;
                handles.TempProcessed_blindfilenames=handles.blindfilenames;
                handles.TempProcessed_randomizedfilenames=handles.randomizedfilenames;
                handles=rmfield(handles,{'Cleaned_SRPData','blindfilelist','randomizekey','blindfilenames','randomizedfilenames'});
            
            else
                handles=rmfield(handles,{'Cleaned_SRPData'});
            end
                            %Clear all working variables except MasterSRPData (which is
            %cleared at the beginning of either useloaded or useprocessed
            %functions).
            check_vars(1,1)=isfield(handles,'fileassociations');
            check_vars(1,2)=isfield(handles,'day1threshtracker');
            if check_vars(1,1)==0
                msgbox('Missing fileassociations variable');
            else
                handles.TempProcessed_fileassociations=handles.fileassociations;
                handles=rmfield(handles,'fileassociations');
            end
            if check_vars(1,2)==0
                msgbox('Missing day1threshtracker variable');
            else
                handles.TempProcessed_day1threshtracker=handles.day1threshtracker;
                handles=rmfield(handles,'day1threshtracker');
            end

    end
    
    %Enable the user the option to work with previously loaded data.
    set(handles.SRPDC_useloaded,'Enable','on');
    
    %Indicate to the user that "working data" has been cleared.
    set(handles.filelist_dayselection,'Visible','off');
    set(handles.SRPDC_filelist,'String','No Data Loaded');
    set(handles.SRPDC_grouplist,'String','No Data Loaded');
    set(handles.applythresh_background,'Visible','off');
    set(handles.SRPDC_applythresh,'Visible','off');
    set(handles.text46,'Visible','off');
    set(handles.day1_thresh,'Visible','off');
    set(handles.text43,'Visible','off');
    set(handles.custom_search_string,'Visible','off');
    set(handles.SRPDC_removethresh,'Visible','off');

end
guidata(hObject, handles);

% --- Executes on button press in SRPDC_sessions_cleanup.
function SRPDC_sessions_cleanup_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_sessions_cleanup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_sessions_cleanup


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

function SRPDC_upper_ylim_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_upper_ylim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRPDC_upper_ylim as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_upper_ylim as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_upper_ylim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_upper_ylim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SRPDC_lower_ylim_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_lower_ylim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRPDC_lower_ylim as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_lower_ylim as a double
userinput=get(hObject,'String');
checkinputdouble(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_lower_ylim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_lower_ylim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SRPDC_session1.
function SRPDC_session1_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_session1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_session1
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    use_session=get(hObject,'Value');
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    if use_session==0
        handles=sessionplot(truegroup,truefilenum,handles,hObject,1,true,0,0,0);
    else
        handles=sessionplot(truegroup,truefilenum,handles,hObject,1,false,0,0,0);
    end
else
    use_session=get(hObject,'Value');
    selectedgroup=get(handles.SRPDC_grouplist,'Value');
    selectedfile=get_correct_filenum(handles);
    if use_session==0
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,1,true,0,0,0);
    else
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,1,false,0,0,0);
    end
end

% --- Executes on button press in SRPDC_session2.
function SRPDC_session2_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_session2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_session2
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    use_session=get(hObject,'Value');
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    if use_session==0
        handles=sessionplot(truegroup,truefilenum,handles,hObject,2,true,0,0,0);
    else
        handles=sessionplot(truegroup,truefilenum,handles,hObject,2,false,0,0,0);
    end    
else
    use_session=get(hObject,'Value');
    selectedgroup=get(handles.SRPDC_grouplist,'Value');
    selectedfile=get_correct_filenum(handles);
    if use_session==0
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,2,true,0,0,0);
    else
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,2,false,0,0,0);
    end
end

% --- Executes on button press in SRPDC_session3.
function SRPDC_session3_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_session3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_session3
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    use_session=get(hObject,'Value');
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    if use_session==0
        handles=sessionplot(truegroup,truefilenum,handles,hObject,3,true,0,0,0);
    else
        handles=sessionplot(truegroup,truefilenum,handles,hObject,3,false,0,0,0);
    end    
else
    use_session=get(hObject,'Value');
    selectedgroup=get(handles.SRPDC_grouplist,'Value');
    selectedfile=get_correct_filenum(handles);
    if use_session==0
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,3,true,0,0,0);
    else
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,3,false,0,0,0);
    end
end

% --- Executes on button press in SRPDC_session4.
function SRPDC_session4_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_session4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_session4
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    use_session=get(hObject,'Value');
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    if use_session==0
        handles=sessionplot(truegroup,truefilenum,handles,hObject,4,true,0,0,0);
    else
        handles=sessionplot(truegroup,truefilenum,handles,hObject,4,false,0,0,0);
    end    
else
    use_session=get(hObject,'Value');
    selectedgroup=get(handles.SRPDC_grouplist,'Value');
    selectedfile=get_correct_filenum(handles);
    if use_session==0
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,4,true,0,0,0);
    else
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,4,false,0,0,0);
    end
end

% --- Executes on button press in SRPDC_session5.
function SRPDC_session5_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_session5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_session5
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    use_session=get(hObject,'Value');
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    if use_session==0
        handles=sessionplot(truegroup,truefilenum,handles,hObject,5,true,0,0,0);
    else
        handles=sessionplot(truegroup,truefilenum,handles,hObject,5,false,0,0,0);
    end    
else
    use_session=get(hObject,'Value');
    selectedgroup=get(handles.SRPDC_grouplist,'Value');
    selectedfile=get_correct_filenum(handles);
    if use_session==0
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,5,true,0,0,0);
    else
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,5,false,0,0,0);
    end
end

% --- Executes on button press in SRPDC_keepselected.
function SRPDC_keepselected_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_keepselected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in SRPDC_filelist.
function SRPDC_filelist_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SRPDC_filelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SRPDC_filelist
handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
else
    selectedfile=get_correct_filenum(handles);
    selectedgroup = get(handles.SRPDC_grouplist,'Value');
    handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

    
    %Restore session checkboxes or generate default values for this
    %specific file.
    groupname=(handles.groupnames_processedSRP{selectedgroup,1});
    filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
    filename=(filename{1,1}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
%handles=enableuserinput(handles);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_filelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in SRPDC_grouplist.
function SRPDC_grouplist_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_grouplist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SRPDC_grouplist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SRPDC_grouplist
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    %do nothing since there will only ever be 1 blind group
else
    selectedgroup = get(hObject,'Value');
    set(handles.SRPDC_filelist,'String',handles.groupfiles{selectedgroup,:,:});
    set(handles.SRPDC_filelist,'Value',1);
    handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,1),handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{selectedgroup,1});
    filename=(handles.groupfiles{selectedgroup,1}(1,1));
    filename=(filename{1,1}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,1}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_grouplist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_grouplist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SRPDC_nextfile.
function SRPDC_nextfile_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_nextfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles=disableuserinput(handles);
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        
        filelistbox_location=get(handles.SRPDC_filelist,'Value');
        filelist=get(handles.SRPDC_filelist,'String');
        if length(filelist) >= (filelistbox_location+1)
            filelistbox_location=filelistbox_location+1;
            set(handles.SRPDC_filelist,'Value',filelistbox_location);
            selectedfile=get_correct_filenum(handles);
            
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
            groupname=(handles.groupnames_processedSRP{truegroup,1});
            filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
            
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
        else
            %do nothing
        end
    else
        
        filelistbox_location=get(handles.SRPDC_filelist,'Value');
        filelist=get(handles.SRPDC_filelist,'String');
        if length(filelist) >= (filelistbox_location+1)
            filelistbox_location=filelistbox_location+1;
            set(handles.SRPDC_filelist,'Value',filelistbox_location);
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');

            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

            groupname=selectedgroup;
            filename=selectedfile;
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
        else
            %do nothing
        end
    end
    handles=enableuserinput(handles);
guidata(hObject,handles);

% --- Executes on button press in SRPDC_blind_data.
function SRPDC_blind_data_Callback(hObject, ~, handles)
% hObject    handle to SRPDC_blind_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_blind_data

check_processed=get(handles.SRPDC_useprocessed,'Value');
check_loaded=get(handles.SRPDC_useloaded,'Value');

if check_processed == 0 && check_loaded == 0
    return;
end

blinddata=get(hObject,'Value');
if blinddata == 1
    set(handles.SRPDC_revealnames,'Enable','on');
    set(handles.custom_search_string,'Enable','on');
    set(handles.filelist_alldays,'Enable','on');
    set(handles.filelist_day1,'Enable','on');
    set(handles.filelist_day2,'Enable','on');
    set(handles.filelist_day3,'Enable','on');
    set(handles.filelist_day4,'Enable','on');
    set(handles.filelist_day5,'Enable','on');
    set(handles.applythresh_background,'Enable','on');
    set(handles.SRPDC_applythresh,'Enable','on');
    set(handles.text46,'Enable','on');
    set(handles.day1_thresh,'Enable','on');
    set(handles.SRPDC_removethresh,'Enable','on');
    set(handles.text43,'Enable','on');
else
    set(handles.SRPDC_revealnames,'Enable','off');
    set(handles.custom_search_string,'Enable','off');
    set(handles.custom_search_string,'String',[]);
    set(handles.filelist_alldays,'Enable','off');
    set(handles.filelist_day1,'Enable','off');
    set(handles.filelist_day2,'Enable','off');
    set(handles.filelist_day3,'Enable','off');
    set(handles.filelist_day4,'Enable','off');
    set(handles.filelist_day5,'Enable','off');
    set(handles.applythresh_background,'Enable','off');
    set(handles.SRPDC_applythresh,'Enable','off');
    set(handles.text46,'Enable','off');
    set(handles.day1_thresh,'Enable','off');
    set(handles.SRPDC_removethresh,'Enable','off');
    set(handles.text43,'Enable','off');
    handles.custom_search=[];
end

if blinddata==1
    check_blind_vars=isfield(handles,'blindfilelist');
    check_stored_Proc=isfield(handles,'TempProcessed_blindfilelist');
    check_stored_Load=isfield(handles,'TempLoaded_blindfilelist');
    
    if check_blind_vars==0 && check_stored_Proc==0 && check_stored_Load==0
        set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
        listbox_groups=fieldnames(handles.MasterSRPData);
        delname1='GroupNames';
        delname2='SrpThresh';
        delname3='srpdays';
        delname4='AmpGain';
        delname5='grpcolors';
        listbox_groups(strcmp((delname1),listbox_groups)) = [];
        listbox_groups(strcmp((delname2),listbox_groups)) = [];
        listbox_groups(strcmp((delname3),listbox_groups)) = [];
        listbox_groups(strcmp((delname4),listbox_groups)) = [];
        listbox_groups(strcmp((delname5),listbox_groups)) = [];
        handles.groupnames_processedSRP=listbox_groups;
        [groupnum ~]=size(listbox_groups);
        for i = 1:groupnum
            handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
            groupfile_length=length(handles.groupfiles{i,:,:});
            if i == 1
                blindfilelist_tmp=handles.groupfiles{i,:,:};
                handles.grouplengths(i,1)=groupfile_length;
            else
                blindfilelist_tmp=[blindfilelist_tmp handles.groupfiles{i,:,:}];
                handles.grouplengths(i,1)=sum(handles.grouplengths)+groupfile_length;
            end
        end
        %Generate blind filelist
        if handles.currentdata_loaded==1
            totalfile_length=length(handles.blindfilelist);
            handles.randomizekey=randperm(totalfile_length);
            handles.randomizedfilenames=handles.blindfilelist(1,handles.randomizekey);
            for i = 1:totalfile_length
                handles.blindfilenames{i,1}=sprintf('Blinded File %s',num2str(i));
                handles.blindfilecolors(i,1:3)=[1 1 1];
            end
        elseif handles.currentdata_loaded==2
            handles.randomizekey=handles.saved_options.randomizekey;
            if isfield(handles.saved_options,'guiblindfilelist')
                handles.blindfilelist=handles.saved_options.guiblindfilelist;
            else
                handles.blindfilelist=handles.saved_options.blindfilelist;
            end
            handles.randomizedfilenames=handles.blindfilelist(1,handles.randomizekey);
            handles.blindfilenames=handles.saved_options.blindfilenames;
        end
        check_blindfilelist=isfield(handles,'blindfilelist');
        if check_blindfilelist==0
            handles.blindfilelist=blindfilelist_tmp;
        end
        handles.setblind=1;
        set(handles.SRPDC_filelist,'String',handles.blindfilenames);
    else
        if check_blind_vars==0
            if handles.currentdata_loaded==1
                check_stored=isfield(handles,'TempProcessed_blindfilelist');
                if check_stored==1
                    handles.blindfilelist=handles.TempProcessed_blindfilelist;
                    handles.randomizekey=handles.TempProcessed_randomizekey;
                    handles.blindfilenames=handles.TempProcessed_blindfilenames;
                    handles.randomizedfilenames=handles.TempProcessed_randomizedfilenames;
                end
            elseif handles.currentdata_loaded==2
                check_stored=isfield(handles,'TempLoaded_blindfilelist');
                if check_stored==1
                    handles.blindfilelist=handles.TempLoaded_blindfilelist;
                    handles.randomizekey=handles.TempLoaded_randomizekey;
                    handles.blindfilenames=handles.TempLoaded_blindfilenames;
                    handles.randomizedfilenames=handles.TempLoaded_randomizedfilenames;
                end
            end

        end
    end
    
    check_vars(1,1)=isfield(handles,'fileassociations');
    check_vars(1,2)=isfield(handles,'day1threshtracker');
    if check_vars(1,1)==0
        msgbox('Missing fileassociations variable');
    else
        if handles.currentdata_loaded==1
            handles.fileassociations=handles.TempProcessed_fileassociations;
        elseif handles.currentdata_loaded==2
            handles.fileassociations=handles.TempLoaded_fileassociations;
        end
    end
    if check_vars(1,2)==0
        msgbox('Missing day1threshtracker variable');
    else
        if handles.currentdata_loaded==1
            handles.day1threshtracker=handles.TempProcessed_day1threshtracker;
        elseif handles.currentdata_loaded==2
            handles.day1threshtracker=handles.TempLoaded_day1threshtracker;
        end
    end
    
    set(handles.SRPDC_filelist,'Value',1);
    set(handles.filelist_alldays,'Value',1);
    handles=updatefilelist(handles);
    if handles.setblind~=0
        showtruefilenames=get(handles.SRPDC_revealnames,'Value');
        if showtruefilenames==1
            set(handles.SRPDC_filelist,'String',handles.randomizedfilenames);
        else
            set(handles.SRPDC_filelist,'String',handles.blindfilenames);
        end
        set(handles.SRPDC_filelist,'Value',1);
        set(handles.SRPDC_grouplist,'String',handles.BlindGroup);
        set(handles.SRPDC_transfertxt,'Visible','on');
        set(handles.SRPDC_transferanimal,'Visible','on');
        set(handles.SRPDC_switchgroupinput,'Visible','on');
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(1,handles);
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        
    end
else
    set(handles.SRPDC_filelist,'Value',1);
    set(handles.filelist_alldays,'Value',1);
    handles=updatefilelist(handles);
        if handles.usefilelist~=0  
            for i = 1:length(handles.modified_fileindex)
                handles.blindfilenames{handles.modified_fileindex(1,i),1}=handles.modified_filelist{1,i};
            end
        else
            handles.blindfilenames=get(handles.SRPDC_filelist,'String');
        end
        set(handles.SRPDC_transfertxt,'Visible','on');
        set(handles.SRPDC_transferanimal,'Visible','on');
        set(handles.SRPDC_switchgroupinput,'Visible','on');
    if handles.currentdata_loaded ~=0
        set(handles.SRPDC_grouplist,'String',handles.groupnames_processedSRP);
        set(handles.SRPDC_filelist,'String',handles.groupfiles{1,:,:});
        set(handles.SRPDC_filelist,'Value',1);
    else
        uservalue=get(handles.SRPDC_useprocessed,'Value');
        if uservalue == 1
            set(handles.SRPDC_useloaded,'Enable','off');
            listbox_groups=fieldnames(handles.MasterSRPData);
            delname1='GroupNames';
            delname2='SrpThresh';
            listbox_groups(strcmp((delname1),listbox_groups)) = [];
            listbox_groups(strcmp((delname2),listbox_groups)) = [];
            set(handles.SRPDC_grouplist,'String',listbox_groups);
            
            handles.groupnames_processedSRP=listbox_groups;
            [groupnum ~]=size(listbox_groups);
            for i = 1:groupnum
                handles.groupfiles{i,:,:}=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{i,1}).groupfiles;
            end
            set(handles.SRPDC_filelist,'String',handles.groupfiles{1,:,:});
            set(handles.SRPDC_filelist,'Value',1); 
            handles.currentdata_loaded=1;
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
        end
    end

end
guidata(hObject,handles);

% --- Executes on button press in SRPDC_previousfile.
function SRPDC_previousfile_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_previousfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.currentdata_loaded >= 1
    handles=disableuserinput(handles);
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        filelistbox_location=get(handles.SRPDC_filelist,'Value');
        if filelistbox_location >= 2
            filelistbox_location=filelistbox_location-1;
            set(handles.SRPDC_filelist,'Value',filelistbox_location);
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);

            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);

            groupname=(handles.groupnames_processedSRP{truegroup,1});
            filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
        else
            %do nothing
        end
    else
        filelistbox_location=get(handles.SRPDC_filelist,'Value');
        
        if filelistbox_location >= 2
            filelistbox_location=filelistbox_location-1;
            set(handles.SRPDC_filelist,'Value',filelistbox_location);
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');

            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

            groupname=selectedgroup;
            filename=selectedfile;
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
        else
            %do nothing
        end
    end
    handles=enableuserinput(handles);
end
guidata(hObject,handles);

% --- Executes on button press in SRPDC_switchhemi.
function SRPDC_switchhemi_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_switchhemi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.currentdata_loaded >= 1
    if handles.usehemi==1 %if left hemisphere then switch to right
        set(handles.Left_Hemi,'Value',0);
        set(handles.Right_Hemi,'Value',1);
        handles.usehemi=2;
        blinddata=get(handles.SRPDC_blind_data,'Value');
        if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);

            groupname=(handles.groupnames_processedSRP{truegroup,1});
            filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');

            groupname=selectedgroup;
            filename=selectedfile;
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
        end

    else %if right hemisphere switch to left
      set(handles.Left_Hemi,'Value',1);
      set(handles.Right_Hemi,'Value',0);
      handles.usehemi=1;
          blinddata=get(handles.SRPDC_blind_data,'Value');
        if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);

            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
            groupname=(handles.groupnames_processedSRP{truegroup,1});
            filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');


            groupname=selectedgroup;
            filename=selectedfile;
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
                handles=session_boxes(1,groupname,filename,handles);
            else
                handles=session_boxes(0,groupname,filename,handles);
            end
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
        end
    end
end
guidata(hObject,handles);

% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if handles.currentdata_loaded >= 1
    switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
        case 'Left_Hemi'
            handles.usehemi=1;
        case 'Right_Hemi'
            handles.usehemi=2;
    end

    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        selectedfile=get_correct_filenum(handles);
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);

        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        groupname=(handles.groupnames_processedSRP{truegroup,1});
        filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
        if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
            handles=session_boxes(1,groupname,filename,handles);
        else
            handles=session_boxes(0,groupname,filename,handles);
        end
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    else
        selectedfile=get_correct_filenum(handles);
        selectedgroup = get(handles.SRPDC_grouplist,'Value');

        groupname=(handles.groupnames_processedSRP{selectedgroup,1});
        filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
        filename=(filename{1,1}(1,1:end-4));
        if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
            handles=session_boxes(1,groupname,filename,handles);
        else
            handles=session_boxes(0,groupname,filename,handles);
        end
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
    end
end
guidata(hObject, handles);

% --- Executes on button press in SRPDC_revealnames.
function SRPDC_revealnames_Callback(hObject, eventdata, handles)
    % hObject    handle to SRPDC_revealnames (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of SRPDC_revealname
check_processed=get(handles.SRPDC_useprocessed,'Value');
check_loaded=get(handles.SRPDC_useloaded,'Value');
check_blind=get(handles.SRPDC_blind_data,'Value');
if check_processed == 0 && check_loaded == 0 || check_blind == 0
    set(hObject,'Value',0);
    return;
end
    blinddata=get(handles.SRPDC_blind_data,'Value');

  
    
    if blinddata==1
        if handles.setblind==0
            %do nothing
        else
            handles=updatefilelist(handles);
            guidata(hObject,handles);
        end
    else
        handles=updatefilelist(handles);
    end
        

function [handles]=sessionplot(groupvalue,selected_filename,handles,hObject,session_remove,remove_toggle,user_input,amp_loc,unused)
%Sessionplot is the main function that handles updating the plots on the
%GUI and also handles the variables that keep track of which files are
%modified through the vetting process.

%groupvalue is an integer value 1->groupnum which indicates which group the
%animal that is about to be plotted belongs to.

%selected_filename indicates the specific animal (file) that is about to be
%plotted

%handles gives the function access to all the GUI data (necessary for
%plotting).

%hObject (unused at the moment)

%session_remove indicates which session to remove or re-add when the user
%checks or unchecks sessions through the vetting process.  If this value is
%equal to 0 then this function will simply plot the current data with no
%modifications.

%remove_toggle indicates whether the session will be removed or re-added.
%true=remove
%false=re-add

%The variable plot_dayavgData is kept in memory until a new file is plotted
%for other purposes in the program.  If it exists, we need to clear it so
%that it can be regenerated for the new plot.
if isfield(handles,'plot_dayavgData');
    handles = rmfield(handles,'plot_dayavgData');
end

%The variable plot_sessionData is kept in memory until a new file is plotted
%for other purposes in the program.  If it exists, we need to clear it so
%that it can be regenerated for the new plot.
if isfield(handles,'plot_sessionData');
    handles = rmfield(handles,'plot_sessionData');
end

%If the program is functioning in "blind-mode" the selected_filename
%variable will actually be a number (otherwise it is an actual filename).
%This is the code that takes that number and converts it to the appropriate
%filename.

    %Determine if program is in blind-mode
    usingblind=get(handles.SRPDC_blind_data,'Value');
    if usingblind==1
        %The variable selected_filename needs to be a string... in blind
        %mode it will exist is a numerical matrix.  Here we store the value
        %and clear it.
        filename_loc=selected_filename;
        clear selected_filename
        %With the numerical matrix "selected_filename" cleared, we will
        %generate a new string matrix.
        selected_filename=handles.groupfiles{groupvalue,1}(1,filename_loc);
        %Now that selected_filename has been correctly generated as a
        %string the rest of the function will be able to use it
        %appropriately.
    end
    if sum(handles.day1threshtracker(filename_loc,:))==1
        if handles.day1threshtracker(filename_loc,1)==1
            handles.usehemi=1;
            set(handles.Left_Hemi,'Value',1);
            set(handles.Left_Hemi,'Visible','on');
            set(handles.Right_Hemi,'Visible','off');
            set(handles.SRPDC_switchhemi,'Visible','off');
        else
            handles.usehemi=2;
            set(handles.Right_Hemi,'Value',1);
            set(handles.Right_Hemi,'Visible','on');
            set(handles.Left_Hemi,'Visible','off');
            set(handles.SRPDC_switchhemi,'Visible','off');
        end
    
        
    else
        set(handles.Left_Hemi,'Visible','on');
        set(handles.Right_Hemi,'Visible','on');
        set(handles.SRPDC_switchhemi,'Visible','on');
    end
        %Check if the user has specified they would like to set their own
        %y-axis limitations.
        checklimit_upper=get(handles.SRPDC_upper_ylim,'Backgroundcolor');
        checklimit_lower=get(handles.SRPDC_lower_ylim,'Backgroundcolor');
        %The program currently changes the background color of the input
        %text box to indicate to the user whether or not their input is
        %valud.  This background color is also used here to determine
        %whether their input was valid.
        if checklimit_upper(1,1)==0 && checklimit_upper(1,2) == 1 && checklimit_upper(1,3) == 0 && checklimit_lower(1,1)==0 && checklimit_lower(1,2) == 1 && checklimit_lower(1,3) == 0
            %handles.ylim is used later in the program to set the axis
            %values.
            handles.ylim=true;
        end
        
        %Check to see if file contains a novel event (AKA eventnum = 2)
        EventNumber=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).EventNum;
        if EventNumber == 1
            set(handles.SRPDC_shownovel,'Enable','off');
            set(handles.SRPDC_shownovel,'Value',0);
        else
            set(handles.SRPDC_shownovel,'Enable','on');
        end
        CheckNovel=get(handles.SRPDC_shownovel,'Value');
        
        %Previously in the program, the user defined if they would like to
        %use the left or right hemispehre.
        %handles.usehemi == 2 means they have selected the Right hemisphere.
        %handles.usehemi == 1 means they have selected the Left hemisphere.
        if handles.usehemi==2
            %If the right hemisphere is selected, extract the session flip
            %and flop name codes... For example... E1R and E2R
            if CheckNovel~=1
                extractsession_flip=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{2,1});
                extractsession_flop=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{4,1});
            else
                %Novel event codes are hardcoded.  I need to correct this
                %in the future.  See notebook page 39.
                extractsession_flip='E3R';
                extractsession_flop='E4R';
            end
        elseif handles.usehemi==1
            %If the left hemisphere is selected, extract the session flip
            %and flop name codes... For example... E1L and E2L
            if CheckNovel~=1
                extractsession_flip=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{1,1});  
                extractsession_flop=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{3,1});  
            else
                %Novel event codes are hardcoded.  I need to correct this
                %in the future.  See notebook page 39.
                extractsession_flip='E3L';
                extractsession_flop='E4L';
            end
        end
        %Extract necessary information (number of sessions, number of
        %trials, size of extracted window) from the structure of the event
        %data variable.
    [session_num trials_num windowsize] = size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip));
    %set handle variables for later use to these values.
    handles.windowsize=windowsize;
    handles.sessionnum=session_num;
    handles.trialnum=trials_num;
    
    %The following code is the logic that handles which sessions were
    %removed from which files in each hemisphere.  If the file is not
    %modified, then it will not generate a "tracking variable".  This
    %"tracking variable" is called cleaned_sessions.
    
    
    %First we determine if this file has been previously modified.  We do
    %this by checking if the selected file has a variable in its data
    %structure called cleaned_sessions.  If this variable exists then the
    %file has been previously modified.  If it does not exist, we must
    %generate it.  Novel files are handled separately.
    if CheckNovel~=1
        if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)),'cleaned_sessions')==0
            %In this instance, cleaned_sessions does not exist (it is not a
            %field of the filename structure).  We must generate it for this
            %file and set the default values appropriately.

            %clean_row is a variable that is used in the basic structure of
            %cleaned_sessions and is always equal to 3.
            %Row 1 = General Information (for debugging)
            %Row 2 = Left Hemisphere Information
            %Row 3 = Right Hemisphere Information
            for clean_row=1:3
               %session_num is the total number of sessions in this file.
               %Since the first column is for filename information and
               %debugging, there need to be session_num+1 columns.
               for clean_column=1:(session_num+1)
                   %The first row in the cleaned_sessions data structure is
                   %reserved for information and debugging.
                   if clean_row==1 %title row
                       if clean_column==1
                           %The first column in the first row is always the
                           %filename.  This is for debugging purposes and is
                           %the same for all cleaned_sessions variables.
                           handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}=(selected_filename{1,1}(1,1:end-4));
                       else
                           %This other columns on the first row are for
                           %information and debugging purposes and indicate
                           %which column represents which session.  This is the
                           %same format for all cleaned_session variables.
                           handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}=sprintf('Session%s',num2str(clean_column-1));
                       end

                   %The second row of all cleaned_session variables is reserved
                   %for left hemisphere tracking information.
                   elseif clean_row==2 %left hemisphere row
                       if clean_column==1 %row title
                           %The first column in the second row is always an
                           %indicator of which hemisphere information this row
                           %contains.  For row #2, this is Left Hemisphere
                           %information.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}='LH'; 
                       else
                           %Since we are creating a new cleaned_sessions
                           %variable, all sessions will have a default value of
                           %"1" which indicates that this session is "in-use"
                           %by the program and has not been removed by the
                           %user.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}=1;
                       end

                   %The second row of all cleaned_session variables is reserved
                   %for right hemisphere tracking information.
                   elseif clean_row==3 %right hemisphere row
                       if clean_column==1 %row title
                          %The first column in the third row is always an
                          %indicator of which hemisphere information this row
                          %contains.  For row #3, this is Right Hemisphere
                          %information.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}='RH'; 
                       else
                          %Since we are creating a new cleaned_sessions
                          %variable, all sessions will have a default value of
                          %"1" which indicates that this session is "in-use" by
                          %the program and has not been removed by the user.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions{clean_row,clean_column}=1;
                       end  
                   end
               end
            end
        end
    else
         if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)),'cleaned_sessions_novel')==0
            %In this instance, cleaned_sessions_novel does not exist (it is not a
            %field of the filename structure).  We must generate it for this
            %file and set the default values appropriately.

            %clean_row is a variable that is used in the basic structure of
            %cleaned_sessions_novel and is always equal to 3.
            %Row 1 = General Information (for debugging)
            %Row 2 = Left Hemisphere Information
            %Row 3 = Right Hemisphere Information
            for clean_row=1:3
               %session_num is the total number of sessions in this file.
               %Since the first column is for filename information and
               %debugging, there need to be session_num+1 columns.
               for clean_column=1:(session_num+1)
                   %The first row in the cleaned_sessions_novel data structure is
                   %reserved for information and debugging.
                   if clean_row==1 %title row
                       if clean_column==1
                           %The first column in the first row is always the
                           %filename.  This is for debugging purposes and is
                           %the same for all cleaned_sessions_novel variables.
                           handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}=(selected_filename{1,1}(1,1:end-4));
                       else
                           %This other columns on the first row are for
                           %information and debugging purposes and indicate
                           %which column represents which session.  This is the
                           %same format for all cleaned_session variables.
                           handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}=sprintf('Session%s',num2str(clean_column-1));
                       end

                   %The second row of all cleaned_session variables is reserved
                   %for left hemisphere tracking information.
                   elseif clean_row==2 %left hemisphere row
                       if clean_column==1 %row title
                           %The first column in the second row is always an
                           %indicator of which hemisphere information this row
                           %contains.  For row #2, this is Left Hemisphere
                           %information.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}='LH'; 
                       else
                           %Since we are creating a new cleaned_sessions_novel
                           %variable, all sessions will have a default value of
                           %"1" which indicates that this session is "in-use"
                           %by the program and has not been removed by the
                           %user.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}=1;
                       end

                   %The second row of all cleaned_session variables is reserved
                   %for right hemisphere tracking information.
                   elseif clean_row==3 %right hemisphere row
                       if clean_column==1 %row title
                          %The first column in the third row is always an
                          %indicator of which hemisphere information this row
                          %contains.  For row #3, this is Right Hemisphere
                          %information.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}='RH'; 
                       else
                          %Since we are creating a new cleaned_sessions_novel
                          %variable, all sessions will have a default value of
                          %"1" which indicates that this session is "in-use" by
                          %the program and has not been removed by the user.
                          handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).cleaned_sessions_novel{clean_row,clean_column}=1;
                       end  
                   end
               end
            end
        end
    end
    %END CLEAN_SESSIONS GENERATION CODE
    
    
    %The following code handles session removal.  When the user removes a
    %session, no data is actually modified.  The only thing that changes is
    %the corresponding information in cleaned_sessions is changed from 1 to
    %0.  This process is handled by the modify_session() function.
    if session_remove ~= 0
        %If session_remove is a value other than 0, the user has indicated
        %they would like to either remove or re-add a session to the plot.
        %This information is sent to the modify_session() function which
        %then returns the correctly modified handles.
        if remove_toggle==true
            handles=modify_session([0],[session_remove,0],handles.usehemi,(selected_filename{1,1}(1,1:end-4)),(handles.groupnames_processedSRP{groupvalue,1}),handles);
        else
            handles=modify_session([0],[session_remove,1],handles.usehemi,(selected_filename{1,1}(1,1:end-4)),(handles.groupnames_processedSRP{groupvalue,1}),handles);
        end
    end
    
    %The first plot that will actually be modified is the left-side plot
    %which is named "plot_sessions".  This plot is specifically reserved
    %for plotting average session data.
    
    %We specify which axis we would like to modify.
    axes(handles.plot_sessions);
    %This axis is cleared before being re-created.
    cla reset;
    %We always will overlay sessions (which already have color values
    %stored) so we use the "hold on" command.
    hold on
    
    %Previously, the user would have specified if they would like the flips
    %and flops to be merged or separated.  The x-axis of the plot will
    %change depending on this option which is handled here.
    if handles.separateflipflops==0
        %The flip/flops are not separated, so the plot size is equal to the
        %window size.  Here we pre-allocate memory for this information.
        plot_matrix=nan(session_num,windowsize);
        %Since the flip/flops are being merged together (aka NOT
        %separated), we will need to double the number of trials for
        %averaging purposes later in the code.
        modifiedtrials=trials_num*2;
    else
        %The flip/flops ARE separated, so the plot size is equal to double
        %the windowsize.  The average flip window is followed by the
        %average flop window (therefore 2 times a single windowsize).
        plot_matrix=nan(session_num,windowsize*2);
        
        %Since the flip/flops are NOT being merged (AKA they are
        %separated), then the number of trials used in averaging is the
        %same.
        modifiedtrials=trials_num;
          
    end
    
    %Further Clarification Example (one session with a window size of 5 and 3 trials):
    %Extracted Flip Window...
    % -----
    % -----
    % -----
    %Extracted Flop Window...
    % +++++
    % +++++
    % +++++
    
    %If handles.separateflipflops == 0 then the structure will be
    %(double trial number, same windowsize)
    % -----
    % -----
    % -----
    % +++++
    % +++++
    % +++++
    %If handles.separateflipflops == 1 then the structure will be
    %(double windowsize, same trial number)
    % -----+++++
    % -----+++++
    % -----+++++
    
    
    
    %Now that we have pre-allocated variables for the plot_matrix, we will
    %extract the actual raw-data from the file.
    
    %So that our extracted data will easily fit into the plot_matrix
    %variable, we will extract the data differently depending on
    %whether or not we are separating or not separating our flips and
    %flops.
    if handles.separateflipflops==0
        %We will merge flips and flops here...
        %flipflop_data=[flips flops];
        flipflop_data=[handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip) handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flop)];
    else
        %We will keep flips and flops separate here...
        %First, pre-allocate matrix before extracting.
        flipflop_data=nan(session_num,trials_num,(windowsize*2));
       for session = 1:session_num
          for trial = 1:modifiedtrials
             %For each sesson, extract the flip and flop for each trial
             %and append them to eachother.
             
             %EXAMPLE (variable names have been changed to be more informative):
             %flipflop_data(session#1,trial#1,1:windowsizeFLIP)=FLIPDATA(session#1,trial#1,datapoints)
             %remember, windowsizeFLIP=windowsizeFLOP (this is internal
             %program setting and is always true).
             %flipflop_data(session#1,trial#1,(windowsizeFLIP+1):(windowsizeFLIP*2)=FLOPDATA(session#1,trial#1,datapoints)
             
             flipflop_data(session,trial,1:windowsize)= handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip)(session,trial,:);
             flipflop_data(session,trial,(windowsize+1):(windowsize*2))= handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flop)(session,trial,:);
          end
       end
    end
    
    
    %This is the code that actually references the cleaned_data variable
    %to scrub the data from the temporary data variable "flipflop_data"
    for session = 1:session_num
        %Each session is checked to see if the user has remove it.  This
        %check is handled by the get_session variable which checks
        %cleaned_data and returns a 1 if this session is "in-use" and a 0
        %if this sesson has been removed.
        sessioncheck=get_session(handles.usehemi,session,(selected_filename{1,1}(1,1:end-4)),(handles.groupnames_processedSRP{groupvalue,1}),handles);
        
        if sessioncheck==1 %Session is "in-use"
            if handles.separateflipflops==0
                %Determine the average values of this session and store in
                %the plot_matrix variable.
                for window_datapoint = 1:windowsize
                    %For each datapoint, average across all trials.  Ignore
                    %NAN-Trials (trials that the user has determined were
                    %artifacts previously)
                    plot_matrix(session,window_datapoint)=nanmean(flipflop_data(session,:,window_datapoint));
                end
            else
                %Same as above, but for when flips and flops have been keep
                %separate (scroll up to see further clarification example above)
                for window_datapoint = 1:(windowsize*2)
                    plot_matrix(session,window_datapoint)=nanmean(flipflop_data(session,:,window_datapoint));
                end                
            end
        else %Session needs to be removed
            if handles.separateflipflops==0
                %fill plotmatrix with nan-values for this session
                %(scroll up to see further clarification example for
                %windowsize explanation).
                plot_matrix(session,1:windowsize)=nan(1,windowsize);
            else
                %fill plot_matrix with nan-values for this session
                %(scroll up to see further clarification example for
                %windowsize*2 explanation).
                plot_matrix(session,1:(windowsize*2))=nan(1,(windowsize*2));
            end
        end
        
        %For each session, after plot_matrix(session,:) has been either
        %populated with data or scrubbed with nan-values, plot this data to
        %the axis using the user-defined colors stored in
        %handles.sessioncolors.  NOTE: nan-values will not appear, so this
        %code works for nan-scrubbed sessions also.
            plot(plot_matrix(session,:),'Color',handles.sessioncolors(session,:));
            if session==session_num
                %after plot_matrix has been completely generated, store the
                %data for later use in the program in
                %handles.plot_sessionData.
                handles.plot_sessionData=plot_matrix;
            end
    end
    
    
    %Earlier in this function, it was determined if the user had specified
    %custom y-axis values.  In the following code, we extract this
    %information and apply the custom y-axis limits to the plot.
    if handles.ylim==true
        %get upper y-axis limit.
        ylim_upper=str2num(get(handles.SRPDC_upper_ylim,'String'));
        %get lower y-axis limit.
        ylim_lower=str2num(get(handles.SRPDC_lower_ylim,'String'));
        %apply y-axis limits to plot
        ylim([ylim_lower ylim_upper]);
        
        %Whenever the user has separated the flips and the flops, a
        %vertical red dashed line is added to the plot to indicate where
        %the flip data stops and the flop data starts.  If the user has
        %specified custom y-axis limits, the line will not scale correctly
        %to the plot size.  The following code scales this red line to the
        %user specified y-axis.
        if handles.separateflipflops==1
            plot([windowsize windowsize],[ylim_lower ylim_upper],'--','Color','red','LineWidth',2);
        end
    else
        %The user has not specified a custom y-axis limit.
        if handles.separateflipflops==1
            %Since the user has not specified custom y-axis limits, but HAS
            %indicated they have separated the flips and flops we need to
            %generate a vertical red dashed line to indicate when the flip
            %data stops and the flop data starts.
            
            %First we determine the current y-axis limits.
            ylims=ylim;
            %Next we plot the vertical red dashed line properly scaled for
            %the current y-axis limits.
            plot([windowsize windowsize],[ylims(1,1) ylims(1,2)],'--','Color','red','LineWidth',2);
        end
    end
    
    %Set the plot title string to Sessions now that this plot has been
    %populated with data.
    set(handles.plot1_txt,'String','Sessions');

    
    %We will now handle the second plot which can be either the day average
    %plot or the session inspector plots.  First, we will switch over to
    %this axis (named plot_dayavg) and clear this axis of current data.
    axes(handles.plot_dayavg);
    cla reset;
    
    %Previously, the user would have specified if they would like the flips
    %and flops to be merged or separated.  The x-axis of the plot will
    %change depending on this option which is handled here.
    if handles.separateflipflops==0
        %Since the flip/flops are being merged together (aka NOT
        %separated), we will need to double the number of trials for
        %averaging purposes later in the code.
        totaltrials=trials_num*2*session_num;
        %The flip/flops are not separated, so the plot size is equal to the
        %window size.  Here we pre-allocate memory for this information.
        plot_merged=nan(1,totaltrials,windowsize);
    else
        %Since the flip/flops are NOT being merged (AKA they are
        %separated), then the number of trials used in averaging is the
        %same.
        totaltrials=trials_num*session_num;
        %The flip/flops ARE separated, so the plot size is equal to double
        %the windowsize.  The average flip window is followed by the
        %average flop window (therefore 2 times a single windowsize).
        plot_merged=nan(1,totaltrials,windowsize*2);
    end

    
    
    %The following code populates the plot_merged variable with data.
    
    %To calculate the day average, all trials from every session are
    %combined into the variable "plot_merged" since the variable "trial"
    %will start back at 1 for every new session, the variable
    %"trialtracker" is introdued which increments without ever going back
    %to 1.
    trialtracker=1;
    for session=1:session_num %scan through each session
        %for each session, check to see if the user has disabled it.
        sessioncheck=get_session(handles.usehemi,session,(selected_filename{1,1}(1,1:end-4)),(handles.groupnames_processedSRP{groupvalue,1}),handles);
        %scan through each trial for each session
           for trial=1:modifiedtrials 
               %if the session is "in-use" then add the trial data for that session to plot_merged.
                if sessioncheck==1 
                    plot_merged(1,trialtracker,:)=flipflop_data(session,trial,:);
                    trialtracker=trialtracker+1;
                else
                    %if the session has been removed by the user, fill with
                    %nan-values. (scroll up to see further clarification example for
                    %windowsize explanation).
                    if handles.separateflipflops==0
                        plot_merged(1,trialtracker,:)=nan(1,windowsize);
                        trialtracker=trialtracker+1;
                    else
                        plot_merged(1,trialtracker,:)=nan(1,windowsize*2);
                        trialtracker=trialtracker+1;
                    end
                end

           end
    end

    %At this point we have the variable plot_merged that contains all the
    %trial information for every session.  We want to collapse this into a
    %single vector that represents the average of all trials.
    
    %First, we will pre-allocate the final variable "plot_merged_final"
    %which will contain the single vector just mentioned. (scroll up to see 
    %further clarification example for windowsize explanation)
    if handles.separateflipflops==0
        plot_merged_final=nan(1,windowsize);
    else
        plot_merged_final=nan(1,(windowsize*2));
    end
    
    
    %The following code populates the "plot_merged_final" variable. 
    %(scroll up to see further clarification example for windowsize 
    %explanation).   
    if handles.separateflipflops==0
        for window_datapoint=1:windowsize
            plot_merged_final(1,window_datapoint)=nanmean(plot_merged(1,:,window_datapoint));
        end
    else
        for window_datapoint=1:(windowsize*2)
            plot_merged_final(1,window_datapoint)=nanmean(plot_merged(1,:,window_datapoint));
        end
    end

    %At this point we have generated the "plot_merged_final" variable which
    %represents the average waveform for the file about to be plotted
    %across all days.
    
    %We also still have the flipflop_data which can be used to plot all
    %trials for a specific session if the user has activated the session
    %inspector.
    
    %In the following code, we determine if the user wants to plot the
    %session inspector data or the day average data.
    checksessionplot=get(handles.sessioninspector,'Value');
    %0 = plot day average
    %1 = plot session inspector data
    if checksessionplot==0
        hold on
        %Before plotting the data, check if the user has enabled the data
        %smoothing options.
        if handles.usesmoothing==1
            %use simple matlab smoothing function for now... we can add
            %more complex smoothing options later.  Specific smoothing
            %information is stored in the handles.smoothingwindow variable
            %that is determined by the user.
            plot_merged_final=smooth(plot_merged_final,handles.smoothingwindow);
            %For my own personal taste, I prefer to have a horizontal
            %vector before plotting.
            plot_merged_final=plot_merged_final';
        end
        %Day average plots are always black.
        plot(plot_merged_final,'Color','black','LineWidth',1);
        %Since the day average plot data has been completely generated at
        %this point, we will store the information into memory so we can
        %use it later in other parts of the GUI.
        handles.plot_dayavgData=plot_merged_final;
    else
        %The user has indicated they have enabled the session inspector
        %option.  Since there are no specific trial colors, we will use
        %"hold all" which auto-assigns colors to each plot.
        hold all
        %We determine the specific session the user would like to view.
        selectedsession=handles.selectedsession;
        %Next we extract all the trials for that specific session and input
        %it into a variable which can easily be plotted.
        flipflop_data2D(:,:)=flipflop_data(selectedsession,:,:);
        %Since we want each row to represent a single trial, we must
        %correct the data format before plotting.
        flipflop_data2D=flipflop_data2D';
        
        plot(flipflop_data2D)
        
        %Now that the flipflop_data2D has been completely generated, we
        %will store it in the plot_dayavgData variable.  This variable
        %should be renamed later to reflect it can contain the dayavgData
        %OR the session inspector data.
        handles.plot_dayavgData=flipflop_data2D;
                
    end
        
    
    %Earlier in this function, it was determined if the user had specified
    %custom y-axis values.  In the following code, we extract this
    %information and apply the custom y-axis limits to the plot.
    if handles.ylim==true
        %get upper y-axis limit.
        ylim_upper=str2num(get(handles.SRPDC_upper_ylim,'String'));
        %get lower y-axis limit.
        ylim_lower=str2num(get(handles.SRPDC_lower_ylim,'String'));
        %apply y-axis limits to plot
        ylim([ylim_lower ylim_upper]);
        
        %Whenever the user has separated the flips and the flops, a
        %vertical red dashed line is added to the plot to indicate where
        %the flip data stops and the flop data starts.  If the user has
        %specified custom y-axis limits, the line will not scale correctly
        %to the plot size.  The following code scales this red line to the
        %user specified y-axis.
        if handles.separateflipflops==1
            plot([windowsize windowsize],[ylim_lower ylim_upper],'--','Color','red','LineWidth',2);
            if checksessionplot == 1
                %If the user has enabled the session inspector, we need to
                %check if they have also specified artifact removal
                %thresholds.  If they have, then we need to plot them.
                [x_size,~]=size(handles.plot_dayavgData);
                upperthresh=get(handles.SRPDC_pos_artifact_thresh,'String');
                lowerthresh=get(handles.SRPDC_neg_artifact_thresh,'String');
                upperthresh_num=str2num(upperthresh);
                lowerthresh_num=str2num(lowerthresh);
                axes(handles.plot_dayavg);
                hold on
                if isempty(upperthresh_num)==0
                    plot([1 x_size],[upperthresh_num upperthresh_num],'--','Color','black','LineWidth',2)
                end
                if isempty(lowerthresh_num)==0
                    plot([1 x_size],[lowerthresh_num lowerthresh_num],'--','Color','black','LineWidth',2)
                end
            end
        end
    else
        %The user has not specified a custom y-axis limit.
        if handles.separateflipflops==1
            %Since the user has not specified custom y-axis limits, but HAS
            %indicated they have separated the flips and flops we need to
            %generate a vertical red dashed line to indicate when the flip
            %data stops and the flop data starts.
            
            %First we determine the current y-axis limits.
            ylims=ylim;
            
            %Next we plot the vertical red dashed line properly scaled for
            %the current y-axis limits.
            plot([windowsize windowsize],[ylims(1,1) ylims(1,2)],'--','Color','red','LineWidth',2);
            if checksessionplot==1
                %If the user has enabled the session inspector, we need to
                %check if they have also specified artifact removal
                %thresholds.  If they have, then we need to plot them.
                [x_size,~]=size(handles.plot_dayavgData);
                upperthresh=get(handles.SRPDC_pos_artifact_thresh,'String');
                lowerthresh=get(handles.SRPDC_neg_artifact_thresh,'String');
                upperthresh_num=str2num(upperthresh);
                lowerthresh_num=str2num(lowerthresh);
                axes(handles.plot_dayavg);
                hold on
                if isempty(upperthresh_num)==0
                    plot([1 x_size],[upperthresh_num upperthresh_num],'--','Color','black','LineWidth',2)
                end
                if isempty(lowerthresh_num)==0
                    plot([1 x_size],[lowerthresh_num lowerthresh_num],'--','Color','black','LineWidth',2)
                end
            end
        end
    end
    
    %Now that the plot has been drawn, we will title the plot depending on
    %whether the session inspector is enabled.
    if checksessionplot==0
        set(handles.plot2_txt,'String','Day Average');
    else
        set(handles.plot2_txt,'String','Session Inspector');
    end
    
    %If the user is looking at a day average plot (not a session inspector
    %plot), then we will identify peak amplitudes and show their values to
    %the user.
    if checksessionplot==0
        %If the user has merged flip/flops together, we only need to
        %identify a single negative peak and a single positive peak.
        if handles.separateflipflops==0
            [minval,minloc,maxval,truemaxloc,amplitude]=ident_amplitude(plot_merged_final,0,0,0,0);
            handles.maxloc=truemaxloc;
            handles.minloc=minloc;
            set(handles.amp_slider_topright, 'value', truemaxloc);
            set(handles.amp_slider_bottomright, 'value', minloc);
            hold on
            %specifiy min peak with blue +
            plot(minloc,minval,'+','Color','blue');
            %specify max peak with red +
            plot(truemaxloc,maxval,'+','Color','red');
            %Output amplitude information to user.
            amplitudetxt=sprintf('Amplitude: %s microVolts',num2str(amplitude));
            set(handles.SRPDC_amplitude_txt,'String',amplitudetxt);
            time_neg=minloc/1000;
            time_pos=truemaxloc/1000;
            postimetxt=sprintf('Stim-To-Pos: %s ms',num2str(time_pos));
            set(handles.postime,'String',postimetxt);
            negtimetxt=sprintf('Stim-To-Neg: %s ms',num2str(time_neg));
            set(handles.negtime,'String',negtimetxt);            
        else
            %Since the user has separated flip/flops, we need to identify
            %two negative peaks and two positive peaks. (see above for
            %review of code since it's pretty much the same as above).  The
            %difference is that it's searching for one peak-pair in the
            %flip region and another peak-pair in the flop region.
            [minval1,minloc1]=min(plot_merged_final(1,1:100));
            [maxval1,maxloc1]=max(plot_merged_final(1,minloc1:250));
            truemaxloc1=maxloc1+minloc1-1;
            hold on
            plot(minloc1,minval1,'+','Color','blue');
            plot(truemaxloc1,maxval1,'+','Color','red');
            amplitude1=maxval1-minval1;
            amplitude1=amplitude1*1000;
            amplitudetxt1=sprintf('Amp Flip: %s microVolts',num2str(amplitude1));
            set(handles.SRPDC_amplitudeflip_txt,'String',amplitudetxt1);


            [minval2,minloc2]=min(plot_merged_final(1,496:596));
             minloc2=minloc2+windowsize;
            [maxval2,maxloc2]=max(plot_merged_final(1,minloc2:745));

            truemaxloc2=maxloc2+minloc2-1;
            hold on
            plot(minloc2,minval2,'+','Color','blue');
            plot(truemaxloc2,maxval2,'+','Color','red');
            amplitude2=maxval2-minval2;
            amplitude2=amplitude2*1000;
            amplitudetxt2=sprintf('Amp Flop: %s microVolts',num2str(amplitude2));
            set(handles.SRPDC_amplitudeflop_txt,'String',amplitudetxt2);
        end
    end
    %colorlocation is not currently used.
    colorlocation=get_correct_filenum(handles);
    %blindfilecolors is not currently used.
    handles.blindfilecolors(colorlocation,1:3)=[0 1 0];
    guidata(hObject,handles);

function checkinputdouble(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String','Not Set'); 
            set(hObject,'Backgroundcolor','r');
            handles.ylim=false;
        else
            handles.error=handles.error-1;
            set(hObject,'Backgroundcolor','g');
            handles.ylim=true;
        end
    else
        
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                handles.ylim=false;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String','Not Set'); 
                set(hObject,'Backgroundcolor','r');
            else
                set(hObject,'Backgroundcolor','g');
                handles.ylim=true;
            end

    end
guidata(hObject, handles);


function checkinputdouble_movingaverage(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String','Not Set'); 
            set(hObject,'Backgroundcolor','r');
        elseif number < 0
            msgbox('Input needs to be a number','Error')
            set(hObject,'String','Not Set'); 
            set(hObject,'Backgroundcolor','r');  
        else
            handles.error=handles.error-1;
            set(hObject,'Backgroundcolor','g');
            handles.smoothingwindow=number;
        end
    else
        
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                handles.ylim=false;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String','Not Set'); 
                set(hObject,'Backgroundcolor','r');
            else
                set(hObject,'Backgroundcolor','g');
                handles.smoothingwindow=number;
            end

    end
guidata(hObject, handles);


function checkinputdouble_artifacts(hObject, userinput, handles)
    number=str2num(userinput);
    checknumber=isempty(number);
    if checknumber==1
        set(hObject,'String','Not Set'); 
        set(hObject,'Backgroundcolor',[1 1 1]);
    else
        set(hObject,'Backgroundcolor','g');
    end
        blinddata=get(handles.SRPDC_blind_data,'Value');
        if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
        end
        [x_size,~]=size(handles.plot_dayavgData);
        upperthresh=get(handles.SRPDC_pos_artifact_thresh,'String');
        lowerthresh=get(handles.SRPDC_neg_artifact_thresh,'String');
        upperthresh_num=str2num(upperthresh);
        lowerthresh_num=str2num(lowerthresh);
        axes(handles.plot_dayavg);
        hold on
        if isempty(upperthresh_num)==0
            plot([1 x_size],[upperthresh_num upperthresh_num],'--','Color','black','LineWidth',2)
        end
        if isempty(lowerthresh_num)==0
            plot([1 x_size],[lowerthresh_num lowerthresh_num],'--','Color','black','LineWidth',2)
        end
        
  
    guidata(hObject, handles);

function refresh_sessionboxes(already_generated,session_number,selectedgroup,selectedfile,handles)
% SRP_Options_working=getappdata(0,'SRP_options');
% totalsessions = str2num(SRP_Options_working{10,2});
% if already_generated == 1
%     for session_check=1:5
%         if session_check <= totalsessions
%             sessionname=sprintf('handles.SRPDC_session%s',num2str(session_check));
%             set((sessionname),'Value',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)).cleaned_sessions(1,session_check));
%         end
%         set(handles.SRPDC_session2,'Value',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)).cleaned_sessions(1,2));
%         set(handles.SRPDC_session3,'Value',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)).cleaned_sessions(1,3));
%         set(handles.SRPDC_session4,'Value',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)).cleaned_sessions(1,4));
%         set(handles.SRPDC_session5,'Value',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)).cleaned_sessions(1,5));
%     end

function [truefilelocation,truegroupnum]=blindfunction_findfilenameinfo(selectedfilevalue, handles)
    blindfilelist_location=handles.randomizekey(1,selectedfilevalue);
    totalgroups=length(handles.grouplengths);
    info_discovered=0;
    for groupcheck=1:totalgroups
        if blindfilelist_location <= handles.grouplengths(groupcheck,1) && info_discovered==0
            if groupcheck == 1
                group_offset_correction=0;
            else
                group_offset_correction=handles.grouplengths(groupcheck-1,1);
            end
           truefilelocation=blindfilelist_location-group_offset_correction;
           truegroupnum=groupcheck;
           info_discovered=1;
        end
    end
    
    % --- Executes on button press in sessioninspect_1.
function sessioninspect_1_Callback(hObject, eventdata, handles)
% hObject    handle to sessioninspect_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=1;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
        set(handles.session_indicator1,'BackgroundColor',[1 1 0]);
        set(handles.session_indicator2,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator3,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator4,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator5,'BackgroundColor',[.941 .941 .941]);
guidata(hObject, handles);

% --- Executes on button press in sessioninspect_2.
function sessioninspect_2_Callback(hObject, eventdata, handles)
% hObject    handle to sessioninspect_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=2;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
        set(handles.session_indicator1,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator2,'BackgroundColor',[1 1 0]);
        set(handles.session_indicator3,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator4,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator5,'BackgroundColor',[.941 .941 .941]);
guidata(hObject, handles);

% --- Executes on button press in sessioninspect_3.
function sessioninspect_3_Callback(hObject, eventdata, handles)
% hObject    handle to sessioninspect_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=3;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
        set(handles.session_indicator1,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator2,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator3,'BackgroundColor',[1 1 0]);
        set(handles.session_indicator4,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator5,'BackgroundColor',[.941 .941 .941]);
guidata(hObject, handles);

% --- Executes on button press in sessioninspect_4.
function sessioninspect_4_Callback(hObject, eventdata, handles)
% hObject    handle to sessioninspect_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=4;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
        set(handles.session_indicator1,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator2,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator3,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator4,'BackgroundColor',[1 1 0]);
        set(handles.session_indicator5,'BackgroundColor',[.941 .941 .941]);
guidata(hObject, handles);

% --- Executes on button press in sessioninspect_5.
function sessioninspect_5_Callback(hObject, eventdata, handles)
% hObject    handle to sessioninspect_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=5;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
       
        set(handles.session_indicator1,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator2,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator3,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator4,'BackgroundColor',[.941 .941 .941]);
        set(handles.session_indicator5,'BackgroundColor',[1 1 0]);
guidata(hObject, handles);

% --- Executes on button press in SRPDC_finalize.
function SRPDC_finalize_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_finalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SRP_Options_working=getappdata(0,'SRP_options');
IndividualWaveformAmplitudes = SRP_Options_working{5,2};

set(handles.finaldata_txt,'String','Getting Filename');
drawnow;
savename = inputdlg('Input File Name');
savename=savename{1,1};
if handles.appliedthresh==1
    checkmodified=isfield(handles,'backup_list_modified');
    if checkmodified==1
       checkmodified_specific=isfield(handles,'modifiedlocations');
       if checkmodified_specific==1
           handles=rmfield(handles,'modifiedlocations');
           handles=rmfield(handles,'modified_fileindex');
           handles.modifiedlocations=handles.backup_list_modified;
           handles.modified_fileindex=handles.backup_key_modified;
       end
    end
        handles=rmfield(handles,'randomizedfilenames');
        handles=rmfield(handles,'randomizekey');
        handles=rmfield(handles,'blindfilenames');
        handles.randomizedfilenames=handles.backup_list_real;
        handles.randomizekey=handles.backup_key_real;
        handles.blindfilenames=handles.backup_listbox_real;
end

pathname=getappdata(0,'Output_Folder');
if isempty(pathname)==0
    newsave=sprintf('%s\\%s',pathname,savename);
    savename=newsave;
end

set(handles.finaldata_txt,'String','Applying Changes');
drawnow;
[groupnum,~]=size(handles.groupfiles);
sessionnum=handles.sessionnum;
trialnum=handles.trialnum;
windowsize=handles.windowsize;
for group=1:groupnum
    groupname=handles.groupnames_processedSRP{group,1};
    [~,filenum]=size(handles.groupfiles{group,1});
    for file=1:filenum
       filename=handles.groupfiles{group,1}(1,file);
       filename=filename{1,1}(1,1:end-4);
       EventNum=handles.Cleaned_SRPData.(groupname).(filename).EventNum;
       extractsession_flipRH=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{group,1}).EventNames{2,1});
       extractsession_flopRH=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{group,1}).EventNames{4,1});
       extractsession_flipLH=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{group,1}).EventNames{1,1});  
       extractsession_flopLH=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{group,1}).EventNames{3,1});
       if EventNum == 2
           extractsession_flipRH_novel='E3R';
           extractsession_flopRH_novel='E4R';
           extractsession_flipLH_novel='E3L';
           extractsession_flopLH_novel='E4L';
       end
       handles.Cleaned_SRPData.(groupname).(filename)=rmfield(handles.Cleaned_SRPData.(groupname).(filename),{'MergedWaveFormsL','MergedWaveFormsR','AveragedWaveFormL','AveragedWaveFormR','AmplitudesL','AmplitudesR','Amplitudes'});
       trialtracker=1;
       trialtracker_novel=1;
       
       if IndividualWaveformAmplitudes==1
           [betamax ~]=size(handles.Cleaned_SRPData.(groupname).EventNames);
           for betaA=1:4:betamax
                ExtractPeakNameL_Flip=(handles.Cleaned_SRPData.(groupname).EventNames{(betaA),1});
                ExtractPeakNameR_Flip=(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+1),1});
                ExtractPeakNameL_Flop=(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+2),1});
                ExtractPeakNameR_Flop=(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+3),1});
                NameRPeaks_Flip=sprintf('%s_AmplitudePeaks',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA),1}));
                NameLPeaks_Flip=sprintf('%s_AmplitudePeaks',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+1),1}));
                NameRPeaks_Flop=sprintf('%s_AmplitudePeaks',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+2),1}));
                NameLPeaks_Flop=sprintf('%s_AmplitudePeaks',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+3),1}));
                NameR_Flip=sprintf('%s_Amplitudes',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA),1}));
                NameL_Flip=sprintf('%s_Amplitudes',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+1),1}));
                NameR_Flop=sprintf('%s_Amplitudes',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+2),1}));
                NameL_Flop=sprintf('%s_Amplitudes',(handles.Cleaned_SRPData.(groupname).EventNames{(betaA+3),1}));
                for session=1:sessionnum
                    for individualamploop=1:trialnum
                        %Flips
                        handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flip)(session,individualamploop,1)=min(min(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameL_Flip)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flip)(session,individualamploop,1)=min(min(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameR_Flip)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flip)(session,individualamploop,2)=max(max(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameL_Flip)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flip)(session,individualamploop,2)=max(max(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameR_Flip)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameL_Flip)(session,individualamploop,1)=handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flip)(session,individualamploop,2)-handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flip)(session,individualamploop,1);
                        handles.Cleaned_SRPData.(groupname).(filename).(NameR_Flip)(session,individualamploop,1)=handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flip)(session,individualamploop,2)-handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flip)(session,individualamploop,1); 
                        %Flops
                        handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flop)(session,individualamploop,1)=min(min(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameL_Flop)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flop)(session,individualamploop,1)=min(min(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameR_Flop)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flop)(session,individualamploop,2)=max(max(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameL_Flop)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flop)(session,individualamploop,2)=max(max(handles.Cleaned_SRPData.(groupname).(filename).(ExtractPeakNameR_Flop)(session,individualamploop,:)));
                        handles.Cleaned_SRPData.(groupname).(filename).(NameL_Flop)(session,individualamploop,1)=handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flop)(session,individualamploop,2)-handles.Cleaned_SRPData.(groupname).(filename).(NameLPeaks_Flop)(session,individualamploop,1);
                        handles.Cleaned_SRPData.(groupname).(filename).(NameR_Flop)(session,individualamploop,1)=handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flop)(session,individualamploop,2)-handles.Cleaned_SRPData.(groupname).(filename).(NameRPeaks_Flop)(session,individualamploop,1); 
                    end
                end
           end
       end
       for session=1:sessionnum
	    check_changes_name=sprintf('handles.Cleaned_SRPData.%s.%s.cleaned_sessions',groupname,filename);
        
            check_changes=exist(check_changes_name);
            
            if check_changes ~=0
                checksessionLH=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions{2,session+1};
                checksessionRH=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions{2,session+1};
            else
                checksessionLH=1;
                checksessionRH=1;
            end
            
            if checksessionLH==0
                handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipLH)(session,:,:)=NaN;
                handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopLH)(session,:,:)=NaN;
            end
            if checksessionRH==0
                handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipRH)(session,:,:)=NaN;
                handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopRH)(session,:,:)=NaN;
            end
            for trial=1:trialnum
                handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(1,trialtracker,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipLH)(session,trial,:);
                handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(1,trialtracker,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipRH)(session,trial,:);
                trialtracker=trialtracker+1;
                handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(1,trialtracker,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopLH)(session,trial,:);
                handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(1,trialtracker,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopRH)(session,trial,:);
                trialtracker=trialtracker+1;
            end
            
            if EventNum==2
                check_changes_name_novel=sprintf('handles.Cleaned_SRPData.%s.%s.cleaned_sessions_novel',groupname,filename);
                check_changes_novel=exist(check_changes_name_novel);
                if check_changes_novel ~=0
                    checksessionLH=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions_novel{2,session+1};
                    checksessionRH=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions_novel{2,session+1};
                else
                    checksessionLH=1;
                    checksessionRH=1;
                end

                if checksessionLH==0
                    handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipLH_novel)(session,:,:)=NaN;
                    handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopLH_novel)(session,:,:)=NaN;
                end
                if checksessionRH==0
                    handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipRH_novel)(session,:,:)=NaN;
                    handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopRH_novel)(session,:,:)=NaN;
                end
                for trial=1:trialnum
                    handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(2,trialtracker_novel,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipLH_novel)(session,trial,:);
                    handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(2,trialtracker_novel,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flipRH_novel)(session,trial,:);
                    trialtracker_novel=trialtracker_novel+1;
                    handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(2,trialtracker_novel,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopLH_novel)(session,trial,:);
                    handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(2,trialtracker_novel,:)=handles.Cleaned_SRPData.(groupname).(filename).(extractsession_flopRH_novel)(session,trial,:);
                    trialtracker_novel=trialtracker_novel+1;
                end
            end
       end
       
       for datapoint=1:windowsize
           handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(1,datapoint)=nanmean(handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(1,:,datapoint));
           handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(1,datapoint)=nanmean(handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(1,:,datapoint));
           if EventNum==2
               handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(2,datapoint)=nanmean(handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsL(2,:,datapoint));
               handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(2,datapoint)=nanmean(handles.Cleaned_SRPData.(groupname).(filename).MergedWaveFormsR(2,:,datapoint));
           end
       end

        
        [minvalL,minlocL]=min(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(1,1:100));
        [maxvalL,maxlocL]=max(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(1,minlocL:250));
        handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(1,1)=minvalL;
        handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(1,2)=maxvalL;
        
        [minvalR,minlocR]=min(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(1,1:100));
        [maxvalR,maxlocR]=max(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(1,minlocR:250));
        handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(1,1)=minvalR;
        handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(1,2)=maxvalR;
        
        handles.Cleaned_SRPData.(groupname).(filename).Amplitudes(1,1)=handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(1,2)-handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(1,1);
        handles.Cleaned_SRPData.(groupname).(filename).Amplitudes(1,2)=handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(1,2)-handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(1,1);
        
        if EventNum==2
            [minvalL_novel,minlocL_novel]=min(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(2,1:100));
            [maxvalL_novel,maxlocL_novel]=max(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormL(2,minlocL_novel:250));
            handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(2,1)=minvalL_novel;
            handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(2,2)=maxvalL_novel;

            [minvalR_novel,minlocR_novel]=min(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(2,1:100));
            [maxvalR_novel,maxlocR_novel]=max(handles.Cleaned_SRPData.(groupname).(filename).AveragedWaveFormR(2,minlocR_novel:250));
            handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(2,1)=minvalR_novel;
            handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(2,2)=maxvalR_novel;

            handles.Cleaned_SRPData.(groupname).(filename).Amplitudes(2,1)=handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(2,2)-handles.Cleaned_SRPData.(groupname).(filename).AmplitudesL(2,1);
            handles.Cleaned_SRPData.(groupname).(filename).Amplitudes(2,2)=handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(2,2)-handles.Cleaned_SRPData.(groupname).(filename).AmplitudesR(2,1);
        end
    end
    
    handles.Cleaned_SRPData.(groupname)=rmfield(handles.Cleaned_SRPData.(groupname),'EndPlotData');
    EndPlotData{1,1}='File Name';
    maxminL=0;
    maxmaxL=0;
    maxminR=0;
    maxmaxR=0;
    
    for file=1:filenum
        filename=handles.groupfiles{group,1}(1,file);
        EndPlotData{file+1,1}=filename;
        referencefilename=filename{1,1}(1,1:end-4);
        EventNum=handles.Cleaned_SRPData.(groupname).(referencefilename).EventNum;
        for event=1:EventNum
            if event < 2
                EndPlotData{1,(event*2)}=sprintf('LH Familiar');
                EndPlotData{1,(event*2+1)}=sprintf('RH Familiar');
                EndPlotData{file+1,(event*2)}=handles.Cleaned_SRPData.(groupname).(referencefilename).Amplitudes(event,1);%LeftHemisphere
                EndPlotData{file+1,(event*2+1)}=handles.Cleaned_SRPData.(groupname).(referencefilename).Amplitudes(event,2);%RightHemisphere
            else
                EndPlotData{1,(event*2)}=sprintf('LH Novel');
                EndPlotData{1,(event*2+1)}=sprintf('RH Novel');
                EndPlotData{file+1,(event*2)}=handles.Cleaned_SRPData.(groupname).(referencefilename).Amplitudes(event,1);%LeftHemisphere
                EndPlotData{file+1,(event*2+1)}=handles.Cleaned_SRPData.(groupname).(referencefilename).Amplitudes(event,2);%RightHemisphere
            end
        end
    end
    handles.Cleaned_SRPData.(groupname).EndPlotData=EndPlotData;  
    clear EndPlotData
end

set(handles.finaldata_txt,'String','Saving Vetted File');
drawnow;
Cleaned_SRPData=handles.Cleaned_SRPData;
MasterSRPData=handles.MasterSRPData;
blindfilelist=handles.blindfilelist;
check_vars(1,1)=isfield(handles,'fileassociations');
check_vars(1,2)=isfield(handles,'day1threshtracker');
if check_vars(1,1)==1
    fileassociations=handles.fileassociations;
end
if check_vars(1,2)==1
    day1threshtracker=handles.day1threshtracker;
end
randomizekey=handles.randomizekey;
blindfilenames=handles.blindfilenames;
randomizedfilenames=handles.randomizedfilenames;
% checkfornotepad=isfield(handles,'notepad_txt');
% if checkfornotepad==1
%     notepad_txt=handles.notepad_txt;
% end

checkfornotepad=isfield(handles,'notepad_txt');
if checkfornotepad==1
    notepad_txt=handles.notepad_txt;
end
cleanname=sprintf('%s_Vetted',savename);
save(cleanname,'Cleaned_SRPData','-v7.3');

checkloaded=get(handles.SRPDC_useloaded,'Value');
if checkloaded==0
    set(handles.finaldata_txt,'String','Saving Ref File');
    drawnow;
    refname=sprintf('%s_ReferenceData',savename);
    save(refname,'MasterSRPData','-v7.3');
end
set(handles.finaldata_txt,'String','Saving Options');
drawnow;
optionsname=sprintf('%s_OptionSettings.mat',savename);
if checkfornotepad==1
    if sum(check_vars)==2
    	save(optionsname,'fileassociations','day1threshtracker','blindfilelist','randomizekey','blindfilenames','randomizedfilenames','notepad_txt');
    else
        save(optionsname,'blindfilelist','randomizekey','blindfilenames','randomizedfilenames','notepad_txt');
    end
else
    if sum(check_vars)==2
        save(optionsname,'fileassociations','day1threshtracker','blindfilelist','randomizekey','blindfilenames','randomizedfilenames');
    else
        save(optionsname,'blindfilelist','randomizekey','blindfilenames','randomizedfilenames');
    end
end
set(handles.finaldata_txt,'String','Data Saved');
drawnow;


% --- Executes on button press in SRPDC_markdifficult.
function SRPDC_markdifficult_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_markdifficult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function sessionplot_inspector(groupvalue,selected_filename,handles,hObject,session_to_plot)
    usingblind=get(handles.SRPDC_blind_data,'Value');
    if usingblind==1
        filename_loc=selected_filename;
        clear selected_filename
        selected_filename=handles.groupfiles{groupvalue,1}(1,filename_loc);
    end
        checklimit_upper=get(handles.SRPDC_upper_ylim,'Backgroundcolor');
        checklimit_lower=get(handles.SRPDC_lower_ylim,'Backgroundcolor');
        if checklimit_upper(1,1)==0 && checklimit_upper(1,2) == 1 && checklimit_upper(1,3) == 0 && checklimit_lower(1,1)==0 && checklimit_lower(1,2) == 1 && checklimit_lower(1,3) == 0
            handles.ylim=true;
        end
        if handles.usehemi==2
            extractsession=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{2,1});
        elseif handles.usehemi==1
            extractsession=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).EventNames{1,1});        
        end
    [session_num trials_num windowsize] = size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession));
    axes(handles.plot_dayavg);
    cla reset;
    hold all
    plot_matrix=nan(trials_num,windowsize);
    for trial = 1:trials_num
        plot_matrix(trial,:)=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{groupvalue,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession)(session_to_plot,trial,:);
        plot(plot_matrix(trial,:));
    end
    if handles.ylim==true
        ylim_upper=str2num(get(handles.SRPDC_upper_ylim,'String'));
        ylim_lower=str2num(get(handles.SRPDC_lower_ylim,'String'));
        ylim([ylim_lower ylim_upper]);
    end
    set(handles.plot2_txt,'String','Session Windows');

    guidata(hObject,handles);

% --- Executes when selected object is changed in ui_plotcontrol.
function ui_plotcontrol_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ui_plotcontrol 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if handles.currentdata_loaded >= 1
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'dayavg'
        blinddata=get(handles.SRPDC_blind_data,'Value');
        if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
        end
        if handles.separateflipflops==1
            set(handles.SRPDC_amplitudeflip_txt,'Visible','on');
            set(handles.SRPDC_amplitudeflop_txt,'Visible','on');
        else
            set(handles.SRPDC_amplitude_txt,'Visible','on');
        end
        set(handles.session_indicator1,'Visible','off');
        set(handles.session_indicator2,'Visible','off');
        set(handles.session_indicator3,'Visible','off');
        set(handles.session_indicator4,'Visible','off');
        set(handles.session_indicator5,'Visible','off');
        set(handles.sessioninspect_1,'Visible','off');
        set(handles.sessioninspect_2,'Visible','off');
        set(handles.sessioninspect_3,'Visible','off');
        set(handles.sessioninspect_4,'Visible','off');
        set(handles.sessioninspect_5,'Visible','off');
        set(handles.upperthresh_txt,'Visible','off');
        set(handles.SRPDC_pos_artifact_thresh,'Visible','off');
        set(handles.lowerthresh_txt,'Visible','off');
        set(handles.SRPDC_neg_artifact_thresh,'Visible','off');
        set(handles.SRPDC_remove_artifact,'Visible','off');
        set(handles.SRPDC_undoremove,'Visible','off');
    case 'sessioninspector'
       blinddata=get(handles.SRPDC_blind_data,'Value');
       handles.selectedsession=1;
       if blinddata==1
            selectedfile=get_correct_filenum(handles);
            [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else
            selectedfile=get_correct_filenum(handles);
            selectedgroup = get(handles.SRPDC_grouplist,'Value');
            handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);
       end
        set(handles.SRPDC_amplitude_txt,'Visible','off');
        set(handles.SRPDC_amplitudeflip_txt,'Visible','off');
        set(handles.SRPDC_amplitudeflop_txt,'Visible','off');
        set(handles.session_indicator1,'Visible','on');
        set(handles.session_indicator2,'Visible','on');
        set(handles.session_indicator3,'Visible','on');
        set(handles.session_indicator4,'Visible','on');
        set(handles.session_indicator5,'Visible','on');
        set(handles.sessioninspect_1,'Visible','on');
        set(handles.sessioninspect_2,'Visible','on');
        set(handles.sessioninspect_3,'Visible','on');
        set(handles.sessioninspect_4,'Visible','on');
        set(handles.sessioninspect_5,'Visible','on');
        set(handles.upperthresh_txt,'Visible','on');
        set(handles.SRPDC_pos_artifact_thresh,'Visible','on');
        set(handles.lowerthresh_txt,'Visible','on');
        set(handles.SRPDC_neg_artifact_thresh,'Visible','on');
        set(handles.SRPDC_remove_artifact,'Visible','on');
        set(handles.SRPDC_undoremove,'Visible','on');
end
end
guidata(hObject,handles);

function SRPDC_pos_artifact_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_pos_artifact_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRPDC_pos_artifact_thresh as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_pos_artifact_thresh as a double
userinput=get(hObject,'String');
checkinputdouble_artifacts(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_pos_artifact_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_pos_artifact_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SRPDC_neg_artifact_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_neg_artifact_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRPDC_neg_artifact_thresh as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_neg_artifact_thresh as a double
userinput=get(hObject,'String');
checkinputdouble_artifacts(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_neg_artifact_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_neg_artifact_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SRPDC_remove_artifact.
function SRPDC_remove_artifact_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_remove_artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
    session=handles.selectedsession;
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        selectedfile=get_correct_filenum(handles);
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
        selectedfile=truefilenum;
        selectedgroup=truegroup;
    else
        selectedfile=get_correct_filenum(handles);
        selectedgroup = get(handles.SRPDC_grouplist,'Value');
    end
    selected_filename=handles.groupfiles{selectedgroup,1}(1,selectedfile);

    %Check to see if file contains a novel event (AKA eventnum = 2)

    CheckNovel=get(handles.SRPDC_shownovel,'Value');
        
    % handles    structure with handles and user data (see GUIDATA)
    if handles.usehemi==2
        if CheckNovel~=1
            extractsession_flip=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{2,1});
            extractsession_flop=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{4,1});
        else
            extractsession_flip='E3R';
            extractsession_flop='E4R';
        end
    elseif handles.usehemi==1
        if CheckNovel ~= 1
            extractsession_flip=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{1,1});  
            extractsession_flop=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{3,1});
        else
            extractsession_flip='E3L';
            extractsession_flop='E4L';  
        end
    end
    
    upperthresh=get(handles.SRPDC_pos_artifact_thresh,'String');
    lowerthresh=get(handles.SRPDC_neg_artifact_thresh,'String');
    upperthresh_num=str2num(upperthresh);
    lowerthresh_num=str2num(lowerthresh);
    [~,trialnum,~]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip));
    if isempty(upperthresh_num)==0
        [~,upper_results]=find(handles.plot_dayavgData(:,:) >= upperthresh_num);
        upper_results=unique(upper_results);
        [upper_result_len,~]=size(upper_results);
        for i = 1:upper_result_len
            if upper_results(i,1) > trialnum
                upper_results(i,1)=upper_results(i,1)-trialnum;
            end
            handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip)(session,upper_results(i,1),:)=NaN;
            handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flop)(session,upper_results(i,1),:)=NaN;
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)),'TrackArtifacts')==1
                if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts,(extractsession_flop))==1
                    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop),'Upper')==0
                        handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,1}=upper_results(i,1);
                        handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Upper{session,1}=upper_results(i,1);
                    else
                        [artifact_rows,artifact_columns]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper);
                        if session > artifact_rows 
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,1}=upper_results(i,1);
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Upper{session,1}=upper_results(i,1);
                        else
                            check_if_tracked=find([handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,:}]==upper_results(i,1));
                            if sum(check_if_tracked)>=1
                                %do nothing because this trial has already been
                                %tracked as removed for this session.
                            else
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,end+1}=upper_results(i,1);
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Upper{session,end+1}=upper_results(i,1);
                            end
                        end
                    end
                else
                	handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,1}=upper_results(i,1); 
                    handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Upper{session,1}=upper_results(i,1);     
                end
            else
               handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Upper{session,1}=upper_results(i,1); 
               handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Upper{session,1}=upper_results(i,1); 
            end
        end
    end
    if isempty(lowerthresh_num)==0
        [~,lower_results]=find(handles.plot_dayavgData(:,:) <= lowerthresh_num);
        lower_results=unique(lower_results);
        [lower_result_len,~]=size(lower_results);
        
        
        for i = 1:lower_result_len
            if lower_results(i,1) > trialnum
                lower_results(i,1)=lower_results(i,1)-trialnum;
            end
            handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flip)(session,lower_results(i,1),:)=NaN;
            handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flop)(session,lower_results(i,1),:)=NaN;         
            if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)),'TrackArtifacts')==1
                if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts,(extractsession_flop))==1
                    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop),'Lower')==0
                        handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,1}=lower_results(i,1);
                        handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Lower{session,1}=lower_results(i,1);
                    else
                        [artifact_rows,artifact_columns]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower);
                        if session > artifact_rows
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,1}=lower_results(i,1);
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Lower{session,1}=lower_results(i,1);
                        else
                            check_if_tracked=find([handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,:}]==lower_results(i,1));
                            if sum(check_if_tracked)>=1
                                %do nothing because this trial has already been
                                %tracked as removed for this session.
                            else
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,end+1}=lower_results(i,1);
                                handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Lower{session,end+1}=lower_results(i,1);
                            end
                        end
                    end
                else
                    handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,1}=lower_results(i,1); 
                    handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Lower{session,1}=lower_results(i,1);     
                end
            else
               handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flop).Lower{session,1}=lower_results(i,1); 
               handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flip).Lower{session,1}=lower_results(i,1); 
            end
        end
    end
    if blinddata==1
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    else
        handles=sessionplot(selectedgroup,(handles.groupfiles{selectedgroup,1}(1,selectedfile)),handles,hObject,0,false,0,0,0);
    end
    filelist=cellstr(get(handles.SRPDC_filelist,'String'));
    selectedfile=get(handles.SRPDC_filelist,'Value');
    filelist{selectedfile,1}=sprintf('%s*',filelist{selectedfile,1});
    set(handles.SRPDC_filelist,'String',filelist);
guidata(hObject,handles);

% --- Executes on button press in SRPDC_undoremove.
function SRPDC_undoremove_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_undoremove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        selectedfile=get_correct_filenum(handles);
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
        selectedfile=truefilenum;
        selectedgroup=truegroup;
    else
        selectedfile=get_correct_filenum(handles);
        selectedgroup = get(handles.SRPDC_grouplist,'Value');
    end
    selected_filename=handles.groupfiles{selectedgroup,1}(1,selectedfile);

    CheckNovel=get(handles.SRPDC_shownovel,'Value');
    
    if CheckNovel~=1
    % handles    structure with handles and user data (see GUIDATA)
        extractsession_flipR=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{2,1});
        extractsession_flopR=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{4,1});
        extractsession_flipL=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{1,1});  
        extractsession_flopL=sprintf('%s',handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).EventNames{3,1});
    else
        extractsession_flipR='E3R';
        extractsession_flopR='E4R';
        extractsession_flipL='E3L';
        extractsession_flopL='E4L';
    end

if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)),'TrackArtifacts') == 1
   if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts,(extractsession_flipL))==1
       if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL),'Upper')==1
           [trackedsession_num,maxtrialsremoved]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL).Upper);
           for i = 1:trackedsession_num
               for j = 1:maxtrialsremoved
                   check_trial=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL).Upper{i,j};
                   if isempty(check_trial) == 0
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipL)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipL)(i,check_trial,:);
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopL)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopL)(i,check_trial,:);
                   end
               end
           end
       elseif isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL),'Lower')==1
           [trackedsession_num,maxtrialsremoved]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL).Lower);
           for i = 1:trackedsession_num
               for j = 1:maxtrialsremoved
                   check_trial=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipL).Lower{i,j};
                   if isempty(check_trial) == 0
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipL)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipL)(i,check_trial,:);
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopL)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopL)(i,check_trial,:);
                   end
               end
           end
       end
   elseif isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts,(extractsession_flipR))==1
       if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR),'Upper')==1
           [trackedsession_num,maxtrialsremoved]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR).Upper);
           for i = 1:trackedsession_num
               for j = 1:maxtrialsremoved
                   check_trial=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR).Upper{i,j};
                   if isempty(check_trial) == 0
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipR)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipR)(i,check_trial,:);
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopR)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopR)(i,check_trial,:);
                   end
               end
           end
       elseif isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR),'Lower')==1
           [trackedsession_num,maxtrialsremoved]=size(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR).Lower);
           for i = 1:trackedsession_num
               for j = 1:maxtrialsremoved
                   check_trial=handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).TrackArtifacts.(extractsession_flipR).Lower{i,j};
                   if isempty(check_trial) == 0
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipR)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flipR)(i,check_trial,:);
                       handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopR)(i,check_trial,:)=handles.MasterSRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)).(extractsession_flopR)(i,check_trial,:);
                   end
               end
           end
       end
   end
end
    if blinddata==1
        handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    else
        handles=sessionplot(selectedgroup,(handles.groupfiles{selectedgroup,1}(1,selectedfile)),handles,hObject,0,false,0,0,0);
    end
    filelist=cellstr(get(handles.SRPDC_filelist,'String'));
    selectedfile=get(handles.SRPDC_filelist,'Value');
    currentname=filelist{selectedfile,1};
    currentname(regexp(currentname,'*'))=[];
    filelist{selectedfile,1}=currentname;
    %filelist{selectedfile,1}=sprintf('%s',filelist{selectedfile,1}(1,1:end-1));
    set(handles.SRPDC_filelist,'String',filelist);
if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)),'TrackArtifacts') == 1
    handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4))=rmfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(selected_filename{1,1}(1,1:end-4)),'TrackArtifacts');
end
guidata(hObject,handles);

% --- Executes on button press in SRPDC_separateflipflops.
function SRPDC_separateflipflops_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_separateflipflops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_separateflipflops
if handles.currentdata_loaded >= 1
    userselection=get(hObject,'Value');
    usesessions=get(handles.sessioninspector,'Value');
    if userselection==1
        handles.separateflipflops=1;
        if usesessions == 0
            set(handles.SRPDC_amplitudeflip_txt,'Visible','on');
            set(handles.SRPDC_amplitudeflop_txt,'Visible','on');
        end
        set(handles.SRPDC_amplitude_txt,'Visible','off');
        set(handles.flip1label,'Visible','on');
        set(handles.flip2label,'Visible','on');
        set(handles.flop1label,'Visible','on');
        set(handles.flop2label,'Visible','on');
    else
        handles.separateflipflops=0;
        set(handles.SRPDC_amplitudeflip_txt,'Visible','off');
        set(handles.SRPDC_amplitudeflop_txt,'Visible','off');
        if usesessions == 0
            set(handles.SRPDC_amplitude_txt,'Visible','on');
        end
        set(handles.flip1label,'Visible','off');
        set(handles.flip2label,'Visible','off');
        set(handles.flop1label,'Visible','off');
        set(handles.flop2label,'Visible','off');
    end
    blinddata=get(handles.SRPDC_blind_data,'Value');
    if blinddata==1
        selectedfile=get_correct_filenum(handles);
        [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
        usesessions=get(handles.sessioninspector,'Value');
        if usesessions == 1
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        else 
            handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
        end
        groupname=(handles.groupnames_processedSRP{truegroup,1});
        filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
        if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
            handles=session_boxes(1,groupname,filename,handles);
        else
            handles=session_boxes(0,groupname,filename,handles);
        end
    else
        selectedfile=get_correct_filenum(handles);
        selectedgroup = get(handles.SRPDC_grouplist,'Value');
        handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);


        %Restore session checkboxes or generate default values for this
        %specific file.
        groupname=(handles.groupnames_processedSRP{selectedgroup,1});
        filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
        filename=(filename{1,1}(1,1:end-4));
        if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
            handles=session_boxes(1,groupname,filename,handles);
        else
            handles=session_boxes(0,groupname,filename,handles);
        end
    end
    guidata(hObject,handles);
end

% --- Executes on button press in SRPDC_ExportFig1.
function SRPDC_ExportFig1_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_ExportFig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.plot_sessions)
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    filename_loc=truefilenum;
    clear selectedfile
    selectedfile=handles.groupfiles{truegroup,1}(1,filename_loc);
else
    selectedfile=get_correct_filenum(handles);
end
check_hemi=get(handles.Left_Hemi,'Value');
if check_hemi==1
    filename=sprintf('LH_Sessions_%s.eps',(selectedfile{1,1}(1,1:end-4)));
else
    filename=sprintf('RH_Sessions_%s.eps',(selectedfile{1,1}(1,1:end-4)));
end
outputfig=figure;
hold all
plot_matrix=handles.plot_sessionData;
for session=1:5
    plot(plot_matrix(session,:),'Color',handles.sessioncolors(session,:));
end
    if handles.ylim==true
        ylim_upper=str2num(get(handles.SRPDC_upper_ylim,'String'));
        ylim_lower=str2num(get(handles.SRPDC_lower_ylim,'String'));
        ylim([ylim_lower ylim_upper]);
        if handles.separateflipflops==1
            plot([handles.windowsize handles.windowsize],[ylim_lower ylim_upper],'--','Color','red','LineWidth',2);
        end
    else
        if handles.separateflipflops==1
            ylims=ylim;
            plot([handles.windowsize handles.windowsize],[ylims(1,1) ylims(1,2)],'--','Color','red','LineWidth',2);
        end
    end
saveas(outputfig,filename,'eps');
close(outputfig);

% --- Executes on button press in SRPDC_ExportFig2.
function SRPDC_ExportFig2_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_ExportFig2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.plot_dayavg)
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    filename_loc=truefilenum;
    clear selectedfile
    selectedfile=handles.groupfiles{truegroup,1}(1,filename_loc);
else
    selectedfile=get_correct_filenum(handles);
end
check_dayavg=get(handles.dayavg,'Value');
check_hemi=get(handles.Left_Hemi,'Value');
if check_dayavg==1
    if check_hemi==1
        filename=sprintf('LH_DayAvg_%s.eps',(selectedfile{1,1}(1,1:end-4)));
    else
        filename=sprintf('RH_DayAvg_%s.eps',(selectedfile{1,1}(1,1:end-4)));
    end
else
    if check_hemi==1
        filename=sprintf('LH_Session%s_%s.eps',num2str(handles.selectedsession),(selectedfile{1,1}(1,1:end-4)));
    else
       filename=sprintf('RH_Session%s_%s.eps',num2str(handles.selectedsession),(selectedfile{1,1}(1,1:end-4))); 
    end
end
outputfig=figure;
hold all
plot_merged_final=handles.plot_dayavgData;
 checksessionplot=get(handles.sessioninspector,'Value');
if checksessionplot==0
    plot(plot_merged_final,'Color','black','LineWidth',1);
else
    plot(plot_merged_final);
end
    if handles.ylim==true
        ylim_upper=str2num(get(handles.SRPDC_upper_ylim,'String'));
        ylim_lower=str2num(get(handles.SRPDC_lower_ylim,'String'));
        ylim([ylim_lower ylim_upper]);
        if handles.separateflipflops==1
            plot([handles.windowsize handles.windowsize],[ylim_lower ylim_upper],'--','Color','red','LineWidth',2);
        end
    else
        if handles.separateflipflops==1
            ylims=ylim;
            plot([handles.windowsize handles.windowsize],[ylims(1,1) ylims(1,2)],'--','Color','red','LineWidth',2);
        end
    end
   
    if checksessionplot==0
        if handles.separateflipflops==0
        [minval,minloc]=min(plot_merged_final(1,1:100));
        [maxval,maxloc]=max(plot_merged_final(1,minloc:250));
        truemaxloc=maxloc+minloc;
        hold on
        plot(minloc,minval,'+','Color','blue');
        plot(truemaxloc,maxval,'+','Color','red');
        else
            [minval1,minloc1]=min(plot_merged_final(1,1:100));
            [maxval1,maxloc1]=max(plot_merged_final(1,minloc1:250));
            truemaxloc1=maxloc1+minloc1;
            hold on
            plot(minloc1,minval1,'+','Color','blue');
            plot(truemaxloc1,maxval1,'+','Color','red');
            [minval2,minloc2]=min(plot_merged_final(1,496:596));
             minloc2=minloc2+handles.windowsize;
            [maxval2,maxloc2]=max(plot_merged_final(1,minloc2:745));
            truemaxloc2=maxloc2+minloc2;
            hold on
            plot(minloc2,minval2,'+','Color','blue');
            plot(truemaxloc2,maxval2,'+','Color','red');
        end
    end
saveas(outputfig,filename,'eps');
close(outputfig);

function [handles]=modify_session(changematrix,singlesession,hemisphere,filename,groupname,handles)
    session_num=length(changematrix);
    CheckNovel=get(handles.SRPDC_shownovel,'Value');
    if CheckNovel~=1
        if session_num > 1
            for changesession=1:session_num
                    handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions{(hemisphere+1),(changesession+1)}=changematrix(1,changesession);
            end
        else
            handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions{(hemisphere+1),(singlesession(1,1)+1)}=singlesession(1,2);
        end
    else
        if session_num > 1
            for changesession=1:session_num
                    handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions_novel{(hemisphere+1),(changesession+1)}=changematrix(1,changesession);
            end
        else
            handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions_novel{(hemisphere+1),(singlesession(1,1)+1)}=singlesession(1,2);
        end
    end

function [returnvalue]=get_session(hemisphere,session_number,filename,groupname,handles)
CheckNovel=get(handles.SRPDC_shownovel,'Value');
if CheckNovel ~=1
    returnvalue=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions{hemisphere+1,session_number+1};
else
    returnvalue=handles.Cleaned_SRPData.(groupname).(filename).cleaned_sessions_novel{hemisphere+1,session_number+1};
end

function [handles]=session_boxes(generatenew,group,filename,handles)
    if generatenew==1
        set(handles.SRPDC_session1,'Value',1);
        set(handles.SRPDC_session2,'Value',1);
        set(handles.SRPDC_session3,'Value',1);
        set(handles.SRPDC_session4,'Value',1);
        set(handles.SRPDC_session5,'Value',1);
    else
        hemisphere = 1; %left hemisphere
        formatoffset = 1;
        session1value=handles.Cleaned_SRPData.(group).(filename).cleaned_sessions{(hemisphere+formatoffset),1+formatoffset};
        session2value=handles.Cleaned_SRPData.(group).(filename).cleaned_sessions{(hemisphere+formatoffset),2+formatoffset};
        session3value=handles.Cleaned_SRPData.(group).(filename).cleaned_sessions{(hemisphere+formatoffset),3+formatoffset};
        session4value=handles.Cleaned_SRPData.(group).(filename).cleaned_sessions{(hemisphere+formatoffset),4+formatoffset};
        session5value=handles.Cleaned_SRPData.(group).(filename).cleaned_sessions{(hemisphere+formatoffset),5+formatoffset};
        set(handles.SRPDC_session1,'Value',session1value);
        set(handles.SRPDC_session2,'Value',session2value);
        set(handles.SRPDC_session3,'Value',session3value);
        set(handles.SRPDC_session4,'Value',session4value);
        set(handles.SRPDC_session5,'Value',session5value);
    end
    
function [handles]=disableuserinput(handles)
% set(handles.SRPDC_sessions_cleanup,'Enable','off');
% set(handles.SRPDC_separateflipflops,'Enable','off');
% set(handles.SRPDC_useprocessed,'Enable','off');
% set(handles.SRPDC_useloaded,'Enable','off');
% set(handles.SRPDC_upper_ylim,'Enable','off');
% set(handles.SRPDC_lower_ylim,'Enable','off');
% set(handles.SRPDC_blind_data,'Enable','off');
% set(handles.SRPDC_revealnames,'Enable','off');
% set(handles.SRPDC_grouplist,'Enable','off');
% set(handles.SRPDC_filelist,'Enable','off');
% set(handles.Left_Hemi,'Enable','off');
% set(handles.Right_Hemi,'Enable','off');
% set(handles.dayavg,'Enable','off');
% set(handles.sessioninspector,'Enable','off');
% set(handles.SRPDC_ExportFig1,'Enable','off');
% set(handles.SRPDC_ExportFig2,'Enable','off');
% set(handles.SRPDC_session1,'Enable','off');
% set(handles.SRPDC_session2,'Enable','off');
% set(handles.SRPDC_session3,'Enable','off');
% set(handles.SRPDC_session4,'Enable','off');
% set(handles.SRPDC_session5,'Enable','off');
% set(handles.sessioninspect_1,'Enable','off');
% set(handles.sessioninspect_2,'Enable','off');
% set(handles.sessioninspect_3,'Enable','off');
% set(handles.sessioninspect_4,'Enable','off');
% set(handles.sessioninspect_5,'Enable','off');
% set(handles.SRPDC_pos_artifact_thresh,'Enable','off');
% set(handles.SRPDC_neg_artifact_thresh,'Enable','off');
% set(handles.SRPDC_keepselected,'Enable','off');
% set(handles.SRPDC_switchhemi,'Enable','off');
% set(handles.SRPDC_previousfile,'Enable','off');
% set(handles.SRPDC_nextfile,'Enable','off');
% set(handles.SRPDC_markdifficult,'Enable','off');
% set(handles.SRPDC_remove_artifact,'Enable','off');
% set(handles.SRPDC_finalize,'Enable','off');
%set(handles.,'Enable','off');

function [handles]=enableuserinput(handles)
% set(handles.SRPDC_sessions_cleanup,'Enable','on');
% set(handles.SRPDC_separateflipflops,'Enable','on');
% set(handles.SRPDC_useprocessed,'Enable','on');
% set(handles.SRPDC_useloaded,'Enable','on');
% set(handles.SRPDC_upper_ylim,'Enable','on');
% set(handles.SRPDC_lower_ylim,'Enable','on');
% set(handles.SRPDC_blind_data,'Enable','on');
% set(handles.SRPDC_revealnames,'Enable','on');
% set(handles.SRPDC_grouplist,'Enable','on');
% set(handles.SRPDC_filelist,'Enable','on');
% set(handles.Left_Hemi,'Enable','on');
% set(handles.Right_Hemi,'Enable','on');
% set(handles.dayavg,'Enable','on');
% set(handles.sessioninspector,'Enable','on');
% set(handles.SRPDC_ExportFig1,'Enable','on');
% set(handles.SRPDC_ExportFig2,'Enable','on');
% set(handles.SRPDC_session1,'Enable','on');
% set(handles.SRPDC_session2,'Enable','on');
% set(handles.SRPDC_session3,'Enable','on');
% set(handles.SRPDC_session4,'Enable','on');
% set(handles.SRPDC_session5,'Enable','on');
% set(handles.sessioninspect_1,'Enable','on');
% set(handles.sessioninspect_2,'Enable','on');
% set(handles.sessioninspect_3,'Enable','on');
% set(handles.sessioninspect_4,'Enable','on');
% set(handles.sessioninspect_5,'Enable','on');
% set(handles.SRPDC_pos_artifact_thresh,'Enable','on');
% set(handles.SRPDC_neg_artifact_thresh,'Enable','on');
% set(handles.SRPDC_keepselected,'Enable','on');
% set(handles.SRPDC_switchhemi,'Enable','on');
% set(handles.SRPDC_previousfile,'Enable','on');
% set(handles.SRPDC_nextfile,'Enable','on');
% set(handles.SRPDC_markdifficult,'Enable','on');
% set(handles.SRPDC_remove_artifact,'Enable','on');
% set(handles.SRPDC_finalize,'Enable','on');

% --- Executes on button press in SRPDC_usesmoothing.
function SRPDC_usesmoothing_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_usesmoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_usesmoothing
smoothdata=get(handles.SRPDC_usesmoothing,'Value');
if smoothdata == 1
    set(handles.SRPDC_movingavgtxt,'Visible','on');
    set(handles.SRPDC_movingavginput,'Visible','on');
    handles.usesmoothing=1;
else
    set(handles.SRPDC_movingavgtxt,'Visible','off');
    set(handles.SRPDC_movingavginput,'Visible','off');
    handles.usesmoothing=0;
end
guidata(hObject,handles);

function SRPDC_movingavginput_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_movingavginput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
userinput=get(hObject,'String');
checkinputdouble_movingaverage(hObject, userinput, handles);
% Hints: get(hObject,'String') returns contents of SRPDC_movingavginput as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_movingavginput as a double

% --- Executes during object creation, after setting all properties.
function SRPDC_movingavginput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_movingavginput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SRPDC_switchgroupinput_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_switchgroupinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRPDC_switchgroupinput as text
%        str2double(get(hObject,'String')) returns contents of SRPDC_switchgroupinput as a double
userinput=get(hObject,'String');
checkinputdouble_artifacts(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRPDC_switchgroupinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRPDC_switchgroupinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SRPDC_transferanimal.
function SRPDC_transferanimal_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_transferanimal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in open_notetxt.
function open_notetxt_Callback(hObject, eventdata, handles)
% hObject    handle to open_notetxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkfornotepad=isfield(handles,'notepad_txt');
check_processed=get(handles.SRPDC_useprocessed,'Value');
check_loaded=get(handles.SRPDC_useloaded,'Value');

if check_loaded==1
    checkforsavednotes=isfield(handles.saved_options,'notepad_txt');
    if checkfornotepad==0
        if checkforsavednotes==1
            handles.notepad_txt=handles.saved_options.notepad_txt;
        else
            handles.notepad_txt='';
        end
    else
        handles.notepad_txt=handles.notepad_txt;
    end
elseif check_processed == 1
   if checkfornotepad==0
       handles.notepad_txt='';
   else
        handles.notepad_txt=handles.notepad_txt;
   end
else
    %should not be here
    %debug
end
guidata(hObject,handles);
notepad


% --- Executes when selected object is changed in filelist_dayselection.
function filelist_dayselection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in filelist_dayselection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

set(handles.custom_search_string,'String',[]);
handles.custom_search=[];
check_blind=get(handles.SRPDC_blind_data,'Value');
if check_blind==0
    msgbox('Cannot change days while data is unblind.')
    set(handles.filelist_alldays,'Value',1);
    guidata(hObject,handles);
    return;
end

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'filelist_alldays'
        handles.usefilelist=0;
        set(handles.SRPDC_blind_data,'Enable','on');
    case 'filelist_day1'
        handles.usefilelist=1;
        set(handles.SRPDC_blind_data,'Enable','off');
    case 'filelist_day2'
        handles.usefilelist=2;
        set(handles.SRPDC_blind_data,'Enable','off');
    case 'filelist_day3'
        handles.usefilelist=3;
        set(handles.SRPDC_blind_data,'Enable','off');
    case 'filelist_day4'
        handles.usefilelist=4;
        set(handles.SRPDC_blind_data,'Enable','off');
    case 'filelist_day5'
        handles.usefilelist=5;
        set(handles.SRPDC_blind_data,'Enable','off');
end
handles=updatefilelist(handles);

handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
else
    selectedfile=get_correct_filenum(handles);
    selectedgroup = get(handles.SRPDC_grouplist,'Value');
    handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

    
    %Restore session checkboxes or generate default values for this
    %specific file.
    groupname=(handles.groupnames_processedSRP{selectedgroup,1});
    filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
    filename=(filename{1,1}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
%handles=enableuserinput(handles);

guidata(hObject,handles);




function custom_search_string_Callback(hObject, eventdata, handles)
% hObject    handle to custom_search_string (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of custom_search_string as text
%        str2double(get(hObject,'String')) returns contents of custom_search_string as a double
check_blind=get(handles.SRPDC_blind_data,'Value');
if check_blind==0
    msgbox('Cannot currently specify specific days if data is unblind.')
    set(handles.filelist_alldays,'Value',1);
    guidata(hObject,handles);
    return;
end




handles.custom_search=get(hObject,'String');
guidata(hObject,handles);
handles=updatefilelist(handles);
handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
else
    selectedfile=get_correct_filenum(handles);
    selectedgroup = get(handles.SRPDC_grouplist,'Value');
    handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

    
    %Restore session checkboxes or generate default values for this
    %specific file.
    groupname=(handles.groupnames_processedSRP{selectedgroup,1});
    filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
    filename=(filename{1,1}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
%handles=enableuserinput(handles);

guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function custom_search_string_CreateFcn(hObject, eventdata, handles)
% hObject    handle to custom_search_string (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function [handles]=updatefilelist(handles)
checkmodified=isfield(handles,'modifiedlocations');
blinddata=get(handles.SRPDC_blind_data,'Value');
if checkmodified==1
   handles=rmfield(handles,'modifiedlocations'); 
   handles=rmfield(handles,'modified_fileindex');
   handles=rmfield(handles,'modified_filelist');
end
set(handles.SRPDC_filelist,'Value',1);

check_customsearch=isfield(handles,'custom_search');
if check_customsearch==0
    handles.custom_search=[];
end

if isempty(handles.custom_search) == 0
    backupfilelist=handles.usefilelist;
    handles.usefilelist=1;
end
    
if handles.usefilelist~=0
    if handles.usefilelist==5
        search_string='nov';
    else
        if isempty(handles.custom_search) == 1 
            search_string=sprintf('Day%s',num2str(handles.usefilelist));
        else
            search_string=handles.custom_search;
            handles.usefilelist=backupfilelist;
        end
    end
    
        if blinddata==1
            [~,filenum]=size(handles.blindfilelist);
            check_modifiedexist=isfield(handles,'modifiedlocations');
            if check_modifiedexist==1
                handles=rmfields(handles,'modifiedlocations');
            end
            handles.modifiedlocations=regexpi(handles.randomizedfilenames,search_string);
            handles.modified_fileindex=find(~cellfun(@isempty,handles.modifiedlocations));
            
            check_indexempty=isempty(handles.modified_fileindex);
            
            
            if check_indexempty==1
                handles=rmfield(handles,'modifiedlocations');
                handles=rmfield(handles,'modified_fileindex');
                if strcmp('nov',search_string)==1
                    search_string='day5';
                    handles.modifiedlocations=regexpi(handles.randomizedfilenames,search_string);
                    handles.modified_fileindex=find(~cellfun(@isempty,handles.modifiedlocations));
                    check_indexempty=isempty(handles.modified_fileindex);
                end
                if check_indexempty==1
                    outputstring=sprintf('The program was not able to find your search string: %s',search_string);
                    msgbox(outputstring,'Error');
                    return;
                end
            end
            revealnames=get(handles.SRPDC_revealnames,'Value');
            if revealnames==1
                for i = 1:length(handles.modified_fileindex)
                    handles.modified_filelist{1,i}=handles.randomizedfilenames{1,handles.modified_fileindex(1,i)};
                end
            else
                for i = 1:length(handles.modified_fileindex)
                    handles.modified_filelist{1,i}=handles.blindfilenames{handles.modified_fileindex(1,i),1};
                end
            end
        else
            groupnum=get(handles.SRPDC_grouplist,'Value');
            if isfield(handles,'currentunblindlist')==1
                handles=rmfield(handles,'currentunblindlist');
            end
            handles.currentunblindlist=handles.groupfiles{groupnum,:,:};
            [~,filenum]=size(handles.currentunblindlist);
            handles.modifiedlocations=regexpi(handles.currentunblindlist,search_string);
            handles.modified_fileindex=find(~cellfun(@isempty,handles.modifiedlocations));
            for i = 1:length(handles.modified_fileindex)
                handles.modified_filelist{1,i}=handles.currentunblindlist{1,handles.modified_fileindex(1,i)};
            end
        end
    set(handles.SRPDC_filelist,'String',handles.modified_filelist);
    if check_customsearch==0
        animalnum=filenum/handles.sessionnum;
        if animalnum~=length(handles.modified_fileindex)
            msgbox('All files must include ''Day#'' or ''day#'' for days 1-4 and ''nov'',''novel'', or ''day5'' for day 5.  Please check your filenames','Error');
            return
        end
    end
else
    if blinddata==1
        revealdata=get(handles.SRPDC_revealnames,'Value');
        if revealdata==1
            set(handles.SRPDC_filelist,'String',handles.randomizedfilenames);
        else
            set(handles.SRPDC_filelist,'String',handles.blindfilenames);
        end
    else
        set(handles.SRPDC_filelist,'String',handles.blindfilenames);
    end
end


function correct_filenum=get_correct_filenum(handles)
if handles.usefilelist==0
    correct_filenum=get(handles.SRPDC_filelist,'Value');
else
    modified_num=get(handles.SRPDC_filelist,'Value');
    correct_filenum=handles.modified_fileindex(1,modified_num);
end
    

function [handles]=thresholdfilelist(handles)
%     handles.modifiedlocations=regexpi(handles.randomizedfilenames,search_string);
%     handles.modified_fileindex=find(~cellfun(@isempty,handles.modifiedlocations));
%     selectedfile=get_correct_filenum(handles);
%     [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
%     handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false);
if handles.appliedthresh==1
    
checkmodified=isfield(handles,'modifiedlocations');
if checkmodified==1
   handles.backup_list_modified=handles.modifiedlocations;
   handles.backup_key_modified=handles.modified_fileindex;
   handles.workinglist_modified=handles.modifiedlocations;
   handles.workingindex_modified=handles.modified_fileindex;
end
   handles.backup_list_real=handles.randomizedfilenames;
   handles.backup_key_real=handles.randomizekey;
   handles.workinglist_real=handles.randomizedfilenames;
   handles.workingindex_real=handles.randomizekey;
   handles.working_listbox_real=handles.blindfilenames;
   handles.backup_listbox_real=handles.blindfilenames;

[~,filenum]=size(handles.workinglist_real);
deletetracker=1;
for currentfile = 1:filenum
    checkfile=handles.workingindex_real(1,currentfile);
    checkvalue=sum(handles.day1threshtracker(checkfile,:));
    if checkvalue == 0
        delete_locations_real(1,deletetracker)=currentfile;
        deletetracker=deletetracker+1;
    end
end
if length(delete_locations_real)==filenum
    msgbox('No files were above current threshold.');
    return;
else
    for deletefile=1:length(delete_locations_real)
        handles.workinglist_real{1,delete_locations_real(1,deletefile)}=[];
        handles.workingindex_real(1,delete_locations_real(1,deletefile))=NaN;
        handles.working_listbox_real{delete_locations_real(1,deletefile),1}=[];
    end
    handles.workinglist_real=handles.workinglist_real(~cellfun('isempty',handles.workinglist_real));
    handles.workingindex_real(:,any(isnan(handles.workingindex_real),1))=[];
    handles.working_listbox_real=handles.working_listbox_real(~cellfun('isempty',handles.working_listbox_real));
end

if checkmodified==1
    true_filelist=handles.workinglist_modified(~cellfun('isempty',handles.workinglist_modified));
    [~,filenum]=size(true_filelist);
    deletetracker=1;
    for currentfile = 1:filenum
        checkfile=handles.workingindex_modified(1,currentfile);
        checkvalue=sum(handles.day1threshtracker(checkfile,:));
        if checkvalue == 0
            delete_locations_modified(1,deletetracker)=currentfile;
            deletetracker=deletetracker+1;
        end
    end
    if length(delete_locations_modified)==filenum
        msgbox('No files were above current threshold.');
        return;
    else
        for deletefile=1:length(delete_locations_modified)
            handles.workinginglist_modified{1,delete_locations_modified(1,deletefile)}=[];
            handles.workingindex_modified(1,delete_locations_modified(1,deletefile))=NaN;
        end
        handles.workinginglist_modified=handles.workinginglist_modified(~cellfun('isempty',handles.workinginglist_modified));
        handles.workingindex_modified(:,any(isnan(handles.workingindex_modified),1))=[];
    end
end

if checkmodified==1
    handles=rmfield(handles,'modifiedlocations');
    handles=rmfield(handles,'modified_fileindex');
    handles.modifiedlocations=handles.workinglist_modified;
    handles.modified_fileindex=handles.workingindex_modified;
end
    handles=rmfield(handles,'randomizedfilenames');
    handles=rmfield(handles,'randomizekey');
    handles=rmfield(handles,'blindfilenames');
    handles.randomizedfilenames=handles.workinglist_real;
    handles.randomizekey=handles.workingindex_real;
    handles.blindfilenames=handles.working_listbox_real;

handles=updatefilelist(handles);
end





% --- Executes on button press in SRPDC_shownovel.
function SRPDC_shownovel_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_shownovel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRPDC_shownovel
handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
else
    selectedfile=get_correct_filenum(handles);
    selectedgroup = get(handles.SRPDC_grouplist,'Value');
    handles=sessionplot(selectedgroup,handles.groupfiles{selectedgroup,1}(1,selectedfile),handles,hObject,0,false,0,0,0);

    
    %Restore session checkboxes or generate default values for this
    %specific file.
    groupname=(handles.groupnames_processedSRP{selectedgroup,1});
    filename=(handles.groupfiles{selectedgroup,1}(1,selectedfile));
    filename=(filename{1,1}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{selectedgroup,1}).(handles.groupfiles{selectedgroup,1}{1,selectedfile}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
%handles=enableuserinput(handles);

guidata(hObject, handles);

function [handles]=clear_gui_plots(handles)
axes(handles.plot_sessions);
cla reset;
axes(handles.plot_dayavg);
cla reset;


% --- Executes on button press in SRPDC_applythresh.
function SRPDC_applythresh_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_applythresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SRP_Options_working=getappdata(0,'SRP_options');
srpdays = str2num(SRP_Options_working{7,2});
threshtracker=1;
[groupnum,~]=size(handles.groupfiles);
sessionnum=handles.sessionnum;
trialnum=handles.trialnum;
windowsize=handles.windowsize;

set(handles.SRPDC_applythresh,'String','Extracting Data');
set(handles.applythresh_background,'BackgroundColor',[1 .6 0]);
drawnow;
for group=1:groupnum
    groupname=handles.groupnames_processedSRP{group,1};
    [~,filenum]=size(handles.groupfiles{group,1});
    ThreshData.(groupname).EventNames=handles.Cleaned_SRPData.(groupname).EventNames;
    for file=1:srpdays:filenum
        file=file+1;
        filename=handles.groupfiles{group,1}(1,file);
        filename=filename{1,1}(1,1:end-4);
        ThreshData.(groupname).(filename)=handles.Cleaned_SRPData.(groupname).(filename);
    end
end

set(handles.SRPDC_applythresh,'String','Calculating Amps');
drawnow;
checkvar=isfield(handles,'day1threshtracker');
if checkvar==1
    backup=handles.day1threshtracker;
    handles=rmfield(handles,'day1threshtracker');
end
for group=1:groupnum
    groupname=handles.groupnames_processedSRP{group,1};
    filelist=fieldnames(ThreshData.(groupname));
    delname='EventNames';
    filelist(strcmp((delname),filelist)) = [];
    filenum=size(filelist);
    for file=1:filenum
       filename=filelist{file,1};

       extractsession_flipRH=sprintf('%s',ThreshData.(groupname).EventNames{2,1});
       extractsession_flopRH=sprintf('%s',ThreshData.(groupname).EventNames{4,1});
       extractsession_flipLH=sprintf('%s',ThreshData.(groupname).EventNames{1,1});  
       extractsession_flopLH=sprintf('%s',ThreshData.(groupname).EventNames{3,1});

       ThreshData.(groupname).(filename)=rmfield(ThreshData.(groupname).(filename),{'MergedWaveFormsL','MergedWaveFormsR','AveragedWaveFormL','AveragedWaveFormR','AmplitudesL','AmplitudesR','Amplitudes'});
       trialtracker=1;
 
       for session=1:sessionnum
	    check_changes_name=sprintf('ThreshData.%s.%s.cleaned_sessions',groupname,filename);
        
            check_changes=exist(check_changes_name);
            
            if check_changes ~=0
                checksessionLH=ThreshData.(groupname).(filename).cleaned_sessions{2,session+1};
                checksessionRH=ThreshData.(groupname).(filename).cleaned_sessions{2,session+1};
            else
                checksessionLH=1;
                checksessionRH=1;
            end
            
            if checksessionLH==0
                ThreshData.(groupname).(filename).(extractsession_flipLH)(session,:,:)=NaN;
                ThreshData.(groupname).(filename).(extractsession_flopLH)(session,:,:)=NaN;
            end
            if checksessionRH==0
                ThreshData.(groupname).(filename).(extractsession_flipRH)(session,:,:)=NaN;
                ThreshData.(groupname).(filename).(extractsession_flopRH)(session,:,:)=NaN;
            end
            for trial=1:trialnum
                ThreshData.(groupname).(filename).MergedWaveFormsL(1,trialtracker,:)=ThreshData.(groupname).(filename).(extractsession_flipLH)(session,trial,:);
                ThreshData.(groupname).(filename).MergedWaveFormsR(1,trialtracker,:)=ThreshData.(groupname).(filename).(extractsession_flipRH)(session,trial,:);
                trialtracker=trialtracker+1;
                ThreshData.(groupname).(filename).MergedWaveFormsL(1,trialtracker,:)=ThreshData.(groupname).(filename).(extractsession_flopLH)(session,trial,:);
                ThreshData.(groupname).(filename).MergedWaveFormsR(1,trialtracker,:)=ThreshData.(groupname).(filename).(extractsession_flopRH)(session,trial,:);
                trialtracker=trialtracker+1;
            end
       end
       
       for datapoint=1:windowsize
           ThreshData.(groupname).(filename).AveragedWaveFormL(1,datapoint)=nanmean(ThreshData.(groupname).(filename).MergedWaveFormsL(1,:,datapoint));
           ThreshData.(groupname).(filename).AveragedWaveFormR(1,datapoint)=nanmean(ThreshData.(groupname).(filename).MergedWaveFormsR(1,:,datapoint));
       end

        
        [minvalL,minlocL]=min(ThreshData.(groupname).(filename).AveragedWaveFormL(1,1:100));
        [maxvalL,maxlocL]=max(ThreshData.(groupname).(filename).AveragedWaveFormL(1,minlocL:250));
        ThreshData.(groupname).(filename).AmplitudesL(1,1)=minvalL;
        ThreshData.(groupname).(filename).AmplitudesL(1,2)=maxvalL;
        
        [minvalR,minlocR]=min(ThreshData.(groupname).(filename).AveragedWaveFormR(1,1:100));
        [maxvalR,maxlocR]=max(ThreshData.(groupname).(filename).AveragedWaveFormR(1,minlocR:250));
        ThreshData.(groupname).(filename).AmplitudesR(1,1)=minvalR;
        ThreshData.(groupname).(filename).AmplitudesR(1,2)=maxvalR;
        
        ThreshData.(groupname).(filename).Amplitudes(1,1)=ThreshData.(groupname).(filename).AmplitudesL(1,2)-ThreshData.(groupname).(filename).AmplitudesL(1,1);
        ThreshData.(groupname).(filename).Amplitudes(1,2)=ThreshData.(groupname).(filename).AmplitudesR(1,2)-ThreshData.(groupname).(filename).AmplitudesR(1,1);
        
    end
    
    EndPlotData{1,1}='File Name';
    maxminL=0;
    maxmaxL=0;
    maxminR=0;
    maxmaxR=0;
    
    for file=1:filenum
        filename=filelist{file,1};
        EndPlotData{file+1,1}=filename;
        referencefilename=filename;
        EventNum=ThreshData.(groupname).(referencefilename).EventNum;
        for event=1:EventNum
            if event < 2
                EndPlotData{1,(event*2)}=sprintf('LH Familiar');
                EndPlotData{1,(event*2+1)}=sprintf('RH Familiar');
                EndPlotData{file+1,(event*2)}=ThreshData.(groupname).(referencefilename).Amplitudes(event,1);%LeftHemisphere
                EndPlotData{file+1,(event*2+1)}=ThreshData.(groupname).(referencefilename).Amplitudes(event,2);%RightHemisphere
            else
                EndPlotData{1,(event*2)}=sprintf('LH Novel');
                EndPlotData{1,(event*2+1)}=sprintf('RH Novel');
                EndPlotData{file+1,(event*2)}=ThreshData.(groupname).(referencefilename).Amplitudes(event,1);%LeftHemisphere
                EndPlotData{file+1,(event*2+1)}=ThreshData.(groupname).(referencefilename).Amplitudes(event,2);%RightHemisphere
            end
        end
    end
    set(handles.SRPDC_applythresh,'String','Making Thresh Var');
    drawnow;
    ThreshData.(groupname).EndPlotData=EndPlotData;  
    clear EndPlotData

    for file=1:filenum
        filename=filelist{file,1};
        if ThreshData.(groupname).EndPlotData{file+1,2}>(handles.day1thresh/1000)
            LH=1;
        else
            LH=0;
        end
        if ThreshData.(groupname).EndPlotData{file+1,3}>(handles.day1thresh/1000)
            RH=1;
        else
            RH=0;
        end
        for i=1:srpdays
            if LH==1
                handles.day1threshtracker(threshtracker,1)=1;
            else
                handles.day1threshtracker(threshtracker,1)=0;
            end
            if RH==1
                handles.day1threshtracker(threshtracker,2)=1;
            else
                handles.day1threshtracker(threshtracker,2)=0;
            end
            threshtracker=threshtracker+1;
        end
    end
end
set(handles.SRPDC_applythresh,'String','Generating new list');
handles.appliedthresh=1;
[handles]=thresholdfilelist(handles);
set(handles.SRPDC_applythresh,'String','Apply Day 1 Thresholds');
set(handles.applythresh_background,'BackgroundColor',[0 1 0]);

handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
set(handles.SRPDC_filelist,'Value',1);
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end
guidata(hObject, handles);
 

% --- Executes on button press in SRPDC_removethresh.
function SRPDC_removethresh_Callback(hObject, eventdata, handles)
% hObject    handle to SRPDC_removethresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

listbox_groups=fieldnames(handles.MasterSRPData);

%There are some fields that are not group names (and will thus
%give us an innacurate group number) so we delete them
%here.
delname1='GroupNames';
delname2='SrpThresh';
delname3='srpdays';
delname4='AmpGain';
delname5='grpcolors';
listbox_groups(strcmp((delname1),listbox_groups)) = [];
listbox_groups(strcmp((delname2),listbox_groups)) = [];
listbox_groups(strcmp((delname3),listbox_groups)) = [];
listbox_groups(strcmp((delname4),listbox_groups)) = [];
listbox_groups(strcmp((delname5),listbox_groups)) = [];

[groupnum ~]=size(listbox_groups);
filetracker=1;
for i = 1:groupnum
    groupfile_length=length(handles.groupfiles_processed{i,:,:});
    SRP_Options_working=getappdata(0,'SRP_options');
    srpdays = str2num(SRP_Options_working{7,2});
    if i == 1
        for j=1:srpdays:groupfile_length
            for day=1:srpdays
                handles.day1threshtracker(filetracker,1)=1;
                handles.day1threshtracker(filetracker,2)=1;
                filetracker=filetracker+1;
            end
        end
    else
         for j=1:srpdays:groupfile_length
            for day=1:srpdays
                handles.day1threshtracker(filetracker,1)=1;
                handles.day1threshtracker(filetracker,2)=1;
                filetracker=filetracker+1;
            end
         end
    end
end
if handles.appliedthresh==1
    checkmodified=isfield(handles,'backup_list_modified');
    if checkmodified==1
       checkmodified_specific=isfield(handles,'modifiedlocations');
       if checkmodified_specific==1
           handles=rmfield(handles,'modifiedlocations');
           handles=rmfield(handles,'modified_fileindex');
           handles.modifiedlocations=handles.backup_list_modified;
           handles.modified_fileindex=handles.backup_key_modified;
       end
       handles=rmfield(handles,'backup_list_modified');
       handles=rmfield(handles,'backup_key_modified');
    end
        handles=rmfield(handles,'randomizedfilenames');
        handles=rmfield(handles,'randomizekey');
        handles=rmfield(handles,'blindfilenames');
        handles.randomizedfilenames=handles.backup_list_real;
        handles.randomizekey=handles.backup_key_real; 
        handles.blindfilenames=handles.backup_listbox_real;
        handles=rmfield(handles,'backup_list_real');
        handles=rmfield(handles,'backup_key_real');
        handles=rmfield(handles,'backup_listbox_real');
end
handles.appliedthresh=0;
handles=updatefilelist(handles);
set(handles.applythresh_background,'BackgroundColor',[1 0 0]);

set(handles.SRPDC_filelist,'Value',1);
handles=disableuserinput(handles);
blinddata=get(handles.SRPDC_blind_data,'Value');
if blinddata==1
    selectedfile=get_correct_filenum(handles);
    [truefilenum,truegroup]=blindfunction_findfilenameinfo(selectedfile,handles);
    handles=sessionplot(truegroup,truefilenum,handles,hObject,0,false,0,0,0);
    groupname=(handles.groupnames_processedSRP{truegroup,1});
    filename=(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4));
    if isfield(handles.Cleaned_SRPData.(handles.groupnames_processedSRP{truegroup,1}).(handles.groupfiles{truegroup,1}{1,truefilenum}(1,1:end-4)),'cleaned_sessions')==0
        handles=session_boxes(1,groupname,filename,handles);
    else
        handles=session_boxes(0,groupname,filename,handles);
    end
end


guidata(hObject, handles);


function day1_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to day1_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of day1_thresh as text
%        str2double(get(hObject,'String')) returns contents of day1_thresh as a double
userinput=get(hObject,'String');
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String','1'); 
            handles.day1thresh=1;
            set(hObject,'Backgroundcolor','r');
        else
            handles.error=handles.error-1;
            set(hObject,'Backgroundcolor','g');
            handles.day1thresh=str2num(userinput);
        end
    else
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String','1'); 
                handles.day1thresh=1;
                set(hObject,'Backgroundcolor','r');
            else
                set(hObject,'Backgroundcolor','g');
                handles.day1thresh=str2num(userinput);
            end

    end
    guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function day1_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to day1_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function amp_slider_topleft_Callback(hObject, eventdata, handles)
% hObject    handle to amp_slider_topleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function amp_slider_topleft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_slider_topleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function amp_slider_topright_Callback(hObject, eventdata, handles)
% hObject    handle to amp_slider_topright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if handles.separateflipflops == 0
    slider_loc=round(get(hObject,'Value'));
    if slider_loc==0
        slider_loc=1;
    end
    if slider_loc > 495
        slider_loc=495;
    end
    axes(handles.plot_dayavg);
    cla reset;
    waveform=handles.plot_dayavgData;
    [minval,minloc,maxval,truemaxloc,amplitude]=ident_amplitude(waveform,1,slider_loc,handles.minloc,1);
    handles.minloc=minloc;
    handles.maxloc=truemaxloc;
    hold on
    %specifiy min peak with blue +
    plot(minloc,minval,'+','Color','blue');
    %specify max peak with red +
    plot(truemaxloc,maxval,'+','Color','red');
    %Output amplitude information to user.
    amplitudetxt=sprintf('Amplitude: %s microVolts',num2str(amplitude));
    set(handles.SRPDC_amplitude_txt,'String',amplitudetxt);
    
    plot(waveform,'Color','black','LineWidth',1);
    
                time_neg=minloc/1000;
            time_pos=truemaxloc/1000;
            postimetxt=sprintf('Stim-To-Pos: %s ms',num2str(time_pos));
            set(handles.postime,'String',postimetxt);
            negtimetxt=sprintf('Stim-To-Neg: %s ms',num2str(time_neg));
            set(handles.negtime,'String',negtimetxt);  
    drawnow;
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function amp_slider_topright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_slider_topright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function amp_slider_bottomleft_Callback(hObject, eventdata, handles)
% hObject    handle to amp_slider_bottomleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function amp_slider_bottomleft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_slider_bottomleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function amp_slider_bottomright_Callback(hObject, eventdata, handles)
% hObject    handle to amp_slider_bottomright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if handles.separateflipflops == 0
    slider_loc=round(get(hObject,'Value'));
    if slider_loc<=0
        slider_loc=1;
    end
    if slider_loc > 495
        slider_loc=495;
    end
    axes(handles.plot_dayavg);
    cla reset;
    waveform=handles.plot_dayavgData;
    [minval,minloc,maxval,truemaxloc,amplitude]=ident_amplitude(waveform,1,slider_loc,handles.maxloc,2);
    handles.minloc=minloc;
    handles.maxloc=truemaxloc;
    hold on
    %specifiy min peak with blue +
    plot(minloc,minval,'+','Color','blue');
    %specify max peak with red +
    plot(truemaxloc,maxval,'+','Color','red');
    %Output amplitude information to user.
    amplitudetxt=sprintf('Amplitude: %s microVolts',num2str(amplitude));
    set(handles.SRPDC_amplitude_txt,'String',amplitudetxt);
     plot(waveform,'Color','black','LineWidth',1);
                time_neg=minloc/1000;
            time_pos=truemaxloc/1000;
            postimetxt=sprintf('Stim-To-Pos: %s ms',num2str(time_pos));
            set(handles.postime,'String',postimetxt);
            negtimetxt=sprintf('Stim-To-Neg: %s ms',num2str(time_neg));
            set(handles.negtime,'String',negtimetxt);  
    drawnow;
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function amp_slider_bottomright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_slider_bottomright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function [minval,minloc,maxval,truemaxloc,amplitude]=ident_amplitude(waveform_data,user_select,loc1,loc2,slidernum)
    if user_select==0
            %Based on the known physiological profile of a VEP, we can
            %predict where the peak will appear and use that information to
            %refine our algorithm.
            
            %The negative peak should always appear within the first 100ms.
            % Currently, if the user changes their sampling frequency, it
            % will mess up this algorithm.  I need to correct this for the
            % future.
            [minval,minloc]=min(waveform_data(1,1:100));
            [maxval,maxloc]=max(waveform_data(1,minloc:250));
            %the maxloc value returned has been adjusted such that minloc
            %is 1.  Example, minloc=241... 241:250   If the positive peak
            %was located at 245, maxloc would return a value of 5.  We must
            %adjust this value based on maxloc.  We must subtract this
            %value by 1 though... EXAMPLE:
            %Real location = 245
            %Minloc=241
            %Maxloc=5
            %Minloc+Maxloc-1=241+5-1=245
            truemaxloc=maxloc+minloc-1;
            %calculate amplitude with maxval - minval
            amplitude=maxval-minval;
            %Need to fix amplitude to use user-specified gain value instead
            %of using 1000.  Amplitude is adjusted here to account for gain
            %adjustment.
            amplitude=amplitude*1000;
    else
            %Based on the known physiological profile of a VEP, we can
            %predict where the peak will appear and use that information to
            %refine our algorithm.
            
            %The negative peak should always appear within the first 100ms.
            % Currently, if the user changes their sampling frequency, it
            % will mess up this algorithm.  I need to correct this for the
            % future.
            if slidernum == 1
                maxloc=loc1;
                minloc=loc2;
            elseif slidernum == 2
                minloc=loc1;
                maxloc=loc2;
            end
            maxval=waveform_data(1,maxloc);
            minval=waveform_data(1,minloc);
           
            truemaxloc=maxloc;
            %calculate amplitude with maxval - minval
            amplitude=maxval-minval;
            %Need to fix amplitude to use user-specified gain value instead
            %of using 1000.  Amplitude is adjusted here to account for gain
            %adjustment.
            amplitude=amplitude*1000;
    end

function varargout = ContrastAnalysis_Master(varargin)
% CONTRASTANALYSIS_MASTER MATLAB code for ContrastAnalysis_Master.fig
%      CONTRASTANALYSIS_MASTER, by itself, creates a new CONTRASTANALYSIS_MASTER or raises the existing
%      singleton*.
%
%      H = CONTRASTANALYSIS_MASTER returns the handle to a new CONTRASTANALYSIS_MASTER or the handle to
%      the existing singleton*.
%
%      CONTRASTANALYSIS_MASTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTRASTANALYSIS_MASTER.M with the given input arguments.
%
%      CONTRASTANALYSIS_MASTER('Property','Value',...) creates a new CONTRASTANALYSIS_MASTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContrastAnalysis_Master_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContrastAnalysis_Master_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContrastAnalysis_Master

% Last Modified by GUIDE v2.5 18-Mar-2015 14:06:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContrastAnalysis_Master_OpeningFcn, ...
                   'gui_OutputFcn',  @ContrastAnalysis_Master_OutputFcn, ...
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


% --- Executes just before ContrastAnalysis_Master is made visible.
function ContrastAnalysis_Master_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContrastAnalysis_Master (see VARARGIN)

% Choose default command line output for ContrastAnalysis_Master
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% UIWAIT makes ContrastAnalysis_Master wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContrastAnalysis_Master_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function modified_closefcn(hObject, eventdata, handles)
currentprogs=getappdata(0,'RunningPrograms');
indicatornames=getappdata(0,'ProgramNames');
currentprogs(1,3)=0;
setappdata(0,'RunningPrograms',currentprogs);
AnalysisHandles = guidata(AnalysisProgram);
set(AnalysisHandles.(indicatornames{1,3}),'Backgroundcolor','r');
delete(hObject); 


% --- Executes on button press in ContrastOptionsButton.
function ContrastOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to ContrastOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ContrastOptions_General
setappdata(0,'CO_options_confirmed',1);
set(handles.ContrastSettingsIndicator,'Backgroundcolor',[1 .6 0]);


% --- Executes on button press in GroupOptionsButton.
function GroupOptionsButton_Callback(hObject, eventdata, handles)
% hObject    handle to GroupOptionsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GroupOptions_Contrast
setappdata(0,'Group_options_confirmed',1);
set(handles.GroupSettingsIndicator,'Backgroundcolor',[1 .6 0]);

% --- Executes on button press in ClearDataButton.
function ClearDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClearDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 handles=rmfield(handles,'MainStructure'); 
%     checkprocessed=get(handles.plot_loaded,'Visible');
%     if strcmp(checkprocessed,'off')
%         set(handles.Contrast_plotoptions_text,'BackgroundColor',[1 0 0]);
%         set(handles.Contrast_plotoptions_text,'String','No Data Available');
%         handles.processed_loaded=0;
%     end
%  set(handles.plot_processed,'Visible','off');
 guidata(hObject, handles);

% --- Executes on button press in ProcessDataButton.
function ProcessDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to Contrast_run_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.contrast_workload,'Backgroundcolor',[0 1 0]);

% normoxickey=[1 1;1 0;1 0;1 0;1 0;1 0;1 0];
% hypoxickey=[1 1;1 1;1 0;1 1;1 1;1 0;1 1];

normoxickey=[1 0;1 1;1 1;1 1;1 1;1 1];
hypoxickey=[1 1;1 1;1 1;1 1;1 1;1 1;1 0];
keyon=0;
%handles=buttons_off(hObject,handles);
drawnow;
%Load Contrast Related Options
Contrast_Options_working=getappdata(0,'CO_options');
%1-3 (binoc,leye,reye)
%4 vidget
%5 extract all waveform amplitudes
%6 Contrast threshold
%7 Contrast days
%8 num flips (not currently used... for future functionality)
%9 num flops (not currently used... for future functionality)
%10 num trials
%11 maximum number of events encountered through the data processing
%12 week 2 Contrast check
%13 Vidget pre start time
%14 Vidget post start time
Contrast_GroupOptions_working=getappdata(0,'Contrast_group_options');
%1 total group number
%2-6 group names for groups 1 - 5
%7-11 group colors for groups 1 - 5
%12 group 1 file names
%13 group 1 pathname
%14 group 2 filenames
%15 group 2 pathnames
%17 group 3 filenames
%18 group 3 pathnames
%19 group 4 filenames
%20 group 4 pathnames
%21 group 5 filenames
%22 group 5 pathnames
General_Options_working=getappdata(0,'GS_options');
%1 recording frequency
%2 gain setting used for recording
%3 total channels in data files
%4 left hemisphere channel #
%5 right hemisphere channel #
%6 vidget channel #
%7 strobe channel #
%8 event 1 channel #
%9 event 2 channel #
%10 event 3 channel #
%11 event 4 channel #
%12 event 1 binary conversion threshold
%13 event 2 binary conversion threshold
%14 event 3 binary conversion threshold
%15 event 4 binary conversion threshold
%16 binary converted strobe channel (in the newly created binary structure)
%17 binary converted event 1 channel (in the newly created binary structure)
%18 binary converted event 2 channel (in the newly created binary structure)
%19 binary converted event 3 channel (in the newly created binary structure)
%20 binary converted event 4 channel (in the newly created binary structure)
%21 normalize extracted waveforms
%22 confirm threshold
%23 strobe binary conversion threshold
%24 total digital channels (in the newly created binary structure)

%Load Options
AmpGain = str2num(General_Options_working{2,2});
ContrastThresh = str2num(Contrast_Options_working{2,2});
NUM_events = 4; %There are always going to be 4 event channels for now
StrobeThresh = str2num(General_Options_working{23,2});
StrobeDig = str2num(General_Options_working{16,2});
StrobeChannel = str2num(General_Options_working{7,2});
VidgetChannel = str2num(General_Options_working{6,2});

EventChan1Thresh = str2num(General_Options_working{12,2});
Event1Dig = str2num(General_Options_working{17,2});
EventChan1 = str2num(General_Options_working{8,2});

EventChan2Thresh = str2num(General_Options_working{13,2});
Event2Dig = str2num(General_Options_working{18,2});
EventChan2 = str2num(General_Options_working{9,2});

EventChan3Thresh = str2num(General_Options_working{14,2});
Event3Dig = str2num(General_Options_working{19,2});
EventChan3 = str2num(General_Options_working{10,2});

EventChan4Thresh = str2num(General_Options_working{15,2});
Event4Dig = str2num(General_Options_working{20,2});
EventChan4 = str2num(General_Options_working{11,2});

totalgroups = str2num(Contrast_GroupOptions_working{1,2});

TotalChans = str2num(General_Options_working{3,2});
TotalDigitalChans = str2num(General_Options_working{24,2});
RecordingFreq = str2num(General_Options_working{1,2});
NormalizedAmplitudes = General_Options_working{21,2};


ShowMergedContrast=1;
ShowLHemiContrast=0;
ShowRHemiContrast=0;
ContrastThresh=140;
DetectContrastPeakWin=[-2,30];

%Contrast SETTINGS (Default De-Coding Ruleset)
ContrastCodes=Contrast_Options_working{9,2};
%                 .05 .1  .2  .3  .4    .5    .6    .7
ContrastEventCodes=Contrast_Options_working{10,2};
ContrastSF={'.05'};
MaximumContrastEvent=1;%Based on Contrast code location of expected maximum response.




%START OF ANALYSIS CODE
GroupNames{1,1}=Contrast_GroupOptions_working{2,2};
GroupNames{1,2}=Contrast_GroupOptions_working{3,2};
GroupNames{1,3}=Contrast_GroupOptions_working{4,2};
GroupNames{1,4}=Contrast_GroupOptions_working{5,2};
GroupNames{1,5}=Contrast_GroupOptions_working{6,2};

for groupnum=1:totalgroups
    grpcolors(groupnum,:)=Contrast_GroupOptions_working{groupnum+6,2};
    %7-11 group colors for groups 1 - 5
    clear totalfiles groupfiles pathname
    GroupName=GroupNames{1,groupnum};
    %Determine total animals in each group as we loop through the groups
    
    groupfiles=Contrast_GroupOptions_working{10+2*groupnum,2}; %10+2*groupnum offsets for how data is stored in structure.
    totalfiles=length(groupfiles);
    animalnum(1,groupnum)=totalfiles;
    
    pathname=Contrast_GroupOptions_working{11+2*groupnum,2};
    %matlabpool ('open',8);
    for filenum=1:totalfiles
        output=sprintf('Processing Group (%s/%s) File (%s/%s)',num2str(groupnum),num2str(totalgroups),num2str(filenum),num2str(totalfiles));
        set(handles.contrast_workload,'String',output);
        drawnow;
        combofilename=sprintf('%s%s',pathname,groupfiles{1,filenum});
        fileID = fopen(combofilename);
        A = fread(fileID,inf,'float');
        filelength=length(A);
        clear A;
        Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
        fclose(fileID);

        DataLength=length(Data);
        DigitalChans=zeros(TotalDigitalChans,DataLength);
    
        %Generate Timepoint Vector

        TimeStep=1/RecordingFreq;
        Timepoints=zeros(1,DataLength); %Empty vector of timepoints in seconds
        for i=1:DataLength
           if i==1
               Timepoints(1,1)=TimeStep;
           else
               Timepoints(1,i)=Timepoints(1,i-1)+TimeStep;
           end
        end
        
                %Convert the analog strobe channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,StrobeChannel) < StrobeThresh
               DigitalChans(StrobeDig,i)=0;
           else
               DigitalChans(StrobeDig,i)=1;
           end
        end

        %Convert the analog event1 channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,EventChan1) < EventChan1Thresh
               DigitalChans(Event1Dig,i)=0;
           else
               DigitalChans(Event1Dig,i)=1;
           end
        end

        %Convert the analog event2 channel to a digital channel for easier event
        %timepoint extraction
        for i = 1:DataLength
           if Data(1,i,EventChan2) < EventChan2Thresh
               DigitalChans(Event2Dig,i)=0;
           else
               DigitalChans(Event2Dig,i)=1;
           end
        end

        for i = 1:DataLength
           if Data(1,i,EventChan3) < EventChan3Thresh
               DigitalChans(Event3Dig,i)=0;
           else
               DigitalChans(Event3Dig,i)=1;
           end
        end
        if NUM_events == 4
        for i = 1:DataLength
           if Data(1,i,EventChan4) < EventChan4Thresh
               DigitalChans(Event4Dig,i)=0;
           else
               DigitalChans(Event4Dig,i)=1;
           end
        end
        end

        ActiveEventChans=zeros(1,NUM_events);
        for i=1:4
           if max(DigitalChans(i+1,:)) == 1
               ActiveEventChans(1,i)=1;
           end
        end
        

        tracervalue=1;
        for i = 2:length(Data(1,1:end,1))
            if DigitalChans(Event1Dig,i-1)==0 && DigitalChans(Event1Dig,i)==1
                FlipFlopPoints(1,tracervalue)=i;
                tracervalue=tracervalue+1;
            elseif DigitalChans(Event1Dig,i-1)==1 && DigitalChans(Event1Dig,i)==0
                FlipFlopPoints(1,tracervalue)=i;
                tracervalue=tracervalue+1;
            end
        end
        EventTracker=1;
        tracervalue=1;        
        for i=2:2:length(FlipFlopPoints)
            if FlipFlopPoints(i) < length(Data(1,1:end,1))
                FlipFlopDiffs(1,tracervalue)=Timepoints(1,FlipFlopPoints(i))-Timepoints(1,FlipFlopPoints(i-1));
                tracervalue=tracervalue+1;
            end 
        end
        
        OffsetRegionStart=find(FlipFlopDiffs < (mean(FlipFlopDiffs)-.01));
        ErrorCheckOffsetRegionStart=OffsetRegionStart;
        
        delcleanup=true;
        while delcleanup==true
            deltrack=1;
            clear deloffset
            for i=1:length(OffsetRegionStart)-1
               if OffsetRegionStart(i+1)-OffsetRegionStart(i) < 98
                   deloffset(deltrack)=i+1;
                   deltrack=deltrack+1;
               end
            end

            if ~exist('deloffset')
                delcleanup=false;
            else
                OffsetRegionStart(deloffset(1))=[];
            end
        end
        
        CorrectionIndex=zeros(1,length(OffsetRegionStart));
        for i=1:length(OffsetRegionStart)
           doloop=1;
           CorrectedRegionStart(1,i)=OffsetRegionStart(1,i)*2;
           startcheck=FlipFlopPoints(1,CorrectedRegionStart(1,i)-1);
            while doloop==1
               if DigitalChans(StrobeDig,(startcheck-CorrectionIndex(1,i)))==0 && i ~= 1
                    CorrectionIndex(1,i)=CorrectionIndex(1,i)+1;
               else
                    doloop=0;
                    jittercorrect=5;
               end
           end
           FlipFlopCorrection=startcheck-CorrectionIndex(1,i);
           CorrectedRegionStart(1,i)=CorrectedRegionStart(1,i)-1;
           FlipFlopPoints(1,CorrectedRegionStart(1,i))=FlipFlopCorrection+jittercorrect;
           if i==1
               %DoNothing
           else
                StopPoints(1,i-1)=Timepoints(1,FlipFlopPoints(1,CorrectedRegionStart(1,i)-1));
           end
        end
        WindowSize=length(Timepoints(FlipFlopPoints(1,3):FlipFlopPoints(1,4)))-5;
        if rem(WindowSize,2)~=1
            WindowSize=WindowSize-1; %Smaller size so we don't go outside the bounding box (FlipFlopPoints)
        end
        if WindowSize ~= 495
            WindowSize=495;
        end
        WindowNum=1;
        clear RegionSmallWin
        clear MergedWaveForm
        for i=1:length(CorrectedRegionStart)
            if i < length(CorrectedRegionStart)
                Start=CorrectedRegionStart(i);
                Stop=CorrectedRegionStart(i+1)-1;
            else
                Start=CorrectedRegionStart(i);
                Stop=length(FlipFlopPoints);
            end
            WindowNum=1;
            Tracker=struct();
            for j=Start:Stop
                if i > 1
                    OldEventSum=EventSum;
                end
                EventSum=0;
                originalJ=FlipFlopPoints(j);
                LeftTrack=0;
                RightTrack=0;
                Showerror=0;
                debugtracker=1;

                while EventSum==0
                    if any(CorrectedRegionStart==j)
                        EventLocation=FlipFlopPoints(j)+CorrectionIndex(1,i)+10;
                    else
                        EventLocation=FlipFlopPoints(j)+10;
                    end
                    if DigitalChans(Event1Dig,EventLocation)==1
                        EventSum=EventSum+1;
                    end
                    if DigitalChans(Event2Dig,EventLocation)==1
                        EventSum=EventSum+2;
                    end
                    if DigitalChans(Event3Dig,EventLocation)==1
                        EventSum=EventSum+4;
                    end
                    if NUM_events==4
                        if DigitalChans(Event4Dig,EventLocation)==1
                            EventSum=EventSum+8;
                        end
                    end
                    if EventSum==0
                        if i > 1 && OldEventSum ~= 15
                            if LeftTrack < 5
                                FlipFlopPoints(j)=FlipFlopPoints(j)-10; %will need to change 20 to reflect a percent of the current recording frequency. 
                                LeftTrack=LeftTrack+1;
                            else
                                if RightTrack==0
                                    FlipFlopPoints(j)=originalJ;
                                end
                                FlipFlopPoints(j)=FlipFlopPoints(j)+10;
                                RightTrack=RightTrack+1;
                            end
                            if RightTrack>5
                                errormsg=sprintf('Error:Could not find session start at location %s',num2str(originalJ));
                                errordlg(errormsg,'Error');
                                return;
                            end
                        else
                        	EventSum=16;
                        end
                    end
                end
                if j==Start
                    if WindowSize ~= 495
                        error('windowsize must be 495, baseline lfp code must be modified to support different windowsizes.');
                    end
                    if i==1
                        baselinetracker=1;
                        if FlipFlopPoints(j) > 100001
                            for baseindex=(FlipFlopPoints(j)-100000):495:(FlipFlopPoints(j)-1000)
                                if NormalizedAmplitudes==0
                                    baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1);
                                    baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2);
                                    baselinetracker=baselinetracker+1;
                                else
                                    baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+494,1));
                                    baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+494,2));
                                    baselinetracker=baselinetracker+1;
                                end
                            end
                            for avgbaseindex=1:495
                                avgbaselineLH(1,avgbaseindex)=mean(baselineLH(:,avgbaseindex));
                                avgbaselineRH(1,avgbaseindex)=mean(baselineRH(:,avgbaseindex));
                        	end
                        else
                            Remainder=1;
                            NewBlock=FlipFlopPoints(j);
                            while Remainder==1;
                                Remainder=rem(NewBlock,495);
                                if Remainder~=0
                                    NewBlock=NewBlock-1;
                                end
                            end
                            for baseindex=1:495:NewBlock
                                if NormalizedAmplitudes==0
                                    baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1);
                                    baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2);
                                    baselinetracker=baselinetracker+1;
                                else
                                    baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+494,1));
                                    baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+494,2));
                                    baselinetracker=baselinetracker+1;
                                end
                            end
                            for avgbaseindex=1:495
                                avgbaselineLH(1,avgbaseindex)=mean(baselineLH(:,avgbaseindex));
                                avgbaselineRH(1,avgbaseindex)=mean(baselineRH(:,avgbaseindex));
                            end
                        end
                    end
                    ActualLocation=FlipFlopPoints(j);

                end

                WavNameL=sprintf('E%sL',num2str(EventSum));
                WavNameR=sprintf('E%sR',num2str(EventSum));
                WavNameTimes=sprintf('E%sTimes',num2str(EventSum));
                WavNameLocs=sprintf('E%sLocs',num2str(EventSum));
                if filenum==3
                    debug=true;
                end
                if strcmp('E0L',WavNameL)
                    debug=1;
                end
                if i==3
                    debug=2;
                end
                if ~any(strcmp(WavNameL,fieldnames(Tracker)))
                    Tracker.(WavNameL)(1,1)=1;
                end
                if ~any(strcmp(WavNameR,fieldnames(Tracker)))
                    Tracker.(WavNameR)(1,1)=1;
                end

                if EventTracker==1
                    if mod(EventSum,2)==0
                        EventSum=EventSum-1;
                        WavNameL=sprintf('E%sL',num2str(EventSum));
                        WavNameR=sprintf('E%sR',num2str(EventSum));
                        WavNameTimes=sprintf('E%sTimes',num2str(EventSum));
                        WavNameLocs=sprintf('E%sLocs',num2str(EventSum));
                        Tracker.(WavNameL)(1,1)=1;
                        Tracker.(WavNameR)(1,1)=1;
                        
                        EventChart(1,1)=EventSum;
                        LocationChart(1,1)=1;
                        EventTracker=EventTracker+1;
                        correct_event_error=1;
                        
                    else
                        correct_event_error=0;
                        EventChart(1,1)=EventSum;
                        LocationChart(1,1)=1;
                        EventTracker=EventTracker+1;
                    end
                else
                    if mod(EventSum,2)~=0
                        if any(EventChart==EventSum)
                            %DoNothing
                        else
                            EventChart(1,EventTracker)=EventSum;
                            LocationChart(1,EventTracker)=1;
                            EventTracker=EventTracker+1;
                        end
                    end
                end

                if mod(EventSum,2)==0
                    TempSum=EventSum-1;
                    locspot=find(EventChart==TempSum);
                else
                    TempSum=EventSum;
                    locspot=find(EventChart==TempSum);
                end

                if LocationChart(1,locspot)==6
                    debug=1;
                end
                if correct_event_error==1
                    ActualLocation=FlipFlopPoints(j)-WindowSize;
                    EndLocation=FlipFlopPoints(j)-1;
                    j=j-1;
                    correct_event_error=0;
                else
                    ActualLocation=FlipFlopPoints(j);
                    EndLocation=FlipFlopPoints(j)+WindowSize-1;
                end
                if NormalizedAmplitudes==0
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1);
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2);
                else
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameL)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,1)-mean(Data(1,ActualLocation:EndLocation,1));
                    handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameR)(LocationChart(1,locspot),Tracker.(WavNameR)(1,1),1:WindowSize)=Data(1,ActualLocation:EndLocation,2)-mean(Data(1,ActualLocation:EndLocation,2));
                end

                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameTimes)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=Timepoints(ActualLocation:EndLocation);
                handles.MainStructure.(GroupName).(groupfiles{1,filenum}(1,1:end-4)).(WavNameLocs)(LocationChart(1,locspot),Tracker.(WavNameL)(1,1),1:WindowSize)=ActualLocation:EndLocation;

                if Data(1,ActualLocation,1)==0 || Data(1,ActualLocation,2)==0
                    debug=1;
                end


                Tracker.(WavNameL)(1,1)=Tracker.(WavNameL)(1,1)+1;
                Tracker.(WavNameR)(1,1)=Tracker.(WavNameR)(1,1)+1;

                WindowNum=WindowNum+1;

            end
            LocationChart(1,locspot)=LocationChart(1,locspot)+1;
        end

        hrtz=RecordingFreq;
clear CorrectedRegionStart CorrectionIndex TimeStep ActualLocation ActiveEventChans OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect startcheck Data tracervalue FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot
    end
clear CorrectedRegionStart CorrectionIndex ActiveEventChans ActualLocation TimeStep OldEventSum TempSum StopPoints Stop Start StartExtract Timepoints jittercorrect Data tracervalue startcheck FlipFlopPoints OffsetRegionStart FlipFlopDiffs deloffset Tracker EventChart LocationChart locspot   
totalplots=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output=sprintf('Group %s Processed, Generating Variables...',num2str(groupnum));
set(handles.contrast_workload,'String',output);
drawnow;


 [alphamax ~]=size(fieldnames(handles.MainStructure.(GroupName)));
    for alpha=1:alphamax

        EventNames=fieldnames(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)));
        [remnamesize ~]=size(EventNames);
        for alphaA=1:(remnamesize/4)
           delname1=sprintf('E%sTimes',num2str(alphaA));
           delname2=sprintf('E%sLocs',num2str(alphaA));
           EventNames(strcmp((delname1),EventNames)) = [];
           EventNames(strcmp((delname2),EventNames)) = [];
        end
        [betamax ~]=size(EventNames);
        clear EventNames
        resorttrack=1;
        %ContrastEventCodes=[1 2;3 4;5 6;7 8;9 10;11 12;13 14;15 16];
        %<ContrastSpecific>
        for betaA=1:(betamax/4)
           EventNames{resorttrack,1}=sprintf('E%sL',num2str(ContrastEventCodes{1,betaA}));
           resorttrack=resorttrack+1;
           EventNames{resorttrack,1}=sprintf('E%sR',num2str(ContrastEventCodes{1,betaA}));
           resorttrack=resorttrack+1;
           EventNames{resorttrack,1}=sprintf('E%sL',num2str(ContrastEventCodes{2,betaA}));
           resorttrack=resorttrack+1;
           EventNames{resorttrack,1}=sprintf('E%sR',num2str(ContrastEventCodes{2,betaA}));
           resorttrack=resorttrack+1;
        end
        %</ContrastSpecific>
        [sessions trials WindowSize]=size(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{1,1}));
        EventNum=0;
        totalplots=betamax/2+totalplots;
        for betaA=1:4:betamax

            EventNum=EventNum+1;
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum=EventNum;
                        trialtrackerL=1;
                        trialtrackerR=1;
                    for BetaC=1:sessions
                        for BetaD=1:trials
                            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                            %All EventNameChecker's are for debugging.
                            %handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNameCheckerL{EventNum,trialtrackerL}=EventNames{betaA,1};
                            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+1),1})(BetaC,BetaD,1:WindowSize);
                            %handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNameCheckerR{EventNum,trialtrackerR}=EventNames{(betaA+1),1};
                            trialtrackerL=trialtrackerL+1;
                            trialtrackerR=trialtrackerR+1;
                            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+2),1})(BetaC,BetaD,1:WindowSize);
                            %handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNameCheckerL{EventNum,trialtrackerL}=EventNames{(betaA+2),1};
                            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+3),1})(BetaC,BetaD,1:WindowSize);
                            %handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNameCheckerR{EventNum,trialtrackerR}=EventNames{(betaA+3),1};
                            trialtrackerL=trialtrackerL+1;
                            trialtrackerR=trialtrackerR+1;
                        end
                    end
            for betaB=1:WindowSize
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,1:trialtrackerL-1,betaB));
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,1:trialtrackerR-1,betaB));
            end
                %<ContrastSpecific>
%                 if groupnum==1
%                    clear keyfile
%                    key=normoxickey;
%                 else
%                     clear keyfile
%                     key=hypoxickey;
%                 end
                if EventNum==1
                    %Determine Window Size (using best Contrast average waveform)
                    clear TemplatePeakL TemplatePeakR
                    TemplatePeakL=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(MaximumContrastEvent,1:WindowSize)));
                    TemplatePeakR=min(min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(MaximumContrastEvent,1:WindowSize)));
                    ContrastReferencePeakL=find(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(MaximumContrastEvent,1:WindowSize)==TemplatePeakL);
                    ContrastReferencePeakR=find(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(MaximumContrastEvent,1:WindowSize)==TemplatePeakR);
                    
                    Contrast_LH_Min=(ContrastReferencePeakL+(round((DetectContrastPeakWin(1,1)/100)*WindowSize)));
                    Contrast_LH_Max=(ContrastReferencePeakL+(round((DetectContrastPeakWin(1,2)/100)*WindowSize)));
                    Contrast_RH_Min=(ContrastReferencePeakR+(round((DetectContrastPeakWin(1,1)/100)*WindowSize)));
                    Contrast_RH_Max=(ContrastReferencePeakR+(round((DetectContrastPeakWin(1,2)/100)*WindowSize)));
                   
                    ContrastWindowL=[Contrast_LH_Min Contrast_LH_Max];
                    ContrastWindowR=[Contrast_LH_Min Contrast_LH_Max];
                    %End of Window Size Code
                    [minvalL,minlocL]=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,41:60));
                    minlocL=minlocL+ContrastWindowL(1,1)-1;
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=minvalL;
                    
                    [minvalR,minlocR]=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,41:60));
                    minlocR=minlocR+ContrastWindowR(1,1)-1;
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=minvalR;
                    
                    [maxvalR,maxlocR]=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,80:490));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=maxvalR;
                    
                    [maxvalL,maxlocL]=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,80:490));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=maxvalL;
                    
%                     if key(alpha,1)==1 || keyon==0
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
%                     else
%                         handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=NaN;
%                     end

                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1);  
%                     else
%                         handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=NaN;
%                     end
                    
                else
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,41:60));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,41:60));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,80:490));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,80:490));
                    
%                     if key(alpha,1)==1 || keyon==0
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
%                     else
%                         handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=NaN;
%                     end
                    
%                     if key(alpha,2)==1 || keyon==0
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1); 
%                     else
%                         handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=NaN;
%                     end
                end
                %</ContrastSpecific>
        end
    end

        amplitudetrack=1;
        amplitudeloc=ones(1,EventNum);
        %EventNames<events,1>
        clear AnimalAveragesL AnimalAveragesR
        for alpha=1:alphamax
            EventNum=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum;
            clear EventNameList
            for eventindex=1:2:(EventNum*2)
               FlipL=sprintf('E%sL',num2str(eventindex));
               FlipR=sprintf('E%sR',num2str(eventindex));
               FlopL=sprintf('E%sL',num2str(eventindex+1));
               FlopR=sprintf('E%sR',num2str(eventindex+1));
               [Sessions,Trials,Window]=size(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(FlipL));
               FlipL_mean=nan(1,Window);
               FlipR_mean=nan(1,Window);
               FlopL_mean=nan(1,Window);
               FlopR_mean=nan(1,Window);
               clear FlipL_Combined FlipR_Combined FlopL_Combined FlopR_Combined
               for SessionIndex=1:Sessions
                  FlipL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(FlipL)(SessionIndex,:,:);
                  FlipR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(FlipR)(SessionIndex,:,:);
                  FlopL_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(FlopL)(SessionIndex,:,:);
                  FlopR_Combined((1+(Trials*(SessionIndex-1))):(Trials*SessionIndex),:)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(FlopR)(SessionIndex,:,:);
               end
               clear FlipL_mean FlipR_mean FlopL_mean FlopR_mean
               for flipflopindex=1:Window
                   FlipL_mean(1,flipflopindex)=mean(FlipL_Combined(:,flipflopindex));
                   FlipR_mean(1,flipflopindex)=mean(FlipR_Combined(:,flipflopindex));
                   FlopL_mean(1,flipflopindex)=mean(FlopL_Combined(:,flipflopindex));
                   FlopR_mean(1,flipflopindex)=mean(FlopR_Combined(:,flipflopindex));
               end
               NormValFlipL=mean(FlipL_mean);
               NormValFlipR=mean(FlipR_mean);
               NormValFlopL=mean(FlopL_mean);
               NormValFlopR=mean(FlopR_mean);
               clear FlipL_norm FlipR_norm FlopL_norm FlopR_norm
               FlipL_norm=FlipL_mean-NormValFlipL;
               FlipR_norm=FlipR_mean-NormValFlipR;
               FlopL_norm=FlopL_mean-NormValFlopL;
               FlopR_norm=FlopR_mean-NormValFlopR;
               clear FlipFlopCombinedNorm
               FlipFlopCombinedNorm(1,:)=FlipL_norm;
               FlipFlopCombinedNorm(2,:)=FlipR_norm;
               FlipFlopCombinedNorm(3,:)=FlopL_norm;
               FlipFlopCombinedNorm(4,:)=FlopR_norm;
               
               for flipflopindex=1:Window
                  AnimalAveragesL(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(1:2,flipflopindex));
                  AnimalAveragesR(alpha,(eventindex+1)/2,flipflopindex)=mean(FlipFlopCombinedNorm(2:4,flipflopindex));
               end
            end
            
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).ContrastSF=ContrastSF;
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).ContrastEventCodes=ContrastEventCodes;
            handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).ContrastCodes=ContrastCodes;

            for betaA=1:EventNum
                TotalAmplitudes(betaA,amplitudetrack,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                TotalAmplitudes(betaA,amplitudetrack,2)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,1);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
                MergedTotalAmps(betaA,amplitudeloc(1,betaA))=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(betaA,2);
                amplitudeloc(1,betaA)=amplitudeloc(1,betaA)+1;
            end
            
            amplitudetrack=amplitudetrack+1;
        end
        %Threshold Code
%         workingthresh=ContrastThresh/1000;
%         for alpha=1:alphamax
%             if TotalAmplitudes(1,alpha,1)<workingthresh
%                TotalAmplitudes(:,alpha,1)=NaN;
%                AnimalAveragesL(alpha,:,:)=NaN;
%             end
%             if TotalAmplitudes(1,alpha,2)<workingthresh
%                 TotalAmplitudes(:,alpha,2)=NaN;
%                 AnimalAveragesR(alpha,:,:)=NaN;
%             end
%         end
%         delarray=find(MergedTotalAmps(1,:)<workingthresh);
%         for alpha=1:length(delarray)
%            MergedTotalAmps(:,delarray(1,alpha))=NaN; 
%         end
        
        clear EventWaveforms
        EventWaveforms=[AnimalAveragesL;AnimalAveragesR];
        for alpha=1:EventNum
            for betaA=1:Window
                EventWaveform_mean(alpha,betaA)=nanmean(EventWaveforms(:,alpha,betaA));
            end
        end
        
        handles.MainStructure.(GroupName).EventWaveform_mean(:,:)=EventWaveform_mean;
        for betaA=1:EventNum
            MeanTotalAmp(groupnum,1,betaA)=nanmean(TotalAmplitudes(betaA,:,1)*AmpGain);
            MeanTotalAmpErr(groupnum,1,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanTotalAmp(groupnum,2,betaA)=nanmean(TotalAmplitudes(betaA,:,2)*AmpGain);
            MeanTotalAmpErr(groupnum,2,betaA)=nanstd(TotalAmplitudes(betaA,:,1)*AmpGain)/sqrt(length(find(~isnan(TotalAmplitudes(betaA,:,1)))));
            MeanMergedAmp(groupnum,1,betaA)=nanmean(MergedTotalAmps(betaA,:)*AmpGain);
            MeanMergedAmpErr(groupnum,1,betaA)=nanstd(MergedTotalAmps(betaA,:)*AmpGain)/sqrt(length(find(~isnan(MergedTotalAmps(betaA,:)))));
        end
        if groupnum==totalgroups
        %red = left hemisphere, blue = right hemisphere, black = merged
        contrastWaves=figure;
        contrastfig=figure;
        
        hold on;

        for grpplotter=1:totalgroups
        if ShowMergedContrast==1
            errorbar(MeanMergedAmp(grpplotter,1,:),MeanMergedAmpErr(grpplotter,1,:),'-+','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];                
            else
                legendtxt=sprintf('%s Combined Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        if ShowLHemiContrast==1
            errorbar(MeanTotalAmp(grpplotter,1,:),MeanTotalAmpErr(grpplotter,1,:),'--o','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];
            else
                legendtxt{1,1}=sprintf('%s Left Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        if ShowRHemiContrast==1
            errorbar(MeanTotalAmp(grpplotter,2,:),MeanTotalAmpErr(grpplotter,2,:),'--x','Color',grpcolors(grpplotter,:));
            if exist('legendInfo')==1
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendInfo=[legendInfo legendtxt];
            else
                legendtxt=sprintf('%s Right Hemisphere',GroupNames{1,grpplotter});
                legendInfo={legendtxt};
            end
        end
        end
        legend(legendInfo);
        set(gca,'xtickLabel',ContrastCodes)
        xaxistitle=sprintf('Spatial Frequency \nContrast: %s',ContrastSF{1,1});
        xlabel(xaxistitle);ylabel('VEP Amplitude (microVolts)');
        
        figure(contrastWaves)
        maxchecker=0;
        minchecker=0;
        for grpplotter=1:totalgroups
            GroupName=GroupNames{1,grpplotter};
            for betaA=1:EventNum
                subplot(totalgroups,EventNum,(betaA+((grpplotter-1)*EventNum)))
                testmax=max(max(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:)));
                testmin=min(min(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:)));
                if minchecker > testmin
                    minchecker=testmin;
                end
                if maxchecker < testmax
                    maxchecker=testmax;
                end
                plot(handles.MainStructure.(GroupName).EventWaveform_mean(betaA,:),'Color',grpcolors(grpplotter,:))
                if grpplotter==1
                   thetitle=sprintf('%s%% Contrast',ContrastCodes{1,betaA});
                   title(thetitle);
                end
                if betaA==1
                    ytitle=sprintf('Group %s',num2str(grpplotter));
                    ylabel(ytitle);
                end
                if grpplotter==totalgroups
                    xtitle=sprintf('Time (ms)');
                    xlabel(xtitle);
                end
                
            end
        end
        for grpplotter=1:totalgroups
           for betaA=1:EventNum
               subplot(totalgroups,EventNum,(betaA+((grpplotter-1)*EventNum)))
               ylim([minchecker maxchecker]);
           end
        end
        %filename = inputdlg('Input Filename for Contrast Analysis','Saving Data',[1 50]);
        %save(filename{1,1}, 'handles.MainStructure', 'groupfiles');
        %saveas(Contrastfig,filename{1,1},'epsc');
        end


    handles.MainStructure.(GroupName).RecFreq=RecordingFreq;
    handles.MainStructure.(GroupName).AmpGain=AmpGain;
end
debug=1;



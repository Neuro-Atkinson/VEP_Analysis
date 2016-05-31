function varargout = ContraIpsiAnalysis_Master(varargin)
% CONTRAIPSIANALYSIS_MASTER MATLAB code for ContraIpsiAnalysis_Master.fig
%      CONTRAIPSIANALYSIS_MASTER, by itself, creates a new CONTRAIPSIANALYSIS_MASTER or raises the existing
%      singleton*.
%
%      H = CONTRAIPSIANALYSIS_MASTER returns the handle to a new CONTRAIPSIANALYSIS_MASTER or the handle to
%      the existing singleton*.
%
%      CONTRAIPSIANALYSIS_MASTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTRAIPSIANALYSIS_MASTER.M with the given input arguments.
%
%      CONTRAIPSIANALYSIS_MASTER('Property','Value',...) creates a new CONTRAIPSIANALYSIS_MASTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContraIpsiAnalysis_Master_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContraIpsiAnalysis_Master_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContraIpsiAnalysis_Master

% Last Modified by GUIDE v2.5 02-Apr-2015 14:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContraIpsiAnalysis_Master_OpeningFcn, ...
                   'gui_OutputFcn',  @ContraIpsiAnalysis_Master_OutputFcn, ...
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


% --- Executes just before ContraIpsiAnalysis_Master is made visible.
function ContraIpsiAnalysis_Master_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContraIpsiAnalysis_Master (see VARARGIN)

% Choose default command line output for ContraIpsiAnalysis_Master
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)
% UIWAIT makes ContraIpsiAnalysis_Master wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContraIpsiAnalysis_Master_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function modified_closefcn(hObject, eventdata, handles)
currentprogs=getappdata(0,'RunningPrograms');
indicatornames=getappdata(0,'ProgramNames');
currentprogs(1,4)=0;
setappdata(0,'RunningPrograms',currentprogs);
AnalysisHandles = guidata(AnalysisProgram);
set(AnalysisHandles.(indicatornames{1,4}),'Backgroundcolor','r');
delete(hObject); 


% --- Executes on button press in button_ContraIpsiOptions.
function button_ContraIpsiOptions_Callback(hObject, eventdata, handles)
% hObject    handle to button_ContraIpsiOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ContraIpsiOptions_General
setappdata(0,'CI_options_confirmed',1);
set(handles.output_OptionsIndicator,'Backgroundcolor',[1 .6 0]);

% --- Executes on button press in button_GroupOptions.
function button_GroupOptions_Callback(hObject, eventdata, handles)
% hObject    handle to button_GroupOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GroupOptions_ContraIpsi
setappdata(0,'ContraIpsi_Group_options_confirmed',1);
set(handles.output_GroupIndicator,'Backgroundcolor',[1 .6 0]);

% --- Executes on button press in button_ProcessData.
function button_ProcessData_Callback(hObject, eventdata, handles)
% hObject    handle to button_ProcessData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to SRP_run_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.output_workload,'Backgroundcolor',[0 1 0]);

handles=buttons_off(hObject,handles);
drawnow;


DAQ_Code=2;
%1=1208FS-Plus
%2=1608FS

%Load SRP Related Options
ContraIpsi_Options_working=getappdata(0,'ContraIpsi_options');
%1-3 (binoc,leye,reye)
%4 vidget
%5 extract all waveform amplitudes
%6 SRP threshold
%7 SRP days
%8 num flips (not currently used... for future functionality)
%9 num flops (not currently used... for future functionality)
%10 num trials
%11 maximum number of events encountered through the data processing
%12 week 2 srp check
%13 Vidget pre start time
%14 Vidget post start time
ContraIpsi_GroupOptions_working=getappdata(0,'ContraIpsi_group_options');
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

%Load General Options
NUM_events = 4; %There are always going to be 4 event channels for now
StrobeThresh = str2num(General_Options_working{23,2});
StrobeDig = str2num(General_Options_working{16,2});
StrobeChannel = str2num(General_Options_working{7,2});
VidgetChannel = str2num(General_Options_working{6,2});
AmpGain = str2num(General_Options_working{2,2});
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
TotalChans = str2num(General_Options_working{3,2});
TotalDigitalChans = str2num(General_Options_working{24,2});
RecordingFreq = str2num(General_Options_working{1,2});
NormalizedAmplitudes = General_Options_working{21,2};

%Load ContraIpsi Options
SrpThresh = str2num(ContraIpsi_Options_working{1,2});
srpdays = str2num(ContraIpsi_Options_working{2,2});

%Load ContraIpsi Group Options
totalgroups = str2num(ContraIpsi_GroupOptions_working{1,2});
GroupNames{1,1}=ContraIpsi_GroupOptions_working{2,2};
GroupNames{1,2}=ContraIpsi_GroupOptions_working{3,2};
GroupNames{1,3}=ContraIpsi_GroupOptions_working{4,2};
GroupNames{1,4}=ContraIpsi_GroupOptions_working{5,2};
GroupNames{1,5}=ContraIpsi_GroupOptions_working{6,2};

for groupnum=1:totalgroups
    for eye=1:2 %1 = left eye, 2 = right eye
        grpcolors(groupnum,:)=ContraIpsi_GroupOptions_working{groupnum+6,2};
        %7-11 group colors for groups 1 - 5
        clear totalfiles groupfiles pathname
        GroupName=GroupNames{1,groupnum};
        %Determine total animals in each group as we loop through the groups

        if eye == 1
            groupfiles=ContraIpsi_GroupOptions_working{10+2*groupnum,2}; %10+2*groupnum offsets for how data is stored in structure.
            pathname=ContraIpsi_GroupOptions_working{11+2*groupnum,2};
            eye_string='Left Eye';
        else
            groupfiles=ContraIpsi_GroupOptions_working{21+2*groupnum,2}; %21+2*groupnum offsets for how data is stored in structure.
            pathname=ContraIpsi_GroupOptions_working{22+2*groupnum,2};
            eye_string='Right Eye';
        end
        totalfiles=length(groupfiles);
        animalnum(1,groupnum)=totalfiles/srpdays;

        

        for filenum=1:totalfiles
            output=sprintf('Processing %s Group (%s/%s) %s File (%s/%s)',GroupNames{1,groupnum},num2str(groupnum),num2str(totalgroups),eye_string,num2str(filenum),num2str(totalfiles));
            set(handles.output_workload,'String',output);
            drawnow;
            combofilename=sprintf('%s%s',pathname,groupfiles{1,filenum});
            if DAQ_Code==1
                fileID = fopen(combofilename);
                A = fread(fileID,inf,'float');
                filelength=length(A);
                clear A;
                Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
                fclose(fileID);

                DataLength=length(Data);
                DigitalChans=zeros(TotalDigitalChans,DataLength);
            else
                fileID = fopen(combofilename);
                %A = fread(fileID,inf,'float');
                %fileID = fopen('A_45deg_Day1_LeyeOpen_data1.dat');
                A = fread(fileID,'double','ieee-le');
                %A = fread(fileID,inf,'float');
                %filelength=length(A);
                %Data = multibandread(combofilename, [1 (filelength/TotalChans) TotalChans], 'float', 0, 'bip', 'ieee-le' );
                buffsize=0;
                for z = 1:TotalChans:length(A)
                    buffsize=buffsize+1;
                end
                Data=nan(1,buffsize,TotalChans);
                for i=1:TotalChans
                    location = 1;
                    for j = i:TotalChans:length(A)
                        Data(1,location,i)=A(j,1);
                        location=location+1;
                    end
                end
                fclose(fileID);
                clear A;
            end
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
               if Data(1,i,EventChan1) < EventChan1Thresh || isnan(Data(1,i,EventChan1))
                   DigitalChans(Event1Dig,i)=0;
               else
                   DigitalChans(Event1Dig,i)=1;
                   if i > (DataLength-1000)
                       debug=1;
                   end
               end
            end

            %Convert the analog event2 channel to a digital channel for easier event
            %timepoint extraction
            for i = 1:DataLength
               if Data(1,i,EventChan2) < EventChan2Thresh || isnan(Data(1,i,EventChan2))
                   DigitalChans(Event2Dig,i)=0;
               else
                   DigitalChans(Event2Dig,i)=1;
                   if i > (DataLength-1000)
                       debug=1;
                   end
               end
            end

            for i = 1:DataLength
               if Data(1,i,EventChan3) < EventChan3Thresh || isnan(Data(1,i,EventChan3))
                   DigitalChans(Event3Dig,i)=0;
               else
                   DigitalChans(Event3Dig,i)=1;
                   if i > (DataLength-1000)
                       debug=1;
                   end
               end
            end
            if NUM_events == 4
            for i = 1:DataLength
               if Data(1,i,EventChan4) < EventChan4Thresh || isnan(Data(1,i,EventChan4))
                   DigitalChans(Event4Dig,i)=0;
               else
                   DigitalChans(Event4Dig,i)=1;
                   if i > (DataLength-1000)
                       debug=1;
                   end
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
            %OffsetRegionStart=[1 101];
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
                            EventLocation=FlipFlopPoints(j)+CorrectionIndex(1,i)+100;
                        else
                            EventLocation=FlipFlopPoints(j)+100;
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
                        if EventSum == 16
                            debug=1;
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
                                        baselineLH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,1)-mean(Data(1,baseindex:baseindex+30,1));
                                        baselineRH(baselinetracker,1:495)=Data(1,baseindex:baseindex+494,2)-mean(Data(1,baseindex:baseindex+30,2));
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
                        EventChart(1,1)=EventSum;
                        LocationChart(1,1)=1;
                        EventTracker=EventTracker+1;
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
                    ActualLocation=FlipFlopPoints(j);
                    EndLocation=FlipFlopPoints(j)+WindowSize-1;
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

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        output=sprintf('Group %s %s Processed, Generating Variables...',GroupNames{1,groupnum},eye_string);
        set(handles.output_workload,'String',output);
        drawnow;
%         if eye == 2
%             temp_storage=fieldnames(handles.MainStructure.(GroupName));
%             RoughIndex=strfind(temp_storage,'EndPlotData');
%             Index = find(not(cellfun('isempty', RoughIndex)));
%             temp_storage{Index,1}=[];
%             temp_storage=temp_storage(~cellfun('isempty',temp_storage));
%             clear RoughIndex Index
%             RoughIndex=strfind(temp_storage,'EventNames');
%             Index = find(not(cellfun('isempty', RoughIndex)));
%             temp_storage{Index,1}=[];
%             temp_storage=temp_storage(~cellfun('isempty',temp_storage));
%             clear RoughIndex Index
%             RoughIndex=strfind(temp_storage,'groupfiles');
%             Index = find(not(cellfun('isempty', RoughIndex)));
%             temp_storage{Index,1}=[];
%             temp_storage=temp_storage(~cellfun('isempty',temp_storage));
%         end
        
%         if eye == 1
%             [alphamaxLeye ~]=size(fieldnames(handles.MainStructure.(GroupName)));
%             multiplier1=alphamaxLeye;
%             multiplier2=alphamaxLeye;
%         else
%             [alphamaxReye ~]=size(fieldnames(temp_storage));
%             multiplier1=alphamaxLeye;
%             multiplier2=alphamaxReye;
%         end
        if eye==1
            [alphamax ~]=size(fieldnames(handles.MainStructure.(GroupName)));
        end

        for alpha=1:alphamax
            EventNames=fieldnames(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)));
            [remnamesize ~]=size(EventNames);
            for alphaA=1:(remnamesize/4)
                delname1=sprintf('E%sTimes',num2str(alphaA));
                delname2=sprintf('E%sLocs',num2str(alphaA));
                EventNames(strcmp((delname1),EventNames)) = [];
                EventNames(strcmp((delname2),EventNames)) = [];
            end
            EventNames=sort(EventNames);
            [betamax ~]=size(EventNames);
            resorttrack=1;
            [sessions trials WindowSize]=size(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{1,1}));
            EventNum=0;
            for betaA=1:4:betamax
                EventNum=EventNum+1;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).EventNum=EventNum;
                trialtrackerL=1;
                trialtrackerR=1;
                for BetaC=1:sessions
                    sessionsname1=sprintf('Sessions%s%s',EventNames{(betaA)},EventNames{(betaA+1),1});
                    sessionsname2=sprintf('Sessions%s%s',EventNames{(betaA+2)},EventNames{(betaA+3),1});
                    sessiontracker1=1;
                    sessiontracker2=1;
                    for BetaD=1:trials
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(BetaC,sessiontracker1,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                        sessiontracker1=sessiontracker1+1;
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname1)(BetaC,sessiontracker1,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+1,1})(BetaC,BetaD,1:WindowSize);
                        sessiontracker1=sessiontracker1+1;
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(BetaC,sessiontracker2,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+2,1})(BetaC,BetaD,1:WindowSize);
                        sessiontracker2=sessiontracker2+1;
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(sessionsname2)(BetaC,sessiontracker2,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA+3,1})(BetaC,BetaD,1:WindowSize);
                        sessiontracker2=sessiontracker2+1;            
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{betaA,1})(BetaC,BetaD,1:WindowSize);
                        %All EventNameChecker's are for debugging.
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+1),1})(BetaC,BetaD,1:WindowSize);
                        trialtrackerL=trialtrackerL+1;
                        trialtrackerR=trialtrackerR+1;
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,trialtrackerL,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+2),1})(BetaC,BetaD,1:WindowSize);
                        handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,trialtrackerR,1:WindowSize)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).(EventNames{(betaA+3),1})(BetaC,BetaD,1:WindowSize);
                        trialtrackerL=trialtrackerL+1;
                        trialtrackerR=trialtrackerR+1;
                    end
                end
                for betaB=1:WindowSize
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsL(EventNum,1:trialtrackerL-1,betaB));
                    handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,betaB)=mean(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).MergedWaveFormsR(EventNum,1:trialtrackerR-1,betaB));
                end
                [minvalL,minlocL]=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,20:100));
                [minvalR,minlocR]=min(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,20:100));
                minlocL=minlocL+19;
                minlocR=minlocR+19;
                [maxvalL,maxlocL]=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormL(EventNum,minlocL:250));
                [maxvalR,maxlocR]=max(handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AveragedWaveFormR(EventNum,minlocR:250));
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1)=minvalL;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)=maxvalL;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1)=minvalR;
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)=maxvalR;

                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,1)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesL(EventNum,1);
                handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).Amplitudes(EventNum,2)=handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,2)-handles.MainStructure.(GroupName).(groupfiles{1,alpha}(1,1:end-4)).AmplitudesR(EventNum,1);
            end
        end


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if eye == 2
            %handles.MainStructure.(GroupName).(char(groupfiles(1,1)))
            
            [alphamax ~]=size(fieldnames(handles.MainStructure.(GroupName)));
            clear groupfiles
            groupfiles=fieldnames(handles.MainStructure.(GroupName))';
            if exist('EndPlotData')==1
                clear EndPlotData
            end
            EndPlotData{1,1}='File Name';
            maxminL=0;
            maxmaxL=0;
            maxminR=0;
            maxmaxR=0;
            for alpha=1:alphamax
                EndPlotData{alpha+1,1}=groupfiles(1,alpha);
                EventNum=handles.MainStructure.(GroupName).(char(groupfiles(1,alpha))).EventNum;
                colorvector=lines(EventNum);
                for betaA=1:EventNum
                    if betaA < 2
                        EndPlotData{1,(betaA*2)}=sprintf('LH Familiar');
                        EndPlotData{1,(betaA*2+1)}=sprintf('RH Familiar');
                        EndPlotData{alpha+1,(betaA*2)}=handles.MainStructure.(GroupName).(char(groupfiles(1,alpha))).Amplitudes(betaA,1);%LeftHemisphere
                        EndPlotData{alpha+1,(betaA*2+1)}=handles.MainStructure.(GroupName).(char(groupfiles(1,alpha))).Amplitudes(betaA,2);%RightHemisphere
                    else
                        EndPlotData{1,(betaA*2)}=sprintf('LH Novel');
                        EndPlotData{1,(betaA*2+1)}=sprintf('RH Novel');
                        EndPlotData{alpha+1,(betaA*2)}=handles.MainStructure.(GroupName).(char(groupfiles(1,alpha))).Amplitudes(betaA,1);%LeftHemisphere
                        EndPlotData{alpha+1,(betaA*2+1)}=handles.MainStructure.(GroupName).(char(groupfiles(1,alpha))).Amplitudes(betaA,2);%RightHemisphere
                    end
                end
            end
            handles.MainStructure.(GroupName).EndPlotData=EndPlotData;
            handles.MainStructure.(GroupName).EventNames=EventNames;
            handles.MainStructure.(GroupName).groupfiles=groupfiles;
            handles.MainStructure.GroupNames=GroupNames;
            handles.MainStructure.SrpThresh=SrpThresh;
            handles.MainStructure.srpdays=srpdays;
            handles.MainStructure.AmpGain=AmpGain;
            handles.MainStructure.grpcolors=grpcolors;
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end



set(handles.output_workload,'Backgroundcolor',[1 0 0]);
set(handles.output_workload,'String','Not Processing Data');

handles=buttons_on(hObject,handles);
handles.processed_loaded=1;
set(handles.button_ClearProcessedData,'Enable','on');
set(handles.button_exportdata,'Enable','on');
set(handles.button_plotdata,'Enable','on');
guidata(hObject, handles);



% --- Executes on button press in button_ClearProcessedData.
function button_ClearProcessedData_Callback(hObject, eventdata, handles)
% hObject    handle to button_ClearProcessedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA


function [handles]=buttons_off(hObject,handles)
handles.previous_state{1,1}=get(handles.button_OutputFolder,'Enable');
set(handles.button_OutputFolder,'Enable','off');

handles.previous_state{1,2}=get(handles.button_ContraIpsiOptions,'Enable');
set(handles.button_ContraIpsiOptions,'Enable','off');

handles.previous_state{1,3}=get(handles.button_GroupOptions,'Enable');
set(handles.button_GroupOptions,'Enable','off');

handles.previous_state{1,4}=get(handles.button_ProcessData,'Enable');
set(handles.button_ProcessData,'Enable','off');

handles.previous_state{1,5}=get(handles.button_ClearProcessedData,'Enable');
set(handles.button_ClearProcessedData,'Enable','off');

function [handles]=buttons_on(hObject,handles)
set(handles.button_OutputFolder,'Enable',handles.previous_state{1,1});

set(handles.button_ContraIpsiOptions,'Enable',handles.previous_state{1,2});

set(handles.button_GroupOptions,'Enable',handles.previous_state{1,3});

set(handles.button_ProcessData,'Enable',handles.previous_state{1,4});

set(handles.button_ClearProcessedData,'Enable',handles.previous_state{1,5});

guidata(hObject,handles);


% --- Executes on button press in button_OutputFolder.
function button_OutputFolder_Callback(hObject, eventdata, handles)
% hObject    handle to button_OutputFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.button_ClearProcessedData,'Enable','on');
set(handles.button_exportdata,'Enable','on');
set(handles.button_plotdata,'Enable','on');

% --- Executes on button press in button_exportdata.
function button_exportdata_Callback(hObject, eventdata, handles)
% hObject    handle to button_exportdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_plotdata.
function button_plotdata_Callback(hObject, eventdata, handles)
% hObject    handle to button_plotdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ContraIpsi_Options_working=getappdata(0,'ContraIpsi_options');
General_Options_working=getappdata(0,'GS_options');
ContraIpsi_GroupOptions_working=getappdata(0,'ContraIpsi_group_options');


AmpGain = str2num(General_Options_working{2,2});
SrpThresh = str2num(ContraIpsi_Options_working{1,2});
grpcolors = [ ContraIpsi_GroupOptions_working{7,2};ContraIpsi_GroupOptions_working{8,2};ContraIpsi_GroupOptions_working{9,2};ContraIpsi_GroupOptions_working{10,2};ContraIpsi_GroupOptions_working{11,2} ];

% checkdata=get(handles.plot_loaded,'Value');
% if checkdata==1
%     checkvetted=get(handles.usevetted,'Value');
%     if checkvetted==1
%         Data=handles.Cleaned_SRPData_Loaded.Cleaned_SRPData;
%     else
%         Data=handles.Master_SRPData_Loaded.MasterSRPData;
%     end
% else
    Data=handles.MainStructure;
% end
grpnamelen=length(Data.GroupNames);
groupnum=0;


groups_fields=fieldnames(Data);

%There are some fields that are not group names (and will thus
%give us an innacurate group number) so we delete them
%here.
delname1='GroupNames';
delname2='SrpThresh';
delname3='srpdays';
delname4='AmpGain';
delname5='grpcolors';
groups_fields(strcmp((delname1),groups_fields)) = [];
groups_fields(strcmp((delname2),groups_fields)) = [];
groups_fields(strcmp((delname3),groups_fields)) = [];
groups_fields(strcmp((delname4),groups_fields)) = [];
groups_fields(strcmp((delname5),groups_fields)) = [];
groups_fields_num=length(groups_fields);
for namecheck=1:groups_fields_num
    for grpcheck=1:grpnamelen
        if strcmp(groups_fields{namecheck,1},Data.GroupNames{1,grpcheck})==1
            groupnum=groupnum+1;
        end
    end
end

srpdays = str2num(ContraIpsi_Options_working{2,2});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Pull in Data From SRP Analysis-PreLOOP %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataloaded=0;
if isfield(handles,'SRPData_Loaded') == 1
    SRP_Data=handles.SRPData_Loaded.Cleaned_SRPData;
    dataloaded=1;
    SRP_groupnum=0;
    SRP_groups_fields=fieldnames(SRP_Data);
    SRP_grpnamelen=length(SRP_Data.GroupNames);
    %There are some fields that are not group names (and will thus
    %give us an innacurate group number) so we delete them
    %here.
    SRP_delname1='GroupNames';
    SRP_delname2='SrpThresh';
    SRP_delname3='srpdays';
    SRP_delname4='AmpGain';
    SRP_delname5='grpcolors';
    SRP_groups_fields(strcmp((SRP_delname1),SRP_groups_fields)) = [];
    SRP_groups_fields(strcmp((SRP_delname2),SRP_groups_fields)) = [];
    SRP_groups_fields(strcmp((SRP_delname3),SRP_groups_fields)) = [];
    SRP_groups_fields(strcmp((SRP_delname4),SRP_groups_fields)) = [];
    SRP_groups_fields(strcmp((SRP_delname5),SRP_groups_fields)) = [];
    SRP_groups_fields_num=length(SRP_groups_fields);
    for namecheck=1:SRP_groups_fields_num
        for grpcheck=1:SRP_grpnamelen
            if strcmp(SRP_groups_fields{namecheck,1},SRP_Data.GroupNames{1,grpcheck})==1
                SRP_groupnum=SRP_groupnum+1;
            end
        end
    end
end






for group=1:groupnum
    
    
    groupname=Data.GroupNames{1,group};
    if dataloaded==1
        SRP_groupname=SRP_Data.GroupNames{1,group};
    end
    [preAnimalNum ~]=size(Data.(groupname).EndPlotData);
    AnimalNum=((preAnimalNum-1)/srpdays)/2;
    
    if srpdays==5
        grouptracker_ipsi=ones(1,6);
        grouptracker_contra=ones(1,6);
    else
        grouptracker_ipsi=ones(1,srpdays);
        grouptracker_contra=ones(1,srpdays);
    end
    
    SRP_Thresh=SrpThresh;
    if dataloaded==1
        AMPGain=SRP_Data.AmpGain;
    end
    trueanimal=1;
    modvalue=AnimalNum*srpdays;
    if modvalue ==1
        modvalue=2;
    end
    for animalloop=2:srpdays:modvalue
        DayHolder=0;
        if srpdays < 5
            %groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi
            if exist('groupdata_contra')==0
                groupdata_contra=0;
                groupdata_ipsi=0;
            end
            if dataloaded==0
                SRP_groupname='';
                AMPGain=AmpGain; %AMPGain is from loaded SRP data, %AmpGain is from native contra/ipsi file options.
                SRP_Data='';
            end
            [groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal);

%                 while DayHolder<srpdays
%                     groupdata_contra(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                     grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
%                     groupdata_ipsi(group,grouptracker(1,DayHolder+1),DayHolder+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                     grouptracker(1,DayHolder+1)=grouptracker(1,DayHolder+1)+1;
%                     DayHolder=DayHolder+1;
%                 end
        end
        if srpdays == 5
            %groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi
            if exist('groupdata_contra')==0
                groupdata_contra=0;
                groupdata_ipsi=0;
            end
            if dataloaded==0
                SRP_groupname='';
                AMPGain=AmpGain; %AMPGain is from loaded SRP data, %AmpGain is from native contra/ipsi file options.
                SRP_Data='';
            end
            [groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal);

            
            %[groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop_withplots(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal);

%                 while DayHolder<srpdays
%                    if DayHolder==0
%                     RemoveLeft=0;
%                     RemoveRight=0;
%                     %CHECK SRP ENDPLOT DAY 1 VALUE
%                     clear clearhemi
%                     [clear_LH,clear_RH]=check_hemi(trueanimal,group);
%                     check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,2}; %LH Day 1 Binoc SRP Value
%                     if check_value < SRP_Thresh/AMPGain || clear_LH == 1
%                         RemoveLeft=1;
%                     end
%                     check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,3}; %LH Day 1 Binoc SRP Value
%                     if check_value < SRP_Thresh/AMPGain || clear_RH == 1
%                         RemoveRight=1;
%                     end
%                     %LEFT EYE OPEN
%                     if RemoveLeft==1
%                         %(Novel) LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %LH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
%                     else
%                         %(Novel) LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
%                     end
%                     
%                     if RemoveRight==1
%                         %(Novel) RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %RH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
%                     else
%                         %(Novel) RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
%                     end
%                     
%                     
%                     if RemoveLeft == 1
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %LH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
%                     else
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
%                     end
%                        
%                     if RemoveRight == 1
%                         %RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %RH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
%                     else
%                         %RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
%                     end
%                         
%                     %RIGHT EYE OPEN
%                     if RemoveLeft == 1
%                         %(Novel) LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %LH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
%                     else
%                         %(Novel) LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,4}; %LH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
%                     end
% 
%                     if RemoveRight == 1
%                         %(Novel) RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %RH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
%                     else    
%                         %(Novel) RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,5}; %RH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
%                     end
%                     
%                     if RemoveLeft == 1
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %LH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
%                     else
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
%                     end
% 
%                     if RemoveRight == 1
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %RH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
%                     else
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
%                     end
% 
% 
%                         DayHolder=DayHolder+1;
%                    else
%                     %LEYE OPEN
%                     if RemoveLeft == 1
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
%                     else
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
%                     end
% 
%                     if RemoveRight == 1
%                         %RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
%                     else
%                         %RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
%                     end
% 
%                         
%                     %REYE OPEN
%                     if RemoveLeft == 1
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
%                     else
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
%                     end
% 
%                     if RemoveRight == 1
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
%                     else
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
%                     end
% 
%                         DayHolder=DayHolder+1;
%                         
%                    end
%                 end
                
                        
        end
        trueanimal=trueanimal+1;
    end
    
    %contra and ipsi will have the same structure if done correctly...
    [grpanimal,grpdata,grpdays]=size(groupdata_contra);
    
    
    for i=1:grpanimal
        %Scan day 1 for values equal to zero and remove them (errors)
       delvals=find(groupdata_contra(i,:,1)==0);
       for j=1:length(delvals)
           for k=1:6
              groupdata_contra(i,delvals(1,j),k)=NaN;
           end
       end
    end
    
    for i=1:grpanimal
        %Scan day 1 for values equal to zero and remove them (errors)
       delvals=find(groupdata_ipsi(i,:,1)==0);
       for j=1:length(delvals)
           for k=1:6
              groupdata_ipsi(i,delvals(1,j),k)=NaN;
           end
       end
    end
    
    
%THRESHOLD CODE
    %THRESHOLD CODE IS DISABLED UNTIL I CAN INCORPORATE PREVIOUS ENDPLOT
    %DATA

    [grpanimal,grpdata,grpdays]=size(groupdata_contra);
    threshgroupdata_contra=groupdata_contra;
    threshgroupdata_ipsi=groupdata_ipsi;
    threshdays=grpdays;
    
    %WorkingThresh=SrpThresh/1000;
    WorkingThresh=0;
    for i=1:grpanimal
        %Scan day 1 for values less than thresh
       delvals=find(groupdata_contra(i,:,1)<WorkingThresh);
       for j=1:length(delvals)
           for k=1:threshdays
               %eliminate those hemispheres across all days that fell
               %below threshold.
              threshgroupdata_contra(i,delvals(1,j),k)=NaN;
           end
       end
    end
    
    for i=1:grpanimal
        %Scan day 1 for values less than thresh
       delvals=find(groupdata_ipsi(i,:,1)<WorkingThresh);
       for j=1:length(delvals)
           for k=1:threshdays
               %eliminate those hemispheres across all days that fell
               %below threshold.
              threshgroupdata_ipsi(i,delvals(1,j),k)=NaN;
           end
       end
    end

    
    
    if group==groupnum
        for i=1:grpanimal
            [~,totalhemis,~]=size(groupdata_contra(i,:,1));
            grouphemitracker(1,i)=0;
            groupanimaltracker(1,i)=0;
            for hemichecker=1:2:totalhemis
                if ~isnan(threshgroupdata_contra(i,hemichecker,1))
                    grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                end
                if ~isnan(threshgroupdata_contra(i,hemichecker+1,1))
                    grouphemitracker(1,i)=grouphemitracker(1,i)+1;
                end
                if ~isnan(threshgroupdata_contra(i,hemichecker,1)) || ~isnan(threshgroupdata_contra(i,hemichecker+1,1))
                    groupanimaltracker(1,i)=groupanimaltracker(1,i)+1;
                end
            end
        end
    end

    grpnumsanimal(1,group)=AnimalNum;
    for i=1:grpanimal
     for j=1:grpdays
              grpplot_contra(i,j)=nanmean(threshgroupdata_contra(i,:,j)*AmpGain);
              grperror_contra(i,j)=nanstd(threshgroupdata_contra(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_contra(i,:,j)))));
              
              grpplot_ipsi(i,j)=nanmean(threshgroupdata_ipsi(i,:,j)*AmpGain);
              grperror_ipsi(i,j)=nanstd(threshgroupdata_ipsi(i,:,j)*AmpGain)/sqrt(length(find(~isnan(threshgroupdata_ipsi(i,:,j)))));
              
              for z=1:2:grpdata
%                   test=threshgroupdata_contra(i,z,j)/threshgroupdata_ipsi(i,z,j);
%                   if test >= 6
%                       debug=1;
%                   end
                ratios(i,z,j)=threshgroupdata_contra(i,z+1,j)/threshgroupdata_ipsi(i,z,j);
                ratios(i,z+1,j)=threshgroupdata_contra(i,z,j)/threshgroupdata_ipsi(i,z+1,j);
              end
              grpplot_ratios(i,j)=nanmean(ratios(i,:,j));
              grperror_ratios(i,j)=nanstd(ratios(i,:,j))/sqrt(length(find(~isnan(ratios(i,:,j)))));
     end
     if group==i
         if exist('grphemis')==1 %Calculates number of group hemispheres
             if length(grphemis) < group
                 grphemis_contra(1,group)=length(find(~isnan(threshgroupdata_contra(i,:,1))));
                 grphemis_ipsi(1,group)=length(find(~isnan(threshgroupdata_ipsi(i,:,1))));
             else
                 grphemis_contra(1,group)=grphemis_contra(1,group)+length(find(~isnan(threshgroupdata_contra(i,:,1))));
                 grphemis_ipsi(1,group)=grphemis_ipsi(1,group)+length(find(~isnan(threshgroupdata_ipsi(i,:,1))));
             end
         else
             grphemis_contra(1,group)=length(find(~isnan(threshgroupdata_contra(i,:,1))));
             grphemis_ipsi(1,group)=length(find(~isnan(threshgroupdata_ipsi(i,:,1))));
         end
     end
    end
    
    %END THRESHCODE
    
    if group==groupnum
    finalsrpfig=figure;
    finalratiofig=figure;
    hold on
    VepEventSymbols_contra={'-s','-o','-d','-p','-h'};
    VepEventSymbols_ipsi={'--s','--o','--d','--p','--h'};
    
    for i=1:grpanimal
       if grpdays==6
           figure(finalsrpfig);
           hold on;
              errorbar(grpplot_contra(i,1:5),grperror_contra(i,1:5),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
              errorbar(grpplot_ipsi(i,1:5),grperror_ipsi(i,1:5),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
              novel_contra=nan(1,5);
              novelerr_contra=nan(1,5);
              novel_contra(1,5)=grpplot_contra(i,6);
              novelerr_contra(1,5)=grperror_contra(i,6);
              
              novel_ipsi=nan(1,5);
              novelerr_ipsi=nan(1,5);
              novel_ipsi(1,5)=grpplot_ipsi(i,6);
              novelerr_ipsi(1,5)=grperror_ipsi(i,6);
              errorbar(novel_contra,novelerr_contra,VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
              errorbar(novel_ipsi,novelerr_ipsi,VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
          figure(finalratiofig);
              errorbar(grpplot_ratios(i,1:5),grperror_ratios(i,1:5),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
              novel_ratios=nan(1,5);
              novelerr_ratios=nan(1,5);
              novel_ratios(1,5)=grpplot_ratios(i,6);
              novelerr_ratios(1,5)=grperror_ratios(i,6);
              errorbar(novel_ratios,novelerr_ratios,VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'MarkerFaceColor',grpcolors(i,:),'MarkerEdgeColor',grpcolors(i,:),'Color',grpcolors(i,:));
       else
           figure(finalsrpfig);
              errorbar(grpplot_contra(i,:),grperror_contra(i,:),VepEventSymbols_contra{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
              errorbar(grpplot_ipsi(i,:),grperror_ipsi(i,:),VepEventSymbols_ipsi{1,grpanimal},'MarkerSize',14,'Color',grpcolors(i,:));
           figure(finalratiofig);
       end
    end
figure;
if srpdays < 5
    ratio_values=[grpplot_ratios(1,1);grpplot_ratios(2,1)];
    ratio_errors=[grperror_ratios(1,1);grperror_ratios(2,1)];
    h=barwitherr(ratio_errors,ratio_values);
    set(h(1),'FaceColor','b');
    set(h(2),'FaceColor','r');
    legendnames=[{sprintf('%s',(Data.GroupNames{1}))},{sprintf('%s',(Data.GroupNames{2}))}];
    legend(legendnames);
    set(gca,'XTickLabel',{'Day 1','Day 5 Novel'});
else
    ratio_values=[grpplot_ratios(1,1),grpplot_ratios(2,1);grpplot_ratios(1,6),grpplot_ratios(2,6)];
    ratio_errors=[grperror_ratios(1,1),grperror_ratios(2,1);grperror_ratios(1,6),grperror_ratios(2,6)];
    h=barwitherr(ratio_errors,ratio_values);
    set(h(1),'FaceColor','b');
    set(h(2),'FaceColor','r');
    legendnames=[{sprintf('%s',(Data.GroupNames{1}))},{sprintf('%s',(Data.GroupNames{2}))}];
    legend(legendnames);
    set(gca,'XTickLabel',{'Day 1','Day 5 Novel'});
end

figure;
ci_values=[grpplot_contra(1,1),grpplot_contra(2,1),grpplot_ipsi(1,1),grpplot_ipsi(2,1);grpplot_contra(1,6),grpplot_contra(2,6),grpplot_ipsi(1,6),grpplot_ipsi(2,6)];
ci_errors=[grperror_contra(1,1),grperror_contra(2,1),grperror_ipsi(1,1),grperror_ipsi(2,1);grperror_contra(1,6),grperror_contra(2,6),grperror_ipsi(1,6),grperror_ipsi(2,6)];
h=barwitherr(ci_errors,ci_values);
set(h(1),'FaceColor','b');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor',[0 1 1]);
set(h(4),'FaceColor',[1 0 1]);
legendnames=[{sprintf('%s Contra',(Data.GroupNames{1}))},{sprintf('%s Contra',(Data.GroupNames{2}))},{sprintf('%s Ipsi',(Data.GroupNames{1}))},{sprintf('%s Ipsi',(Data.GroupNames{2}))}];
legend(legendnames);
set(gca,'XTickLabel',{'Day 1','Day 5 Novel'});



    GroupNames=Data.GroupNames;
    if grpdays==6
        for i=1:grpanimal
            if i==1
               legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
               legtxtnov=sprintf('%s Novel',GroupNames{1,1});
               legendInfo=[legendInfo legtxtnov];
            else
               legtxt=sprintf('%s Familiar',GroupNames{1,i});
               legnovtxt=sprintf('%s Novel',GroupNames{1,i});
               legendInfo=[legendInfo legtxt legnovtxt]; 
            end
        end
        legend(legendInfo,'Location','NorthWest');
    else
        for i=1:grpanimal
           if i==1
               legendInfo{1,1}=sprintf('%s Familiar',GroupNames{1,1});
           else
               legtxt=sprintf('%s Familiar',GroupNames{1,i});
               legendInfo=[legendInfo legtxt];
           end
        end
        legend(legendInfo,'Location','NorthWest'); 
    end
    ylabel('Vep Amplitude (microVolts)');
    if grpdays==6
    xticks=linspace(1,grpdays-1,grpdays-1);
    else
    xticks=linspace(1,grpdays,grpdays);
    end
    set(gca,'XTick',xticks)
    xtitle=sprintf('Recording Days\nVep Threshold: %s microVolts\nAnimalsGrp1:%s\nAnimalsGrp2:%s\nHemisGrp1:%s\nHemisGrp2:%s',num2str(SrpThresh),num2str(groupanimaltracker(1,1)),num2str(groupanimaltracker(1,2)),num2str(grouphemitracker(1,1)),num2str(grouphemitracker(1,2)));
    xlabel(xtitle);
    
    
    end
    
    
    
    
end
SRP_Options_working=getappdata(0,'SRP_options');
trials = str2num(SRP_Options_working{8,2});
sessions = str2num(SRP_Options_working{10,2});

for group=1:groupnum
    tracker=0;
    %trackL=ones(1,srpdays);
    %trackR=ones(1,srpdays);
    if srpdays==5
        trackerHemi=ones(1,srpdays+1);
        sessionHemi=ones(1,srpdays+1);
    else
        trackerHemi=ones(1,srpdays);
        sessionHemi=ones(1,srpdays);
    end
    groupname=Data.GroupNames{1,group};
    for hemi=1:2:totalhemis
        if ~isnan(threshgroupdata(group,hemi,1))==1
           for day=1:srpdays
               %left hemi
               
               if day==1
                   day=5;
                   filenum=tracker*5+1;
               else 
                   day=day-1;
                   filenum=tracker*5+day+1;
               end
               
          
               [~,groupfiles]=size(Data.(groupname).groupfiles);
               if filenum <= groupfiles
               filename=Data.(groupname).groupfiles{1,filenum}(1:end-4);
               fileevents=Data.(groupname).(filename).EventNum;
               eventtrack=1;
               for event=1:2:(fileevents*2)
                   EventNames{eventtrack,1}=sprintf('E%sL',num2str(event));
                   eventtrack=eventtrack+1;
                   EventNames{eventtrack,1}=sprintf('E%sL',num2str(event+1));
                   eventtrack=eventtrack+1;
               if event >=3
                   day=6;
               end
                   ExtractPeakNameL_Flip=(EventNames{event,1});
                   ExtractPeakNameL_Flop=(EventNames{event+1,1});
                   NameLPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{event,1}));
                   NameLPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{event+1,1}));
                   NameL_Flip=sprintf('%s_Amplitudes',(EventNames{event,1}));
                   NameL_Flop=sprintf('%s_Amplitudes',(EventNames{event+1,1}));
               
                for sessionNum=1:sessions
                    meansessionwaveform_merged(1:100,:)=Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,:,:);
                    meansessionwaveform_merged(101:200,:)=Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,:,:);
                    for datapoint=1:495
                        meansessionwaveform(1,datapoint)=mean(meansessionwaveform_merged(:,datapoint));
                    end
                    [meansessionmin,minloc]=min(meansessionwaveform(1,20:100));
                    minloc = minloc + 19;
                    [meansessionmax,maxloc]=max(meansessionwaveform(1,minloc:250));
                    meanamp=meansessionmax-meansessionmin;
                    sessionsum_finalstructure(group,day,sessionHemi(1,day))=meanamp;
                    if minloc < 20
                        debug = 1;
                    end
                    sessionsum_minlocs(group,day,sessionHemi(1,day))=minloc;
                    sessionHemi(1,day)=sessionHemi(1,day)+1;
                    
                    for individualamploop=1:trials
                        %Flips
                        [Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,20:100)));
                        minloc = minloc+19;
                        [Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameL_Flip)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameLPeaks_Flip)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                        %Flops
                        [Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,20:100)));
                        minloc = minloc+19;
                        [Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameL_Flop)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameL_Flop)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameLPeaks_Flop)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameL_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                    end
                end
                end
               end
           end
        end
        if ~isnan(threshgroupdata(group,hemi+1,1))==1
           for day=1:srpdays
               if day==1
                   day=5;
                   filenum=tracker*5+1;
               else 
                   day=day-1;
                   filenum=tracker*5+day+1;
               end
               %right hemi
               filenum=tracker*5+day;
               [~,groupfiles]=size(Data.(groupname).groupfiles);
               if filenum <= groupfiles
               filename=Data.(groupname).groupfiles{1,filenum}(1:end-4);
               fileevents=Data.(groupname).(filename).EventNum;
               eventtrack=1;
               for event=1:2:(fileevents*2)
                   EventNames{eventtrack,1}=sprintf('E%sR',num2str(event));
                   eventtrack=eventtrack+1;
                   EventNames{eventtrack,1}=sprintf('E%sR',num2str(event+1));
                   eventtrack=eventtrack+1;
               if event >= 3
                   day = 6;
               end
                   ExtractPeakNameR_Flip=(EventNames{event,1});
                   ExtractPeakNameR_Flop=(EventNames{event+1,1});
                   NameRPeaks_Flip=sprintf('%s_AmplitudePeaks',(EventNames{event,1}));
                   NameRPeaks_Flop=sprintf('%s_AmplitudePeaks',(EventNames{event+1,1}));
                   NameR_Flip=sprintf('%s_Amplitudes',(EventNames{event,1}));
                   NameR_Flop=sprintf('%s_Amplitudes',(EventNames{event+1,1}));
                for sessionNum=1:sessions
                    meansessionwaveform_merged(1:100,:)=Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,:,:);
                    meansessionwaveform_merged(101:200,:)=Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,:,:);
                    for datapoint=1:495
                        meansessionwaveform(1,datapoint)=mean(meansessionwaveform_merged(:,datapoint));
                    end
                    [meansessionmin,minloc]=min(meansessionwaveform(1,20:100));
                    minloc = minloc + 19;
                    [meansessionmax,maxloc]=max(meansessionwaveform(1,minloc:250));
                    meanamp=meansessionmax-meansessionmin;
                    sessionsum_finalstructure(group,day,sessionHemi(1,day))=meanamp;
                    if minloc < 20
                        debug = 1;
                    end
                    sessionsum_minlocs(group,day,sessionHemi(1,day))=minloc;
                    sessionHemi(1,day)=sessionHemi(1,day)+1;
                    for individualamploop=1:trials
                        %Flips
                        
                        [Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,20:100)));
                        minloc = minloc + 19;
                        [Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameR_Flip)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameRPeaks_Flip)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                        %Flops
                        [Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,1),minloc]=(min(Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,20:100)));
                        minloc = minloc + 19;
                        [Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,2),maxloc]=(max(Data.(groupname).(filename).(ExtractPeakNameR_Flop)(sessionNum,individualamploop,minloc:250)));
                        Data.(groupname).(filename).(NameR_Flop)(sessionNum,individualamploop,1)=Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,2)-Data.(groupname).(filename).(NameRPeaks_Flop)(sessionNum,individualamploop,1);
                        cumsum_finalstructure(group,day,trackerHemi(1,day))=Data.(groupname).(filename).(NameR_Flip)(sessionNum,individualamploop,1);
                        cumsum_minlocs(group,day,trackerHemi(1,day))=minloc;
                        trackerHemi(1,day)=trackerHemi(1,day)+1;
                    end
                end
                end
               end
           end
        end
        tracker=tracker+1;
    end
end


[groupnum,days,maxtrials]=size(sessionsum_finalstructure)
for group=1:groupnum
    for day=1:days
        for trial=1:maxtrials
            if sessionsum_finalstructure(group,day,trial)==0
                sessionsum_finalstructure(group,day,trial)=nan;
            end
            if sessionsum_finalstructure(group,day,trial)>3
                sessionsum_finalstructure(group,day,trial)=nan;
            end
        end
    end
end

[groupnum,days,maxtrials]=size(cumsum_finalstructure)
for group=1:groupnum
    for day=1:days
        for trial=1:maxtrials
            if cumsum_finalstructure(group,day,trial)==0
                cumsum_finalstructure(group,day,trial)=nan;
            end
            if cumsum_finalstructure(group,day,trial)>3
                cumsum_finalstructure(group,day,trial)=nan;
            end
        end
    end
end

grp1(:,:)=cumsum_finalstructure(1,:,:);
grp2(:,:)=cumsum_finalstructure(2,:,:);
figure
hold on
cumplot(grp1(5,:),'b-','MarkerFaceColor','b')
cumplot(grp1(6,:),'b--')
cumplot(grp2(5,:),'r-','MarkerFaceColor','r')
cumplot(grp2(6,:),'r--')
title('All Extracted Windows');
clear grp1 grp2
grp1(:,:)=sessionsum_finalstructure(1,:,:);
grp2(:,:)=sessionsum_finalstructure(2,:,:);
figure
hold on
cumplot(grp1(5,:),'bo','MarkerFaceColor','b')
cumplot(grp1(6,:),'bo')
cumplot(grp2(5,:),'ro','MarkerFaceColor','r')
cumplot(grp2(6,:),'ro')
title('Session Averages');
clear grp1 grp2
grp1(:,:)=sessionsum_finalstructure(1,:,:);
grp2(:,:)=sessionsum_finalstructure(2,:,:);
figure
hold on
cumplot(grp1(5,:),'-b')
cumplot(grp1(6,:),'--b')
cumplot(grp2(5,:),'-r')
cumplot(grp2(6,:),'--r')
title('Session Averages');
clear grp1 grp2
grp1(:,:)=sessionsum_minlocs(1,:,:);
grp1( :, ~any(grp1,1) ) = [];  %columns
grp2(:,:)=sessionsum_minlocs(2,:,:);
grp2( :, ~any(grp2,1) ) = [];  %columns
figure
hold on
cumplot(grp1(5,:),'bo-','MarkerFaceColor','b')
cumplot(grp1(6,:),'bo--')
cumplot(grp2(5,:),'ro-','MarkerFaceColor','r')
cumplot(grp2(6,:),'ro--')
title('Session MinPeak Location');
clear grp1 grp2
grp1(:,:)=cumsum_minlocs(1,:,:);
grp1( :, ~any(grp1,1) ) = [];  %columns
grp2(:,:)=cumsum_minlocs(2,:,:);
grp2( :, ~any(grp2,1) ) = [];  %columns
figure
hold on
cumplot(grp1(5,:),'bo-','MarkerFaceColor','b')
cumplot(grp1(6,:),'bo--')
cumplot(grp2(5,:),'ro-','MarkerFaceColor','r')
cumplot(grp2(6,:),'ro--')
title('Session MinPeak Location');
debug=1;


% --- Executes on button press in button_SRPThreshData.
function button_SRPThreshData_Callback(hObject, eventdata, handles)
% hObject    handle to button_SRPThreshData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=buttons_off(hObject,handles);
set(handles.button_SRPThreshData,'Enable','off');
if isfield(handles,'SRPData_Loaded')
    handles=rmfield(handles,'SRPData_Loaded')
end
guidata(hObject, handles);
set(handles.output_srpthreshdata,'String','Loading...');
set(handles.output_srpthreshdata,'BackgroundColor',[1 .6 0]);
drawnow;
[FileName,PathName,~] = uigetfile('*.mat','Select processed data');
if isequal(FileName,0)
   handles=buttons_on(hObject,handles);
   set(handles.button_SRPThreshData,'Enable','on');
   set(handles.output_srpthreshdata,'String','No Files Loaded');
   return;
end
combinedname=sprintf('%s%s',PathName,FileName);
handles.SRPData_Loaded=load(combinedname,'-mat');
handles=buttons_on(hObject,handles);
set(handles.output_srpthreshdata,'BackgroundColor',[0 1 0]);
set(handles.output_srpthreshdata,'String','Data Loaded');
set(handles.button_SRPThreshData,'Enable','on');
guidata(hObject, handles);


% --- Executes on button press in button_SRPThreshData.
function [LH,RH] = check_hemi(animal,chkgrp)
%1=nx
%2=hx
  
%1=RH
%2=LH
%3=LH and RH
manual_delete_normoxic=[1,3,5,7,8,10,11,13,14;1,2,1,3,3,3,3,3,3];
manual_delete_hypoxic=[1,2,3,4,5,6,8,10,11,12,9;3,1,2,3,1,2,1,3,2,3,1];
% manual_delete_normoxic=[0];
% manual_delete_hypoxic=[0];
if chkgrp==1
    animal_index=find(manual_delete_normoxic(1,:)==animal);
    if isempty(animal_index)
       LH=0;
       RH=0;
    else
       hemi_info=manual_delete_normoxic(2,animal_index);
       if hemi_info==1
           LH=0;
           RH=1;
       elseif hemi_info == 2
           LH = 1;
           RH = 0;
       elseif hemi_info == 3
           LH = 1;
           RH = 1;
       end
    end
else
    animal_index=find(manual_delete_hypoxic(1,:)==animal);
    if isempty(animal_index)
       LH=0;
       RH=0;
    else
       hemi_info=manual_delete_hypoxic(2,animal_index);
       if hemi_info==1
           LH=0;
           RH=1;
       elseif hemi_info == 2
           LH = 1;
           RH = 0;
       elseif hemi_info == 3
           LH = 1;
           RH = 1;
       end
    end
end


%groupdata_contra, grouptracker_contra,groupdata_ipsi,grouptracker_ipsi,srpdays,group,DayHolder
function [groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal)

%I still need to fix loaded data SRP threshold for day 1 when there are
%less than 5 srpdays.

%Working on correct row location for extracting data from endplot for
%srpdays < 5 condition.

DayHolder=0;
if isempty(SRP_groupname)==1
    dataloaded=0;
end
           while DayHolder<srpdays
               if srpdays < 5
                    DayHolder=0;
                    RemoveLeft=0;
                    RemoveRight=0;
                    %CHECK SRP ENDPLOT DAY 1 VALUE
                    clear clearhemi
                    [clear_LH,clear_RH]=check_hemi(trueanimal,group);
                    if dataloaded==1
                        check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,2}; %LH Day 1 Binoc SRP Value
                        if check_value < SRP_Thresh/AMPGain || clear_LH == 1
                            RemoveLeft=1;
                        end
                        check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,3}; %LH Day 1 Binoc SRP Value
                        if check_value < SRP_Thresh/AMPGain || clear_RH == 1
                            RemoveRight=1;
                        end
                    else
                        if clear_LH == 1
                            RemoveLeft=1;
                        end
                        if clear_RH == 1
                            RemoveRight=1;
                        end
                    end
               end
               if DayHolder==0 && srpdays == 5
                    RemoveLeft=0;
                    RemoveRight=0;
                    %CHECK SRP ENDPLOT DAY 1 VALUE
                    clear clearhemi
                    [clear_LH,clear_RH]=check_hemi(trueanimal,group);
                    if dataloaded==1
                        check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,2}; %LH Day 1 Binoc SRP Value
                        if check_value < SRP_Thresh/AMPGain || clear_LH == 1
                            RemoveLeft=1;
                        end
                        check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,3}; %LH Day 1 Binoc SRP Value
                        if check_value < SRP_Thresh/AMPGain || clear_RH == 1
                            RemoveRight=1;
                        end
                    else
                        if clear_LH == 1
                            RemoveLeft=1;
                        end
                        if clear_RH == 1
                            RemoveRight=1;
                        end
                    end
                    %LEFT EYE OPEN
                    if RemoveLeft==1
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %LH Novel Always
                        [~,windowsize]=size(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:));
                        groupdata_ipsi_waveforms(group,grouptracker_ipsi(1,6),1:windowsize)=Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:);
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    else
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    end
                    
                    if RemoveRight==1
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    else
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    end
                    
                    
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    end
                       
                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    end
                        
                    %RIGHT EYE OPEN
                    if RemoveLeft == 1
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    else
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,4}; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                    end

                    if RemoveRight == 1
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    else    
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,5}; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                    end
                    
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                    end


                        DayHolder=DayHolder+1;
               else
                    if srpdays < 5
                        modvalue=DayHolder+1;
                    else
                        modvalue=DayHolder;
                    end
                    %LEYE OPEN
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,modvalue),modvalue)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,modvalue)=grouptracker_ipsi(1,modvalue)+1;
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,modvalue),modvalue)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,modvalue)=grouptracker_ipsi(1,modvalue)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,modvalue),modvalue)=NaN; %RH Familiar Always
                        grouptracker_contra(1,modvalue)=grouptracker_contra(1,modvalue)+1;
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,modvalue),modvalue)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,modvalue)=grouptracker_contra(1,modvalue)+1;
                    end

                        
                    %REYE OPEN
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,modvalue),modvalue)=NaN; %LH Familiar Always
                        grouptracker_contra(1,modvalue)=grouptracker_contra(1,modvalue)+1;
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,modvalue),modvalue)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,modvalue)=grouptracker_contra(1,modvalue)+1;
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,modvalue),modvalue)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,modvalue)=grouptracker_ipsi(1,modvalue)+1;
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,modvalue),modvalue)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,modvalue)=grouptracker_ipsi(1,modvalue)+1;
                    end
                    %Sanity Check
                    %if groupdata_contragroupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)
                    DayHolder=DayHolder+1;
               end
           end
           %This small chunk of code is not working atm.
%            [~,marg,~]=size(groupdata_ipsi)
%            for test=1:6
%                if groupdata_contra(group,marg-1,test)/groupdata_ipsi(group,marg-1,test) > 5
%                    figure(1);
%                    subplot(1,2,1);
%                    plot(Data.(groupname).(char((Data.(groupname).EndPlotData{marg/2+test,1}))).AveragedWaveFormR(2,:),'Color','k')
%                    subplot(1,2,2);
%                    plot(Data.(groupname).(char((Data.(groupname).EndPlotData{marg/2+test,1}))).AveragedWaveFormR(2,:),'Color','k')
%                end
%            end
                        
%groupdata_contra, grouptracker_contra,groupdata_ipsi,grouptracker_ipsi,srpdays,group,DayHolder
function [groupdata_contra,grouptracker_contra,groupdata_ipsi,grouptracker_ipsi]=hemi_loop_withplots(groupdata_contra,groupdata_ipsi,AnimalNum,grouptracker_ipsi,grouptracker_contra,SRP_groupname,SRP_Thresh,AMPGain,animalloop,SRP_Data,group,Data,groupname,srpdays,trueanimal)
DayHolder=0;
min_ipsi=20;
mid_ipsi=250;
max_ipsi=475;
min_contra=20;
mid_contra=100;
max_contra=250;
           while DayHolder<srpdays
               if DayHolder==0
                    RemoveLeft=0;
                    RemoveRight=0;
                    %CHECK SRP ENDPLOT DAY 1 VALUE
                    clear clearhemi
                    [clear_LH,clear_RH]=check_hemi(trueanimal,group);
                    check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,2}; %LH Day 1 Binoc SRP Value
                    if check_value < SRP_Thresh/AMPGain || clear_LH == 1
                        RemoveLeft=1;
                    end
                    check_value=SRP_Data.(SRP_groupname).EndPlotData{animalloop+1,3}; %LH Day 1 Binoc SRP Value
                    if check_value < SRP_Thresh/AMPGain || clear_RH == 1
                        RemoveRight=1;
                    end
                    if SRP_Thresh==0
                        RemoveRight=0;
                        RemoveLeft=0;
                    end
                    %LEFT EYE OPEN
                    if RemoveLeft==1
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %LH Novel Always
                        
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                        figure(1);
                        subplot(2,6,12);
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else
                        %(Novel) LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                        figure(1);
                        subplot(2,6,12);
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end
                    
                    if RemoveRight==1
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                        figure(2);
                        subplot(2,6,6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %(Novel) RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                        figure(2);
                        subplot(2,6,6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end
                    
                    
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                        figure(1);
                        subplot(2,6,11)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                        figure(1);
                        subplot(2,6,11)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end
                       
                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                        figure(2);
                        subplot(2,6,5)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                        figure(2);
                        subplot(2,6,5)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end
                        
                    %RIGHT EYE OPEN
                    if RemoveLeft == 1
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=NaN; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                        figure(1);
                        subplot(2,6,6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %(Novel) LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,4}; %LH Novel Always
                        grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
                        figure(1);
                        subplot(2,6,6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end

                    if RemoveRight == 1
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=NaN; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                        figure(2);
                        subplot(2,6,12)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else    
                        %(Novel) RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,5}; %RH Novel Always
                        grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
                        figure(2);
                        subplot(2,6,12)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end
                    
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=NaN; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                        figure(1);
                        subplot(2,6,5)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
                        figure(1);
                        subplot(2,6,5)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                        figure(2);
                        subplot(2,6,11)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
                        figure(2);
                        subplot(2,6,11)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end


                        DayHolder=DayHolder+1;
                else
                    %LEYE OPEN
                    if DayHolder==1
                        Title=cellstr(Data.(groupname).EndPlotData{(animalloop+DayHolder),1});
                        TitleString1=sprintf('%s Left Hemipshere',Title{1,1});
                    end
                    if RemoveLeft == 1
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                        figure(1);
                        subplot(2,6,DayHolder+6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormL(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else
                        %LH w/ LEYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                        figure(1);
                        subplot(2,6,DayHolder+6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormL(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end

                    if RemoveRight == 1
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                        figure(2);
                        subplot(2,6,DayHolder)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormR(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %RH w/ LEYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                        figure(2);
                        subplot(2,6,DayHolder)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormR(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end

                        
                    %REYE OPEN
                    if DayHolder==1
                        Title=cellstr(Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1});
                        TitleString2=sprintf('%s Right Hemisphere',Title{1,1});
                    end
                    if RemoveLeft == 1
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=NaN; %LH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                        figure(1);
                        subplot(2,6,DayHolder)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    else
                        %LH w/ REYE = CONTRA
                        groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
                        grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
                        figure(1);
                        subplot(2,6,DayHolder)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,min_contra:mid_contra));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,minloc:max_contra));
                        plotline(minloc,maxloc,minval,maxval,1)
                    end

                    if RemoveRight == 1
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=NaN; %RH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                        figure(2);
                        subplot(2,6,DayHolder+6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:),'Color','k')
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    else
                        %RH w/ REYE = IPSI
                        groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
                        grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
                        figure(2);
                        subplot(2,6,DayHolder+6)
                        plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:))
                        [minval,minloc]=min(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,min_ipsi:mid_ipsi));
                        minloc=minloc+19;
                        [maxval,maxloc]=max(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,minloc:max_ipsi));
                        plotline(minloc,maxloc,minval,maxval,2)
                    end
                    DayHolder=DayHolder+1;
               end
           end
        figure(1)
        ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,TitleString1,'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'interpreter', 'none')
        figure(2)
        ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,TitleString2,'HorizontalAlignment' ,'center','VerticalAlignment', 'top','interpreter', 'none')
        if group == 1
            export_fig 'Normoxic' -pdf -append
        elseif group == 2
            export_fig 'Hypoxic' -pdf -append
        end
        close(1);
        close(2);
        
function [output]=averagewaveforms(input)
%Input needs to be in the format (groups,objects,waveform_data)
%Example: test(2,23,495)
%Would mean there are 2 groups
%With a maximum of 23 objects (if row is unused fill with NaN values)
%where each waveform consists of 495 data points
[groups,objects,waveform_data]=size(input);
        
function plotline(minloc,maxloc,minval,maxval,waveform)
%1 = contra
%2 = ipsi
        hold on
        plot([(minloc) (minloc)],[minval-.025 minval+.025],'Color','r')
        plot([(maxloc+minloc) (maxloc+minloc)],[maxval-.025 maxval+.025],'Color','g')
        hold off
        if waveform == 1
            ylim([-.3 .3])
        else
            ylim([-.3 .3])
        end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%OLD USEFUL CODE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    if DayHolder==0
%                     %LEFT EYE OPEN
% %                     figure(1);
%                         %(Novel) LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,4}; %LH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
% %                         subplot(2,6,12);
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(2,:))
% %                         ylim([-.3 .3])
%                         
%                         %(Novel) RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{animalloop+DayHolder,5}; %RH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
% %                         subplot(2,6,6)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(2,:))
% %                         ylim([-.3 .3])
%                         
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
% %                         subplot(2,6,11)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormL(1,:))
% %                         ylim([-.3 .3])
%                         
%                         %RH w/ LEYE = CONTRA
% %                         subplot(2,6,5)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{animalloop+DayHolder,1}))).AveragedWaveFormR(1,:))
% %                         ylim([-.3 .3])
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
%                         
%                     %RIGHT EYE OPEN
% %                     figure(2);
%                         %(Novel) LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,4}; %LH Novel Always
%                         grouptracker_contra(1,6)=grouptracker_contra(1,6)+1;
% %                         subplot(2,6,6)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(2,:))
% %                         ylim([-.3 .3])
%                         %(Novel) RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,6),srpdays+1)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,5}; %RH Novel Always
%                         grouptracker_ipsi(1,6)=grouptracker_ipsi(1,6)+1;
% %                         subplot(2,6,12)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(2,:))
% %                         ylim([-.3 .3])
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
%                         grouptracker_contra(1,5)=grouptracker_contra(1,5)+1;
% %                         subplot(2,6,5)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:))
% %                         ylim([-.3 .3])
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,5),srpdays)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
%                         grouptracker_ipsi(1,5)=grouptracker_ipsi(1,5)+1;
% %                         subplot(2,6,11)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:))
% %                         ylim([-.3 .3])
% 
%                         
%                         DayHolder=DayHolder+1;
%                    else
%                     %LEYE OPEN
% %                     figure(1);
% %                     if DayHolder==1
% %                         Title=cellstr(Data.(groupname).EndPlotData{(animalloop+DayHolder),1});
% %                         TitleString1=sprintf('%s',Title{1,1});
% %                     end
%                         %LH w/ LEYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,2}; %LH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
% %                         subplot(2,6,DayHolder+6)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormL(1,:))
% %                         ylim([-.3 .3])
%                         %RH w/ LEYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{animalloop+DayHolder,3}; %RH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
% %                         subplot(2,6,DayHolder)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+DayHolder),1}))).AveragedWaveFormR(1,:))
% %                         ylim([-.3 .3])
%                         
%                     %REYE OPEN
% %                     figure(2);
% %                     if DayHolder==1
% %                         Title=cellstr(Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1});
% %                         TitleString2=sprintf('%s',Title{1,1});
% %                     end
%                         %LH w/ REYE = CONTRA
%                         groupdata_contra(group,grouptracker_contra(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,2}; %LH Familiar Always
%                         grouptracker_contra(1,DayHolder)=grouptracker_contra(1,DayHolder)+1;
% %                         subplot(2,6,DayHolder)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormL(1,:))
% %                         ylim([-.3 .3])
%                         
%                         %RH w/ REYE = IPSI
%                         groupdata_ipsi(group,grouptracker_ipsi(1,DayHolder),DayHolder)=Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,3}; %RH Familiar Always
%                         grouptracker_ipsi(1,DayHolder)=grouptracker_ipsi(1,DayHolder)+1;
% %                         subplot(2,6,DayHolder+6)
% %                         plot(Data.(groupname).(char((Data.(groupname).EndPlotData{(animalloop+(AnimalNum*srpdays))+DayHolder,1}))).AveragedWaveFormR(1,:))
% %                         ylim([-.3 .3])
%                         
%                         
%                         DayHolder=DayHolder+1;
%                         
%                    end
%                 figure(1)
%                 ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%                 text(0.5, 1,TitleString1,'HorizontalAlignment' ,'center','VerticalAlignment', 'top')
%                 figure(2)
%                 ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%                 text(0.5, 1,TitleString2,'HorizontalAlignment' ,'center','VerticalAlignment', 'top')

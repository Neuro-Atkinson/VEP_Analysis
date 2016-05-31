function varargout = SrpOptions_General(varargin)
% SRPOPTIONS_GENERAL MATLAB code for SrpOptions_General.fig
%      SRPOPTIONS_GENERAL, by itself, creates a new SRPOPTIONS_GENERAL or raises the existing
%      singleton*.
%
%      H = SRPOPTIONS_GENERAL returns the handle to a new SRPOPTIONS_GENERAL or the handle to
%      the existing singleton*.
%
%      SRPOPTIONS_GENERAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRPOPTIONS_GENERAL.M with the given input arguments.
%
%      SRPOPTIONS_GENERAL('Property','Value',...) creates a new SRPOPTIONS_GENERAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SrpOptions_General_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SrpOptions_General_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SrpOptions_General

% Last Modified by GUIDE v2.5 12-Jan-2016 16:22:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SrpOptions_General_OpeningFcn, ...
                   'gui_OutputFcn',  @SrpOptions_General_OutputFcn, ...
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


% --- Executes just before SrpOptions_General is made visible.
function SrpOptions_General_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SrpOptions_General (see VARARGIN)

% Choose default command line output for SrpOptions_General
handles.output = hObject;
handles.forceclose=0;
axes(handles.axes1);
imshow('MouseBinoc.png')
% Update handles structure
% 
LoadOptions=getappdata(0,'SRP_options');
if isempty(LoadOptions)==0
    looplength=length(LoadOptions);
    for i=1:looplength
        if i <= 5
            set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));
            if i <= 3
                if i == 1
                    if (LoadOptions{i,2})==1
                        imshow('MouseBinoc.png')
                    end
                elseif i == 2
                    if (LoadOptions{i,2})==1
                        imshow('MouseLeye.png')
                    end
                elseif i == 3
                    if (LoadOptions{i,2})==1
                        imshow('MouseReye.png')
                    end
                else
                    debug = 1;
                end
            end
        elseif i < 12
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        elseif i < 13
            set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));
        elseif i < 16
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        end
    end
end
chkkey = isappdata(0,'week1key');
if chkkey == 1
    set(handles.output_week1key,'BackgroundColor',[0 1 0]);
    set(handles.output_week1key,'String','Data Loaded');
end
handles.error=0;
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)



% UIWAIT makes SrpOptions_General wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SrpOptions_General_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SRP_options_leye.
function SRP_options_leye_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_leye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of SRP_options_leye


% --- Executes on button press in SRP_options_leye.
function SRP_options_binoc_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_leye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of SRP_options_leye


% --- Executes on button press in SRP_options_reye.
function SRP_options_reye_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_reye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of SRP_options_reye



% --- Executes when selected object is changed in EyeConfig.
function EyeConfig_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in EyeConfig 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'SRP_options_binoc'
        axes(handles.axes1);
        imshow('MouseBinoc.png')
        guidata(hObject, handles);
    case 'SRP_options_leye'
        axes(handles.axes1);
        imshow('MouseLeye.png')
        guidata(hObject, handles);
    case 'SRP_options_reye'
        axes(handles.axes1);
        imshow('MouseReye.png')
        guidata(hObject, handles);
end



function SRP_options_num_srpdays_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_srpdays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_num_srpdays as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_num_srpdays as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_num_srpdays_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_srpdays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SRP_options_num_flips_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_flips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_num_flips as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_num_flips as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_num_flips_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_flips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SRP_options_num_flops_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_flops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_num_flops as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_num_flops as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_num_flops_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_flops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SRP_options_num_trials_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_num_trials as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_num_trials as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_num_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SRP_options_extract_all_amplitudes.
function SRP_options_extract_all_amplitudes_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_extract_all_amplitudes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRP_options_extract_all_amplitudes


% --- Executes on button press in SRP_options_run_vidget.
function SRP_options_run_vidget_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_run_vidget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRP_options_run_vidget



function SRP_options_event_num_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_event_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_event_num as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_event_num as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_event_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_event_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SRP_options_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_thresh as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_thresh as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modified_closefcn(hObject, eventdata, handles)
SRPSettingsHandles=guidata(hObject);
if SRPSettingsHandles.forceclose==1
    delete(hObject);
else
    if SRPSettingsHandles.error >=1
        msgbox('You can not confirm settings if errors are present.','Error')
    else
        SRP_options{1,1}='SRP_options_binoc';
        SRP_options{1,2}=get(SRPSettingsHandles.(SRP_options{1,1}),'Value');
        SRP_options{2,1}='SRP_options_leye';
        SRP_options{2,2}=get(SRPSettingsHandles.(SRP_options{2,1}),'Value');
        SRP_options{3,1}='SRP_options_reye';
        SRP_options{3,2}=get(SRPSettingsHandles.(SRP_options{3,1}),'Value');
        SRP_options{4,1}='SRP_options_run_vidget';
        SRP_options{4,2}=get(SRPSettingsHandles.(SRP_options{4,1}),'Value');
        SRP_options{5,1}='SRP_options_extract_all_amplitudes';
        SRP_options{5,2}=get(SRPSettingsHandles.(SRP_options{5,1}),'Value');
        SRP_options{6,1}='SRP_options_thresh';
        SRP_options{6,2}=get(SRPSettingsHandles.(SRP_options{6,1}),'String');
        SRP_options{7,1}='SRP_options_num_srpdays';
        SRP_options{7,2}=get(SRPSettingsHandles.(SRP_options{7,1}),'String');
        SRP_options{8,1}='SRP_options_num_flips';
        SRP_options{8,2}=get(SRPSettingsHandles.(SRP_options{8,1}),'String');
        SRP_options{9,1}='SRP_options_num_flops';
        SRP_options{9,2}=get(SRPSettingsHandles.(SRP_options{9,1}),'String');
        SRP_options{10,1}='SRP_options_num_trials';
        SRP_options{10,2}=get(SRPSettingsHandles.(SRP_options{10,1}),'String');
        SRP_options{11,1}='SRP_options_event_num';
        SRP_options{11,2}=get(SRPSettingsHandles.(SRP_options{11,1}),'String');
        SRP_options{12,1}='SRP_options_week2srp';
        SRP_options{12,2}=get(SRPSettingsHandles.(SRP_options{12,1}),'Value');
        SRP_options{13,1}='SRP_options_pretime';
        SRP_options{13,2}=get(SRPSettingsHandles.(SRP_options{13,1}),'String');
        SRP_options{14,1}='SRP_options_posttime';
        SRP_options{14,2}=get(SRPSettingsHandles.(SRP_options{14,1}),'String');
        SRP_options{15,1}='SRP_options_gray_extract';
        SRP_options{15,2}=get(SRPSettingsHandles.(SRP_options{15,1}),'String');
        setappdata(0,'SRP_options',SRP_options);
        setappdata(0,'SRP_options_confirmed',2);
        AnalysisHandles = guidata(SRPAnalysis_Master);
        set(AnalysisHandles.SRPSettingsIndicator,'Backgroundcolor',[0 1 0]);
        
        group_options_check=get(AnalysisHandles.GroupSettingsIndicator,'Backgroundcolor');
        if group_options_check == [0 1 0]
            set(AnalysisHandles.SRP_run_analysis,'Enable','on');
        end
        
        delete(hObject);  
    end
end


function checkinput(hObject, userinput, handles)
    checkerror=get(hObject,'Backgroundcolor');
    if checkerror(1,1)==1 && checkerror(1,2) == 0 && checkerror(1,3) == 0
        number=str2num(userinput);
        checknumber=isempty(number);
        if checknumber==1
            msgbox('Input needs to be a number','Error')
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
        else
            checkint=isinteger(int8(number));
            if checkint == 0
                msgbox('Input needs to be a number','Error')
                set(hObject,'String',''); 
                set(hObject,'Backgroundcolor','r');
            else
                handles.error=handles.error-1;
                set(hObject,'Backgroundcolor','g');
            end
        end
    else
        if handles.error >= 1
            set(hObject,'String',''); 
            set(hObject,'Backgroundcolor','r');
            handles.error=handles.error+1;
            msgbox('There are other errors that should be corrected first.','Error')
        else
            number=str2num(userinput);
            checknumber=isempty(number);
            if checknumber==1
                handles.error=handles.error+1;
                msgbox('Input needs to be a number','Error')
                set(hObject,'String',''); 
                set(hObject,'Backgroundcolor','r');
            else
                checkint=isinteger(int8(number));
                if checkint == 0
                    handles.error=handles.error+1;
                    msgbox('Input needs to be a number','Error')
                    set(hObject,'String',''); 
                    set(hObject,'Backgroundcolor','r');
                else
                    handles.error=handles.error-1;
                    set(hObject,'Backgroundcolor','g');
                end
            end
        end
    end
guidata(hObject, handles);


% --- Executes on button press in SRP_options_week2srp.
function SRP_options_week2srp_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_week2srp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SRP_options_week2srp


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function forceclose_Callback(hObject, eventdata, handles)
% hObject    handle to forceclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.forceclose=1;
set(hObject,'Checked','on');
guidata(hObject,handles);



function SRP_options_pretime_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_pretime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_pretime as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_pretime as a double


% --- Executes during object creation, after setting all properties.
function SRP_options_pretime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_pretime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SRP_options_posttime_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_posttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_posttime as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_posttime as a double


% --- Executes during object creation, after setting all properties.
function SRP_options_posttime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_posttime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in week1key.
function week1key_Callback(hObject, eventdata, handles)
% hObject    handle to week1key (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
chkkey = isappdata(0,'week1key');
if chkkey == 1
    rmappdata(0,'week1key');
end
set(handles.week1key,'Enable','off');
if isfield(handles,'SRPData_Loaded')
    handles=rmfield(handles,'SRPData_Loaded');
end
guidata(hObject, handles);
set(handles.output_week1key,'String','Loading...');
set(handles.output_week1key,'BackgroundColor',[1 .6 0]);
drawnow;
[FileName,PathName,~] = uigetfile('*.mat','Select processed data');
if isequal(FileName,0)
   set(handles.week1key,'Enable','on');
   set(handles.output_week1key,'String','No Files Loaded');
   return;
end
combinedname=sprintf('%s%s',PathName,FileName);
handles.SRPData_Loaded=load(combinedname,'-mat');
setappdata(0,'week1key',handles.SRPData_Loaded);
set(handles.output_week1key,'BackgroundColor',[0 1 0]);
set(handles.output_week1key,'String','Data Loaded');
set(handles.output_week1key,'Enable','on');
guidata(hObject, handles);



function SRP_options_gray_extract_Callback(hObject, eventdata, handles)
% hObject    handle to SRP_options_gray_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SRP_options_gray_extract as text
%        str2double(get(hObject,'String')) returns contents of SRP_options_gray_extract as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function SRP_options_gray_extract_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SRP_options_gray_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

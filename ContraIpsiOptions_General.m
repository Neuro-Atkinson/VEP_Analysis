function varargout = ContraIpsiOptions_General(varargin)
% CONTRAIPSIOPTIONS_GENERAL MATLAB code for ContraIpsiOptions_General.fig
%      CONTRAIPSIOPTIONS_GENERAL, by itself, creates a new CONTRAIPSIOPTIONS_GENERAL or raises the existing
%      singleton*.
%
%      H = CONTRAIPSIOPTIONS_GENERAL returns the handle to a new CONTRAIPSIOPTIONS_GENERAL or the handle to
%      the existing singleton*.
%
%      CONTRAIPSIOPTIONS_GENERAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTRAIPSIOPTIONS_GENERAL.M with the given input arguments.
%
%      CONTRAIPSIOPTIONS_GENERAL('Property','Value',...) creates a new CONTRAIPSIOPTIONS_GENERAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContraIpsiOptions_General_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContraIpsiOptions_General_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContraIpsiOptions_General

% Last Modified by GUIDE v2.5 11-Feb-2015 16:27:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContraIpsiOptions_General_OpeningFcn, ...
                   'gui_OutputFcn',  @ContraIpsiOptions_General_OutputFcn, ...
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


% --- Executes just before ContraIpsiOptions_General is made visible.
function ContraIpsiOptions_General_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContraIpsiOptions_General (see VARARGIN)

% Choose default command line output for ContraIpsiOptions_General
handles.output = hObject;
handles.forceclose=0;

% Update handles structure
% 
LoadOptions=getappdata(0,'ContraIpsi_options');
if isempty(LoadOptions)==0
    looplength=length(LoadOptions);
    for i=1:looplength
        if i <= 5
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        elseif i == 6
            set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));
        else
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        end
    end
end
handles.error=0;
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)



% UIWAIT makes ContraIpsiOptions_General wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContraIpsiOptions_General_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function ContraIpsi_options_num_srpdays_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_srpdays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ContraIpsi_options_num_srpdays as text
%        str2double(get(hObject,'String')) returns contents of ContraIpsi_options_num_srpdays as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function ContraIpsi_options_num_srpdays_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_srpdays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ContraIpsi_options_num_flips_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_flips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ContraIpsi_options_num_flips as text
%        str2double(get(hObject,'String')) returns contents of ContraIpsi_options_num_flips as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function ContraIpsi_options_num_flips_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_flips (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ContraIpsi_options_num_flops_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_flops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ContraIpsi_options_num_flops as text
%        str2double(get(hObject,'String')) returns contents of ContraIpsi_options_num_flops as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function ContraIpsi_options_num_flops_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_flops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ContraIpsi_options_num_trials_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ContraIpsi_options_num_trials as text
%        str2double(get(hObject,'String')) returns contents of ContraIpsi_options_num_trials as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function ContraIpsi_options_num_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_num_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ContraIpsi_options_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ContraIpsi_options_thresh as text
%        str2double(get(hObject,'String')) returns contents of ContraIpsi_options_thresh as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);

% --- Executes during object creation, after setting all properties.
function ContraIpsi_options_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modified_closefcn(hObject, eventdata, handles)
ContraIpsiSettingsHandles=guidata(hObject);
if ContraIpsiSettingsHandles.forceclose==1
    delete(hObject);
else
    if ContraIpsiSettingsHandles.error >=1
        msgbox('You can not confirm settings if errors are present.','Error')
    else
        ContraIpsi_options{1,1}='ContraIpsi_options_thresh';
        ContraIpsi_options{1,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{1,1}),'String');
        ContraIpsi_options{2,1}='ContraIpsi_options_num_srpdays';
        ContraIpsi_options{2,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{2,1}),'String');
        ContraIpsi_options{3,1}='ContraIpsi_options_num_flips';
        ContraIpsi_options{3,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{3,1}),'String');
        ContraIpsi_options{4,1}='ContraIpsi_options_num_flops';
        ContraIpsi_options{4,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{4,1}),'String');
        ContraIpsi_options{5,1}='ContraIpsi_options_num_trials';
        ContraIpsi_options{5,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{5,1}),'String');
%         ContraIpsi_options{11,1}='ContraIpsi_options_event_num';
%         ContraIpsi_options{11,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{11,1}),'String');
        ContraIpsi_options{6,1}='ContraIpsi_options_week2srp';
        ContraIpsi_options{6,2}=get(ContraIpsiSettingsHandles.(ContraIpsi_options{6,1}),'Value');
        
        setappdata(0,'ContraIpsi_options',ContraIpsi_options);
        setappdata(0,'ContraIpsi_options_confirmed',2);
        AnalysisHandles = guidata(ContraIpsiAnalysis_Master);
        set(AnalysisHandles.output_OptionsIndicator,'Backgroundcolor',[0 1 0]);
        
        group_options_check=get(AnalysisHandles.output_GroupIndicator,'Backgroundcolor');
        if group_options_check == [0 1 0]
            set(AnalysisHandles.button_ProcessData,'Enable','on');
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


% --- Executes on button press in ContraIpsi_options_week2srp.
function ContraIpsi_options_week2srp_Callback(hObject, eventdata, handles)
% hObject    handle to ContraIpsi_options_week2srp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ContraIpsi_options_week2srp


% --------------------------------------------------------------------
function forceclose_Callback(hObject, eventdata, handles)
% hObject    handle to forceclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.forceclose=1;
set(hObject,'Checked','on');
guidata(hObject,handles);

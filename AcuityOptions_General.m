function varargout = AcuityOptions_General(varargin)
% ACUITYOPTIONS_GENERAL MATLAB code for AcuityOptions_General.fig
%      ACUITYOPTIONS_GENERAL, by itself, creates a new ACUITYOPTIONS_GENERAL or raises the existing
%      singleton*.
%
%      H = ACUITYOPTIONS_GENERAL returns the handle to a new ACUITYOPTIONS_GENERAL or the handle to
%      the existing singleton*.
%
%      ACUITYOPTIONS_GENERAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACUITYOPTIONS_GENERAL.M with the given input arguments.
%
%      ACUITYOPTIONS_GENERAL('Property','Value',...) creates a new ACUITYOPTIONS_GENERAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AcuityOptions_General_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AcuityOptions_General_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AcuityOptions_General

% Last Modified by GUIDE v2.5 23-Apr-2014 23:32:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AcuityOptions_General_OpeningFcn, ...
                   'gui_OutputFcn',  @AcuityOptions_General_OutputFcn, ...
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


% --- Executes just before AcuityOptions_General is made visible.
function AcuityOptions_General_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AcuityOptions_General (see VARARGIN)

% Choose default command line output for AcuityOptions_General
handles.output = hObject;

LoadOptions=getappdata(0,'ACU_options');
if isempty(LoadOptions)==0
    looplength=length(LoadOptions);
    for i=1:looplength
        if i <= 5
            set(handles.(LoadOptions{i,1}),'String',(LoadOptions{i,2}));
        elseif i <= 8
            set(handles.(LoadOptions{i,1}),'Value',(LoadOptions{i,2}));  
        else
            set(handles.(LoadOptions{i,1}),'Data',(LoadOptions{i,2}));  
        end
    end
end

handles.error=0;
% Update handles structure
guidata(hObject, handles);
set(gcf,'CloseRequestFcn',@modified_closefcn)

% UIWAIT makes AcuityOptions_General wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AcuityOptions_General_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ACU_options_groups_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACU_options_groups as text
%        str2double(get(hObject,'String')) returns contents of ACU_options_groups as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function ACU_options_groups_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_groups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ACU_options_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACU_options_thresh as text
%        str2double(get(hObject,'String')) returns contents of ACU_options_thresh as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function ACU_options_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ACU_options_showcombined.
function ACU_options_showcombined_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_showcombined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ACU_options_showcombined


% --- Executes on button press in ACU_options_showleft.
function ACU_options_showleft_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_showleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ACU_options_showleft


% --- Executes on button press in ACU_options_showright.
function ACU_options_showright_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_showright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ACU_options_showright



function ACU_options_windowmin_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_windowmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACU_options_windowmin as text
%        str2double(get(hObject,'String')) returns contents of ACU_options_windowmin as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function ACU_options_windowmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_windowmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ACU_options_windowmax_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_windowmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACU_options_windowmax as text
%        str2double(get(hObject,'String')) returns contents of ACU_options_windowmax as a double
userinput=get(hObject,'String');
checkinput(hObject, userinput, handles);


% --- Executes during object creation, after setting all properties.
function ACU_options_windowmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_windowmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ACU_options_acuitycodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_acuitycodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', {'.05','.1','.2','.3','.4','.5','.6','.7'});


% --- Executes during object creation, after setting all properties.
function ACU_options_acuityeventcodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_acuityeventcodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', {1 3 5 7 9 11 13 15;2 4 6 8 10 12 14 16});



function ACU_options_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to ACU_options_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ACU_options_contrast as text
%        str2double(get(hObject,'String')) returns contents of ACU_options_contrast as a double


% --- Executes during object creation, after setting all properties.
function ACU_options_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ACU_options_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function modified_closefcn(hObject, eventdata, handles)
AcuitySettingsHandles=guidata(hObject);
if AcuitySettingsHandles.error >=1
    msgbox('You can not confirm settings if errors are present.','Error')
else
ACU_options{1,1}='ACU_options_groups';
ACU_options{1,2}=get(AcuitySettingsHandles.(ACU_options{1,1})','String');
ACU_options{2,1}='ACU_options_thresh';
ACU_options{2,2}=get(AcuitySettingsHandles.(ACU_options{2,1})','String');
ACU_options{3,1}='ACU_options_contrast';
ACU_options{3,2}=get(AcuitySettingsHandles.(ACU_options{3,1})','String');
ACU_options{4,1}='ACU_options_windowmin';
ACU_options{4,2}=get(AcuitySettingsHandles.(ACU_options{4,1})','String');
ACU_options{5,1}='ACU_options_windowmax';
ACU_options{5,2}=get(AcuitySettingsHandles.(ACU_options{5,1})','String');
ACU_options{6,1}='ACU_options_showcombined';
ACU_options{6,2}=get(AcuitySettingsHandles.(ACU_options{6,1})','Value');
ACU_options{7,1}='ACU_options_showleft';
ACU_options{7,2}=get(AcuitySettingsHandles.(ACU_options{7,1})','Value');
ACU_options{8,1}='ACU_options_showright';
ACU_options{8,2}=get(AcuitySettingsHandles.(ACU_options{8,1})','Value');
ACU_options{9,1}='ACU_options_acuitycodes';
ACU_options{9,2}=get(AcuitySettingsHandles.(ACU_options{9,1})','Data');
ACU_options{10,1}='ACU_options_acuityeventcodes';
ACU_options{10,2}=get(AcuitySettingsHandles.(ACU_options{10,1})','Data');
setappdata(0,'ACU_options',ACU_options);
setappdata(0,'ACU_options_confirmed',2);
AnalysisHandles = guidata(AcuityAnalysis_Master);
set(AnalysisHandles.AcuitySettingsIndicator,'Backgroundcolor',[0 1 0]);
delete(hObject);  
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

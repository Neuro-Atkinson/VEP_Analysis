function varargout = notepad(varargin)
% NOTEPAD MATLAB code for notepad.fig
%      NOTEPAD, by itself, creates a new NOTEPAD or raises the existing
%      singleton*.
%
%      H = NOTEPAD returns the handle to a new NOTEPAD or the handle to
%      the existing singleton*.
%
%      NOTEPAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOTEPAD.M with the given input arguments.
%
%      NOTEPAD('Property','Value',...) creates a new NOTEPAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before notepad_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to notepad_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help notepad

% Last Modified by GUIDE v2.5 02-Aug-2014 15:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @notepad_OpeningFcn, ...
                   'gui_OutputFcn',  @notepad_OutputFcn, ...
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


% --- Executes just before notepad is made visible.
function notepad_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to notepad (see VARARGIN)

% Choose default command line output for notepad
handles.output = hObject;
set(gcf,'CloseRequestFcn',@modified_closefcn)
CleanDataGUI=guidata(SRP_DataCleanup);
if isfield(CleanDataGUI,'notepad_txt')==1
    set(handles.notepad_txt,'String',CleanDataGUI.notepad_txt);
else
    set(handles.notepad_txt,'String','');
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes notepad wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = notepad_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



      
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function notepad_txt_Callback(hObject, eventdata, handles)
% hObject    handle to notepad_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of notepad_txt as text
%        str2double(get(hObject,'String')) returns contents of notepad_txt as a double


% --- Executes during object creation, after setting all properties.
function notepad_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to notepad_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gui_notepad_save.
function gui_notepad_save_Callback(hObject, eventdata, handles)
% hObject    handle to gui_notepad_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CleanDataGUI=guidata(SRP_DataCleanup);
CleanDataGUI.notepad_txt=get(handles.notepad_txt,'String');
guidata(CleanDataGUI.figure1,CleanDataGUI)
bringtofrong=guidata(notepad);
guidata(hObject,handles);



function modified_closefcn(hObject, eventdata, handles)
NoteGUI = guidata(hObject);
CleanDataGUI = guidata(SRP_DataCleanup);
CleanDataGUI.notepad_txt=get(NoteGUI.notepad_txt,'String');
guidata(CleanDataGUI.figure1,CleanDataGUI)
delete(hObject); 

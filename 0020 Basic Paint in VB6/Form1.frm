VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00808080&
   Caption         =   "Basic Paint"
   ClientHeight    =   8340
   ClientLeft      =   225
   ClientTop       =   870
   ClientWidth     =   12600
   LinkTopic       =   "Form1"
   ScaleHeight     =   8340
   ScaleWidth      =   12600
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog dlgfilesystem 
      Left            =   8040
      Top             =   960
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.PictureBox palette_box 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0E0FF&
      ForeColor       =   &H80000008&
      Height          =   1575
      Left            =   0
      ScaleHeight     =   1545
      ScaleWidth      =   7425
      TabIndex        =   1
      Top             =   0
      Width           =   7455
      Begin VB.CommandButton colorkeys 
         Height          =   495
         Index           =   0
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   240
         Width           =   735
      End
      Begin VB.Shape colorkeyborder 
         BorderWidth     =   4
         Height          =   375
         Left            =   840
         Top             =   960
         Width           =   375
      End
   End
   Begin VB.PictureBox canvas 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   3495
      Left            =   240
      ScaleHeight     =   3465
      ScaleWidth      =   8865
      TabIndex        =   0
      Top             =   2160
      Width           =   8895
   End
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Begin VB.Menu mnuFileNew 
         Caption         =   "New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuFileOpen 
         Caption         =   "Open"
         Shortcut        =   {F3}
      End
      Begin VB.Menu mnuFileSave 
         Caption         =   "Save"
         Shortcut        =   {F2}
      End
      Begin VB.Menu mnuFileSaveAs 
         Caption         =   "Save As"
         Shortcut        =   {F8}
      End
      Begin VB.Menu mnuFileSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'
'========================================================================================
'
' Basic Paint Application
' Dennis C M
'
' https://coffeewithdennis.com/basic-paint-in-vb6/
'
'----------------------------------------------------------------------------------------
'
Option Explicit


Private canvas_is_dirty                     As Single
Private filename                            As String

Private prevX                               As Single
Private prevY                               As Single

Private mouseX                              As Single
Private mouseY                              As Single

Private pendown                             As Boolean


Private Sub colorkeys_Click(Index As Integer)
    With Me.colorkeys(Index)
        ' set the brush/pen color based on the selected color
        Me.canvas.ForeColor = .BackColor
        
        ' move the selection rectangle to "this" selected color/button
        Me.colorkeyborder.Move .Left - (Me.colorkeyborder.BorderWidth * 2), .Top - (Me.colorkeyborder.BorderWidth * 2)
    End With
End Sub


Private Sub Form_Load()
    '
    ' perform initializations here
    '
    mouseX = -1
    mouseY = -1
    
    Me.canvas.DrawWidth = 8
    
    setup_color_palette
    
    update_caption
End Sub


Private Sub setup_color_palette()
    Const cols_per_row                      As Integer = 8
    
    
    Dim button_width                        As Integer
    Dim button_height                       As Integer
    
    Dim y_padding                           As Integer
    Dim x_padding                           As Integer
    
    Dim row_index                           As Integer
    Dim col_index                           As Integer
    Dim color_index                         As Integer
    
    
    x_padding = 80
    y_padding = 80
    
    
    ' set the size of the button based on its container, divided by 2
    ' so we can have 2 rows of color selection
    button_height = (Me.palette_box.ScaleHeight \ 2) - (y_padding * 2)
    button_width = button_height
    
    ' define the color selection rectangle (using a shape)
    With Me.colorkeyborder
        .Width = button_width + (.BorderWidth * 4)
        .Height = button_height + (.BorderWidth * 4)
    End With
    
    '
    ' generate the color palette boxes
    '
    For row_index = 0 To 1
        For col_index = 0 To cols_per_row - 1
            color_index = (row_index * cols_per_row) + col_index
            
            If color_index > 0 Then
                '
                ' since only the 1st color button is created at design time,
                ' we create the rest dynamically (at runtime)
                '
                Load Me.colorkeys(color_index)
                Me.colorkeys(color_index).Visible = True
            End If
            
            ' define the color buttons location
            Me.colorkeys(color_index).Left = (col_index * button_width) + (x_padding * (col_index + 1))
            Me.colorkeys(color_index).Top = (row_index * button_height) + (y_padding * (row_index + 1))
            
            ' define its size
            Me.colorkeys(color_index).Width = button_width
            Me.colorkeys(color_index).Height = button_height
            
            ' and then set its color representation
            Me.colorkeys(color_index).BackColor = QBColor(color_index)
        Next
    Next
    
    Me.colorkeys(0).Value = True
End Sub


Private Sub Form_Resize()
    ' do not perform any size adjustments if the form is not visible
    If Me.WindowState = vbMinimized Then Exit Sub
    
    ' make the canvas resize based on the form/window size
    With Me.canvas
        .Left = 0
        .Top = Me.palette_box.Top + Me.palette_box.Height
        .Width = Me.ScaleWidth
        .Height = Me.ScaleHeight - .Top
    End With
End Sub


Private Sub canvas_MouseDown(Button As Integer, Shift As Integer, _
X As Single, Y As Single)
    ' signal the start of drawing mode when the button is depressed
    pendown = True
End Sub

Private Sub canvas_MouseMove(Button As Integer, Shift As Integer, _
X As Single, Y As Single)
    ' preserve the last known location as we'll use it to draw the line
    prevX = mouseX
    prevY = mouseY
    
    ' capture the current pen location
    mouseX = X
    mouseY = Y
    
    If pendown Then
        ' if drawing has started, reflect it on the canvas
        flip
    End If
End Sub

Private Sub canvas_MouseUp(Button As Integer, Shift As Integer, _
X As Single, Y As Single)
    ' signal the end of drawing then button is released
    pendown = False
    
    ' reset the pen location too
    mouseX = -1
    mouseY = -1
End Sub


Private Sub flip()
    If mouseX = -1 Or mouseY = -1 Then
        ' the pen was just placed on the canvas so we draw only a dot
        Me.canvas.PSet (mouseX, mouseY)
    Else
        ' pen is moving on the canvas, connect the previous and new points
        Me.canvas.Line (prevX, prevY)-(mouseX, mouseY)
        
        ' NOTE: if you use PSet, you'll see gaps and unless that's your intention
        ' you use a line instead
    End If
End Sub


Private Sub mnuFileExit_Click()
    Dim choice                              As VbMsgBoxResult
    
    
    If canvas_is_dirty Then
        ' if something is drawn but not yet saved, ask user
        choice = MsgBox("You haven't saved your work.  Sure you want to exit?", _
            vbQuestion + vbYesNo, "Confirm Exit")
            
        If choice = vbNo Then
            ' means cancel the exit command, allow user to save first
            Exit Sub
        End If
    End If
    
    Unload Me
End Sub

Private Sub mnuFileNew_Click()
    ' reset the filename to signify it's a new canvas
    filename = vbNullString
    
    ' clear the canvas to visually signify it as well
    Me.canvas.Picture = LoadPicture(filename)
    
    ' make the form confirm that it's a new canvas
    update_caption
End Sub


Function get_filename(ByVal mode As String) As String
    '
    ' shared function for displaying a file dialog
    ' for bot saving and loading a file
    '
    Dim flags                               As FileOpenConstants
    
Try:
    On Error GoTo Catch
    
    
    ' define appropriate flags depending on mode
    If UCase(mode) = "SAVE" Then
        flags = cdlOFNLongNames + cdlOFNOverwritePrompt
    Else
        flags = cdlOFNLongNames + cdlOFNFileMustExist
    End If
    
    
    With Me.dlgfilesystem
        ' catch the cancel button event
        .CancelError = True
        
        ' set the default parameters for the dialog box
        .DefaultExt = "bmp"
        .Filter = "Bitmap (*.BMP)|*.bmp|All Files (*.*)|*.*"
        .flags = flags
        .InitDir = App.Path
        
        ' display the correct dialog
        If UCase(mode) = "SAVE" Then
            .DialogTitle = "Save As"
            .ShowSave
        Else
            .DialogTitle = "Open File"
            .ShowOpen
        End If
        
        ' if user didn't click Cancel, get the filename selected
        filename = .filename
    End With
    GoTo Finally
    
Catch:
    ' if user clicked Cancel button, clear the filename
    filename = vbNullString
    
Finally:
    ' return the selection
    get_filename = filename
    
End Function


Private Sub SaveAs()
    ' as user for a different filename
    filename = get_filename("save")
    
    If filename > "" Then
        ' if it's anything but blank (which meant it was cancelled), save image to it
        Call Save
    End If
End Sub


Private Sub Save()
    ' capture what's on the image, since that's where the actual image is
    Set Me.canvas.Picture = Me.canvas.Image
    
    ' save this to the currently set filename
    SavePicture Me.canvas.Picture, filename
    
    ' make sure the operation is reflected on the title
    update_caption
End Sub


Private Sub mnuFileSaveAs_Click()
    ' new or wanting a different filename, ask user
    SaveAs
End Sub


Private Sub mnuFileSave_Click()
    If filename = vbNullString Then
        ' if this is a new canvas, ask for a filename
        Call SaveAs
    Else
        ' update the file content
        Call Save
    End If
End Sub


Private Sub mnuFileOpen_Click()
    Dim tempfile                            As String
    
    ' ask user which file to load
    tempfile = get_filename("open")
    
    If tempfile > "" Then
        ' if it's anything but blank, use it
        filename = tempfile
        
        ' then load it to the canvas
        Me.canvas.Picture = LoadPicture(filename)
    End If
    
    ' reflecte the filename in the title
    update_caption
End Sub


Private Sub update_caption()
    If filename > "" Then
        ' if a file is set, indicate it in the title
        Me.Caption = App.ProductName & " - " & filename
    Else
        ' if none, let user know the canvas must still be saved
        Me.Caption = App.ProductName & " - (Unsaved)"
    End If
End Sub

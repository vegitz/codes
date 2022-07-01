VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Map Generator"
   ClientHeight    =   9030
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   11340
   LinkTopic       =   "Form1"
   ScaleHeight     =   9030
   ScaleWidth      =   11340
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   " Map Dimension "
      Height          =   1095
      Left            =   240
      TabIndex        =   4
      Top             =   360
      Width           =   7455
      Begin VB.CommandButton cmdGenMap 
         Caption         =   "Generate Map"
         Height          =   495
         Left            =   3480
         TabIndex        =   7
         Top             =   360
         Width           =   3735
      End
      Begin VB.ComboBox cboColumns 
         BeginProperty Font 
            Name            =   "Consolas"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   1800
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   360
         Width           =   1095
      End
      Begin VB.ComboBox cboRows 
         BeginProperty Font 
            Name            =   "Consolas"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   360
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   360
         Width           =   1095
      End
   End
   Begin VB.PictureBox picFrame 
      BackColor       =   &H00404040&
      Height          =   3615
      Left            =   480
      ScaleHeight     =   3555
      ScaleWidth      =   7755
      TabIndex        =   0
      Top             =   1560
      Width           =   7815
      Begin VB.PictureBox picCorner 
         Appearance      =   0  'Flat
         BackColor       =   &H00808080&
         ForeColor       =   &H80000008&
         Height          =   615
         Left            =   6960
         ScaleHeight     =   585
         ScaleWidth      =   585
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   2760
         Width           =   615
      End
      Begin VB.HScrollBar hscroller 
         Height          =   495
         Left            =   3720
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   3000
         Width           =   3015
      End
      Begin VB.VScrollBar vscroller 
         Height          =   2655
         Left            =   6960
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   120
         Width           =   495
      End
      Begin VB.PictureBox picCanvas 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   2895
         Left            =   -120
         ScaleHeight     =   2895
         ScaleWidth      =   5295
         TabIndex        =   1
         Top             =   240
         Width           =   5295
         Begin VB.Label lblBinSprite 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "235"
            BeginProperty Font 
               Name            =   "Fixedsys"
               Size            =   13.5
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   495
            Index           =   0
            Left            =   240
            TabIndex        =   9
            Top             =   120
            Visible         =   0   'False
            Width           =   615
         End
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const sprite_size                   As Integer = 800


Private Sub cmdGenMap_Click()
    Dim rows                                As Integer
    Dim cols                                As Integer
    
    Dim xpos                                As Long
    Dim ypos                                As Long
    
    Dim rowindex                            As Integer
    Dim colindex                            As Integer
    
    Dim binindex                            As Integer
    
    Dim bincolors(2)                        As Integer
    Dim colorindex                          As Integer
    
    
    
    Randomize
    
    bincolors(0) = 7
    bincolors(1) = 10
    bincolors(2) = 12
    
    
    rows = CInt(Me.cboRows.Text)
    cols = CInt(Me.cboColumns.Text)
    
    
    Me.picFrame.AutoRedraw = False
    Me.picCanvas.Visible = False
    
    
    ' reset canvas
    With Me.picCanvas
        .Width = Me.picFrame.ScaleWidth / 2
        .Height = Me.picFrame.ScaleHeight / 2
    End With
    
    binindex = -1
    
    If rows > 0 Or cols > 0 Then
        ' then we just draw the rest of it
        For rowindex = 1 To rows
            ypos = (rowindex - 1) * sprite_size
            
            For colindex = 1 To cols
                xpos = (colindex - 1) * sprite_size
                
                binindex = binindex + 1
                
                On Error Resume Next
                Load Me.lblBinSprite(binindex)
                On Error GoTo 0
                
                With Me.lblBinSprite(binindex)
                    colorindex = CInt(Rnd * (UBound(bincolors)))
                    .BackColor = QBColor(bincolors(colorindex))
                    .Move xpos, ypos
                    .Caption = binindex
                    .Tag = "x=" & colindex & ",y=" & rowindex
                    .Visible = True
                End With
            Next
        Next
        
        ' adjust canvas size
        With Me.picCanvas
            .Width = cols * sprite_size
            .Height = rows * sprite_size
        End With
    End If
    
    Me.picCanvas.Visible = True
    Me.picFrame.AutoRedraw = True
    
    react_on_resize
End Sub

Private Sub Form_Load()
    Dim temp                                As Integer
    
    
    Me.cboRows.Clear
    Me.cboColumns.Clear
    
    Me.picFrame.Left = Me.Frame1.Left
    
    For temp = 2 To 32
        Me.cboRows.AddItem temp
        Me.cboColumns.AddItem temp
    Next
    
    Me.cboRows.ListIndex = 0
    Me.cboColumns.ListIndex = 0
    
    With Me.lblBinSprite(0)
        .Width = sprite_size
        .Height = sprite_size
    End With
    
    With Me.picCorner
        .Width = 400
        .Height = 400
        
        Me.vscroller.Width = .Width
        Me.hscroller.Height = .Height
    End With
End Sub

Private Sub Form_Resize()
    If Me.WindowState = 1 Then Exit Sub
    
    react_on_resize
End Sub

Private Sub react_on_resize()
    Dim visible_scrollers                   As Integer
    
    visible_scrollers = 0
    
    With Me.picFrame
        .Width = Me.ScaleWidth - (.Left * 2)
        .Height = Me.ScaleHeight - (.Top + .Left)
        
        Me.picCanvas.Move 0, 0
        
        
        Me.picCorner.Left = .ScaleWidth - Me.picCorner.Width
        Me.picCorner.Top = .ScaleHeight - Me.picCorner.Height
        
        Me.vscroller.Left = .ScaleWidth - Me.vscroller.Width
        Me.vscroller.Top = 0
        
        Me.hscroller.Left = 0
        Me.hscroller.Top = .ScaleHeight - Me.hscroller.Height
        
        
        
        If Me.picCanvas.Height > .Height Then
            With Me.vscroller
                .Min = 0
                .Max = (Me.picCanvas.Height - Me.picFrame.Height) + (Me.picCorner.Height * 2)
                .SmallChange = 0.04 * .Max
                .LargeChange = 0.2 * .Max
                .Visible = True
            End With
            
            visible_scrollers = visible_scrollers + 1
        Else
            Me.vscroller.Visible = False
        End If
        
        If Me.picCanvas.Width > .Width Then
            With Me.hscroller
                .Min = 0
                .Max = (Me.picCanvas.Width - Me.picFrame.Width) + (Me.picCorner.Width * 2)
                .SmallChange = 0.04 * .Max
                .LargeChange = 0.2 * .Max
                .Visible = True
            End With
            visible_scrollers = visible_scrollers + 2
        Else
            Me.hscroller.Visible = False
        End If
        
        Me.picCorner.Visible = visible_scrollers = 3
        
        Select Case visible_scrollers
            Case 1
                ' only vertical
                Me.vscroller.Height = .ScaleHeight
                
            Case 2
                ' only horizontal
                Me.hscroller.Width = .ScaleWidth
                
            Case 3
                ' both scrollers
                Me.vscroller.Height = .ScaleHeight - Me.picCorner.Height
                Me.hscroller.Width = .ScaleWidth - Me.picCorner.Width
                
            Case Else
                ' nothing to do
                
        End Select
    End With
End Sub

Private Sub hscroller_Change()
    Me.picCanvas.Left = -Me.hscroller.Value
End Sub

Private Sub lblBinSprite_Click(Index As Integer)
    MsgBox "You clicked on Bin #" & Index & " located at grid " & Me.lblBinSprite(Index).Tag, vbInformation, "Bin Information"
End Sub

Private Sub picCanvas_DblClick()
    ' for demo, just make same as form
    Me.picCanvas.Width = Me.Width
    Me.picCanvas.Height = Me.Height
    
    react_on_resize
End Sub

Private Sub picCanvas_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 1 Then
        If Shift = 1 Then
            Me.picCanvas.Width = 2000
        Else
            Me.picCanvas.Width = Me.Width
        End If
    ElseIf Button = 2 Then
        If Shift = 1 Then
            Me.picCanvas.Height = 2000
        Else
            Me.picCanvas.Height = Me.Height
        End If
    End If
    
    react_on_resize
End Sub


Private Sub vscroller_Change()
    Me.picCanvas.Top = -Me.vscroller.Value
End Sub

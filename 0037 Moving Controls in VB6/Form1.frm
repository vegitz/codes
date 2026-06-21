VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4785
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   9150
   LinkTopic       =   "Form1"
   ScaleHeight     =   4785
   ScaleWidth      =   9150
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox List1 
      Height          =   2700
      IntegralHeight  =   0   'False
      Left            =   120
      TabIndex        =   2
      Top             =   1920
      Width           =   3855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Move to Frame1"
      Height          =   855
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   3855
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   3975
      Left            =   4080
      TabIndex        =   0
      Top             =   720
      Width           =   4935
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Command1_Click()
    Set Me.List1.Container = Me.Frame1
    
    ' optional: move the list to center
    Me.List1.Left = (Me.Frame1.Width - Me.List1.Width) / 2
    Me.List1.Top = (Me.Frame1.Height - Me.List1.Height) / 2
End Sub



Private Sub Form_Load()
    With Me.List1
        .AddItem "John"
        .AddItem "Paul"
        .AddItem "George"
        .AddItem "Ringo"
    End With
End Sub



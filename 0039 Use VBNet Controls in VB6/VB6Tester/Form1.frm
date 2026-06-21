VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   5070
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   8070
   LinkTopic       =   "Form1"
   ScaleHeight     =   5070
   ScaleWidth      =   8070
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    
    Set Me.Picture = LoadPicture("d:\sandbox\pusa.png")
    
'    Dim nc As VBControlExtender
'
'    Set nc = Me.Controls.Add("NetBridge.PicViewer", "nc")
'    nc.object.loadimg "d:\sandbox\pusa.png"
'    nc.Visible = True
    
End Sub

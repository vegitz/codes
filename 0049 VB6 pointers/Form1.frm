VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3015
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3015
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    illustrate_the_idea
    End
End Sub

Private Sub illustrate_the_idea()
    Dim v               As String
    
    ' set value to blank string
    v = ""
    
    ' compare if it's the same as a blank string
    Debug.Print "Blank vs Blank is equal? " & (v = "")
    
    ' compare if it is the same thing
    Debug.Print "Blank string, same object? " & (StrPtr(v) = StrPtr(""))
    
    ' look at their memory addresses
    Debug.Print "Mem. Loc.", StrPtr(v), StrPtr("")
    
    
    Debug.Print vbCrLf
    
    
    
    ' set value to the null string constant
    v = vbNullString
    
    ' compare if it's the same as the null string constant
    Debug.Print "NullString vs NullString is equal? " & (v = vbNullString)
    
    ' compare if it is the same thing
    Debug.Print "Nullstring, same object? " & (StrPtr(v) = StrPtr(vbNullString))
    
    ' look at their memory addresses
    Debug.Print "Mem. Loc.", StrPtr(v), StrPtr(vbNullString)
End Sub


Private Sub common_use_case()
    Dim username            As String
    Dim msg                 As String
    
    ' Test 1. click the cancel button
    ' Test 2. click the ok button (don't enter anything)
    username = InputBox("what is your name? ")
    
    ' compare against blank string
    If username = "" Then
        msg = "no name"
    Else
        msg = "Hello '" & username & "`"
    End If
    Debug.Print "vs blank string = " & msg
    
    
    ' compare against nullstring
    If username = vbNullString Then
        msg = "no name"
    Else
        msg = "Hello '" & username & "`"
    End If
    Debug.Print "vs NullString = " & msg
    
    
    ' use the pointer to compare
    If StrPtr(username) = StrPtr(vbNullString) Then
        msg = "no name"
    Else
        msg = "Hello `" & username & "`"
    End If
    Debug.Print "using pointer = " & msg
End Sub

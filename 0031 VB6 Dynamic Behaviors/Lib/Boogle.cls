VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Boogle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Function search(ByVal term As String) As Collection
    Dim colresult                           As New Collection
    
    ' create a fake response:
    With colresult
        .Add "http://boo/?" & term
        .Add "http://gle/?query=" & term
    End With
    '
    ' in a real-world application, this would query a DB, etc.
    '
    
    Set search = colresult
End Function

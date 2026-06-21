VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CHttpRequest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Method                               As String
Public Path                                 As String
Public Protocol                             As String
Public ProtocolVersion                      As String
Public Host                                 As String
Public Meta                                 As Scripting.Dictionary
Public Params                               As Scripting.Dictionary
Public PostBody                             As Scripting.Dictionary



Private Sub Class_Initialize()
    Set Meta = New Scripting.Dictionary
    Set Params = New Scripting.Dictionary
    Set PostBody = New Scripting.Dictionary
End Sub


Public Function repr() As String
    Dim info                                As String
    Dim metaarray()                         As String
    Dim varKey                              As Variant
    Dim value                               As String
    
    On Error GoTo ErrorHandler
    
    info = ""
    info = info & ("Method: " & Me.Method & vbCrLf)
    info = info & ("Path: " & Me.Path & vbCrLf)
    
    If Params.Count > 0 Then
        ' GET method
        info = info & ("GET Params: " & vbCrLf)
        For Each varKey In Params
            value = Params.Item(varKey)
            info = info & (vbTab & Trim(varKey) & ": " & Trim(value) & vbCrLf)
        Next
    End If
    
    If PostBody.Count > 0 Then
        ' POST method
        info = info & ("POST Params: " & vbCrLf)
        For Each varKey In PostBody
            value = PostBody.Item(varKey)
            info = info & (vbTab & Trim(varKey) & ": " & Trim(value) & vbCrLf)
        Next
    End If
    
    info = info & ("Protocol: " & Me.Protocol & vbCrLf)
    info = info & ("Version: " & Me.ProtocolVersion & vbCrLf)
    info = info & ("Host: " & Me.Host & vbCrLf)
    
    info = info & ("Meta: " & vbCrLf)
    For Each varKey In Meta
        value = Meta.Item(varKey)
        info = info & (vbTab & Trim(varKey) & ": " & Trim(value) & vbCrLf)
    Next
    
    GoTo ExitRoutine
    
ErrorHandler:
    info = Err.Description
    If False Then
        Resume
    End If
    
ExitRoutine:
    repr = info
    
End Function



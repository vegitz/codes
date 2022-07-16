VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "WebBrowser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

' name          : Acme.WebBrowser
' module        : Class
'
' expose the search engine as public so the client app
' can change it at will
'
Public search_engine            As iSearchEngine


Private Sub Class_Initialize()
    '
    ' define a default search engine
    ' in case the client app did not
    ' specify something else
    '
    Set search_engine = New EchoSearchEngine
End Sub


Function search(ByVal search_text As String) As String
    '
    ' wrapper function to perform the search
    ' and then summarize the results.
    '
    Dim results                 As Collection
    Dim match                   As Variant
    Dim summary                 As String
    
    ' delegate the actual searching to the engine
    Set results = search_engine.search(search_text)
    
    ' iterate over the results to create summary
    For Each match In results
        summary = summary & match & vbCrLf
    Next
    
    ' return the summarized results
    search = summary
End Function


VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CustomSearchEngine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'
' name          : Project1.CustomSearchEngine
' module        : Class
'
' This demonstrates how to write a different implementation
' of the iSearchEngine interface so we can extend
' the capabilities of the default library
'

Implements iSearchEngine


Private Function iSearchEngine_search(ByVal text As String) As Collection
    ' this just returns a list of URLs containing the
    ' search "text" in them
    Dim matches                 As New Collection
    
    matches.Add "http://" & text & ".searches.com/"
    matches.Add "http://" & "www.pubsearch.com/?q=" & text
    matches.Add "http://" & "acme.com/" & text & "/stories/"
    matches.Add "ftp://" & "archives.net/files/" & text & ".txt"
    
    Set iSearchEngine_search = matches
End Function

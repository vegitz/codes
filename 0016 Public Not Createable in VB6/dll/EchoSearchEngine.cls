VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "EchoSearchEngine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'
' name          : Acme.EchoSearchEngine
' module        : Class
'
' This is a dummy concrete implementation of the
' iSearchEngine interface
'

Implements iSearchEngine

Private Function iSearchEngine_search(ByVal text As String) As Collection
    '
    ' this is a mock search implementation
    '
    Dim result                  As New Collection
    
    ' just add a dummy result (for testing)
    result.Add "You were searching for `" & text & "` string"
    
    ' return the dummy result
    Set iSearchEngine_search = result
End Function


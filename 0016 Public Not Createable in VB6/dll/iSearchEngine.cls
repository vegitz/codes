VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "iSearchEngine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

'
' Name      : Acme.iSearchEngine
' Module    : Class
'
' This class cannot be instantiated!
' Note the "Instancing" is set to #2 (PublicNotCreatable)
'

'
' To use this, implement this on a concrete class
' via the "Implements" keyword
'

Function search(ByVal text As String) As Collection
    '
    ' perform search of text and return
    ' a collection of results
    '
End Function



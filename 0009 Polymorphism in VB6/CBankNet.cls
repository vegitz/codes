VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBancnet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Implements iBankNetwork


Private Function iBankNetwork_Validate(ByVal account_number As String) As Boolean
    On Error GoTo ErrorHandler
    
    ' do a simple validation for demo purposes
    If Len(account_number) < 10 Then
        Err.Raise vbObjectError + 101, , "Account number is invalid"
    End If
    
    ' if all goes well, we validate the account
    iBankNetwork_Validate = True
    
    Exit Function
    
ErrorHandler:
    ' display the error
    Debug.Print Err.Description
    iBankNetwork_Validate = False
    
End Function

VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBankAccount"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'
' ===========================================================================
' naming convention used:
' ---------------------------------------------------------------------------
' scope indicator   : p=public, m=modular (not applicable to local variables)
' data type code    : str=string, int=integer, dbl=double, bln=boolean, etc...
' descriptive name  : a clue to what that variable holds
' ---------------------------------------------------------------------------
'

Option Explicit

Private mdblBalance                         As Double


Sub Withdraw(ByVal Amount As Double)
    '
    ' you can do this at least 2 ways, either require Amount to be negative
    ' and then add it to balance, effectively substracting it.
    ' ---
    ' or ensure it's positive and perform substraction, which is what
    ' we'll do on this demo.
    '
    
    Amount = Abs(Amount)        ' ensure the value is positive using Abs(olute) function
    
    If Amount > GetBalance Then
        '
        ' prevent withdrawing more than what is there
        '
        Err.Raise vbObjectError + 201, , "Amount to be withdrawn is larger than current balance"
    End If
    
    mdblBalance = mdblBalance - Amount
End Sub



Public Function GetBalance() As Double
    '
    ' we are just going to return the value of our
    ' protected (or encapsulated) variable
    '
    GetBalance = mdblBalance
End Function



Public Sub Deposit(ByVal Amount As Double)
    If Amount < 0 Then
        '
        ' prevent negative deposits
        '
        Err.Raise vbObjectError + 101, , "Negative deposits are not allowed"
    Else
        '
        ' you may require "minimum deposit" verification here
        ' but for this demo, we'll just accept any positive
        '
        mdblBalance = mdblBalance + Amount
    End If
End Sub




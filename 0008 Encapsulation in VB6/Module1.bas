Attribute VB_Name = "Module1"
Option Explicit

Sub main()
    'happy_path
    negative_tests
End Sub


Private Sub negative_tests()
    ' not recommended to auto-instantiate, but for brevity we will
    Dim cba                                 As New CBankAccount
    
    ' VB6 does not have TRY..CATCH so we'll emulate that via On Error Resume
    ' BUT don't use this to hide errors; that's lazy and bad :)
    On Error Resume Next
    cba.Deposit -45
    If Err.Number <> 0 Then
        Debug.Print Err.Description
    End If
    
    cba.Withdraw 88
    If Err.Number <> 0 Then
        Debug.Print Err.Description
    End If
    
End Sub


Private Sub happy_path()
    ' not recommended to auto-instantiate, but for brevity we will
    Dim cba                                 As New CBankAccount
    
    Debug.Print "Initial Balance: " & cba.GetBalance
    
    cba.Deposit 100
    Debug.Print "After Deposit: " & cba.GetBalance
    
    cba.Withdraw 35
    Debug.Print "After Withdrawal: " & cba.GetBalance
End Sub



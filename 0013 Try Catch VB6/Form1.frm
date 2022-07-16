VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   5280
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   7545
   LinkTopic       =   "Form1"
   ScaleHeight     =   5280
   ScaleWidth      =   7545
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Debug.Print compute_payable(246, 2)
    Debug.Print compute_payable(300, 0)
End Sub


Function compute_payable(ByVal total_bill As Single, _
ByVal head_count As Integer) As Single
    '
    ' computes how much each person has to pay given bill amount.
    ' used when eating as a group and dividing the bill.
    '
    
    ' define variable to hold computed amount
    Dim payable                     As Single
    
try:
    ' (re)direct errors to the catch label
    On Error GoTo catch
    
    ' try the code/statement that "could" fail
    payable = total_bill / head_count
    
catch:
    ' if it failed, do something here
    payable = total_bill
    
finally:
    ' success or fail, execute more codes here
    ' you can think of this as the exit routine
    compute_payable = payable
    
End Function

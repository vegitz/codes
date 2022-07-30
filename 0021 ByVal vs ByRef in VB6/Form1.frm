VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3015
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3015
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const km_travelled                      As Single = 160
Private Const liters_consumed                   As Single = 12

Private fuel_economy                            As Single

Private Sub Form_Load()
    TestFunction
    TestSubroutine
    
    TestHybrid liters_consumed      ' test expected behavior
    TestHybrid 0                    ' test for error
    End
End Sub

Private Sub TestFunction()
    fuel_economy = compute_km_per_liter_function(km_travelled, liters_consumed)
    StandardSummary "Using Function"
End Sub

Private Sub TestSubroutine()
    compute_km_per_liter_subroutine km_travelled, liters_consumed, fuel_economy
    StandardSummary "Using Subroutine"
End Sub

Private Sub TestHybrid(ByVal liters_consumed As Integer)
    Dim error_text                      As String
    
    If compute_km_per_liter_hybrid(km_travelled, liters_consumed, fuel_economy, error_text) Then
        StandardSummary "Using Hybrid"
    Else
        StandardSummary "Using Hybrid", "Unable to compute fuel efficiency: " & error_text
    End If
End Sub


Private Sub StandardSummary(ByVal Title As String, Optional ByVal custom_summary As String = "")
    Debug.Print vbCrLf & Title
    
    If Trim(custom_summary) = "" Then
        Debug.Print km_travelled & " km(s) per " & liters_consumed & " liter(s) = " _
            & fuel_economy & " km(s)/liter"
    Else
        Debug.Print custom_summary
    End If
End Sub

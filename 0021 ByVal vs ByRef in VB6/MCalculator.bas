Attribute VB_Name = "MCalculator"
Option Explicit

Function compute_km_per_liter_function(ByVal km As Single, ByVal liters As Single) As Single
    '
    ' computes fuel efficiency and returns the computed value
    '
    compute_km_per_liter_function = km / liters
End Function


Sub compute_km_per_liter_subroutine(ByVal km As Single, ByVal liters As Single, _
ByRef outvalue As Single)
    '
    ' computes fuel efficiency and assigns the computed value to "outvalue" param
    '
    outvalue = km / liters
End Sub


Function compute_km_per_liter_hybrid(ByVal km As Single, ByVal liters As Single, _
ByRef outvalue As Single, ByRef outerror As String) As Boolean
    '
    ' computes fuel efficiency and returns the computed value.
    ' returns True if no error, False otherwise.
    ' additionally, "outerror" contains the error if returning False
    '
    Dim value_was_computed              As Boolean
    
Try:
    On Error GoTo Catch
    
    
    outvalue = km / liters
    outerror = ""
    value_was_computed = True
    
    GoTo Finally
    
Catch:
    outvalue = -1
    outerror = Err.Description
    value_was_computed = False
    
Finally:
    compute_km_per_liter_hybrid = value_was_computed
    
End Function



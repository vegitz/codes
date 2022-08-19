Module Module1

    Sub Main()
        Dim greeting As New Tagalog

        Console.Write(greeting("pedro"))
        Console.ReadKey()
    End Sub

End Module

Public Class Tagalog
    Default ReadOnly Property greet(ByVal who As String)
        Get
            Return "Kamusta, " & who
        End Get
    End Property
End Class


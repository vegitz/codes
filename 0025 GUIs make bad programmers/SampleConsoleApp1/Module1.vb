Module Module1
    Private connstr As String = "dsn=secretdb;uid=secretuser;pwd=secretpass"
    Private engine As SearchEngine

    Sub Main()
        Dim term As String = Join(My.Application.CommandLineArgs.ToArray(), " ")

        engine = New SearchEngine(connstr)
        Dim matches As List(Of String) = engine.search(term)
    End Sub

End Module


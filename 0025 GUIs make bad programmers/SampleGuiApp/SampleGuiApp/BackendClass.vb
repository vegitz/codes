
Public Class Backend
    Private connection_string As String

    Sub New()
        connection_string = ""
    End Sub

    Sub New(ByVal connection_string As String)
        Me.connection_string = connection_string
    End Sub

    Function connect(ByRef out_error As String) As Boolean
        Debug.Print($"connecting to {connection_string}...")
        out_error = ""
        Return True
    End Function

    Function execute_qry(ByVal qry_statement As String, Optional ByVal qry_values As List(Of String) = Nothing) As List(Of String)
        If Not qry_values Is Nothing Then
            For Each value As String In qry_values
                qry_statement = qry_statement.Replace("?", String.Format($"'{value}'"))
            Next
        End If

        Debug.Print($"executing {qry_statement}...")
        Return New List(Of String)
    End Function

    Sub close()
        Debug.Print($"Connection closed: {connection_string}")
    End Sub
End Class


Public Class SearchEngine
    Private conn As Backend
    Private qrystring As String = "select * From secret_table where name = ?"

    Sub New(ByVal connection_string As String)
        conn = New Backend(connection_string)
    End Sub

    Function search(ByVal searchstring As String) As List(Of String)
        Dim errorcontext As String = ""

        If conn.connect(errorcontext) Then
            Return conn.execute_qry(qrystring, New List(Of String) From {searchstring})
        End If
        Return New List(Of String)
    End Function

    Protected Overrides Sub finalize()
        If Not conn Is Nothing Then
            conn.close()
        End If
    End Sub
End Class



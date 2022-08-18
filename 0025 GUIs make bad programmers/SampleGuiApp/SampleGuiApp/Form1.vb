
Public Class Form1
    Private Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Dim connstr As String = "dsn=secretdb;uid=secretuser;pwd=secretpass"
        Dim conn As New Backend(connstr)
        Dim errorcontext As String = ""
        Dim qrystring As String = "select * From secret_table where name = ?"

        If conn.connect(errorcontext) Then
            conn.execute_qry(qrystring, New List(Of String) From {Me.txtItem.Text})
        End If

        conn.close()
    End Sub

End Class







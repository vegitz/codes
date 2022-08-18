
Public Class Form2
    Private connstr As String = "dsn=secretdb;uid=secretuser;pwd=secretpass"
    Private engine As SearchEngine

    Private Sub Form2_Load(sender As Object, e As EventArgs) Handles Me.Load
        engine = New SearchEngine(connstr)
    End Sub

    Private Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Dim matches As List(Of String) = engine.search(Me.txtItem.Text)
    End Sub
End Class



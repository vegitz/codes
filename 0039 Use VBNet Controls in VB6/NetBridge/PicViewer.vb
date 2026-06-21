Public Class PicViewer

    Public Sub LoadImg(ByVal path As String)
        Me.PictureBox1.Image = Drawing.Image.FromFile(path)
    End Sub
End Class

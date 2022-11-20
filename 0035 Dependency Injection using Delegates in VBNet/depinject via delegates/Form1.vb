
Public Delegate Sub validation_delegate(ByVal raw_password As String)

Public Class Form1
    Private Sub password_cannot_be_blank(ByVal password As String)
        If Trim(password) = vbNullString Then
            Throw New Exception("Password cannot be blank")
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Test2()
    End Sub

    Private Sub Test1()
        Try
            Dim strPassword As String = vbNullString
            Dim validate_password As validation_delegate

            validate_password = AddressOf password_cannot_be_blank
            validate_password(strPassword)

            MessageBox.Show("Password is valid, logging in...")

        Catch ex As Exception
            MessageBox.Show(ex.Message.ToString, "Error validating password")

        End Try
    End Sub


    Private Sub Test2()
        Dim strPassword As String = vbNullString
        Dim password_validators As New List(Of validation_delegate)
        Dim security_suite As New PasswordValidationSuite

        With password_validators
            ' add internally defined validator
            .Add(AddressOf password_cannot_be_blank)

            ' now add those from an external source, like class
            .Add(AddressOf security_suite.MustHaveNumber)
            .Add(AddressOf security_suite.MustHaveSpecialCharacter)
        End With

        strPassword = "donotus3thisp@ssword"


        Dim validation_errors As New List(Of String)

        For Each validate_password As validation_delegate In password_validators
            Try
                ' validate_password(strPassword)
                PerformValidation(validate_password, strPassword)

            Catch ex As Exception
                validation_errors.Add(ex.Message.ToString)

            End Try
        Next

        If validation_errors.Count = 0 Then
            MessageBox.Show("Password is valid, logging in ...")
        Else
            Dim error_summary As String = Join(validation_errors.ToArray, vbNewLine)
            MessageBox.Show(error_summary, "One or more validation error was caught")
        End If

    End Sub
    
    Private Sub PerformValidation(ByVal validate As validation_delegate, ByVal password As String)
        '
        ' you can create this wrapper so you can use it as a single-call or inside loop
        '
        Debug.Print("Validating using {0}", validate.Method.Name)
        validate(password)
    End Sub
End Class


Public Class PasswordValidationSuite
    Public Sub MustHaveNumber(ByVal password As String)
        Dim blnContainsNumber As Boolean = False

        For Each ch As Char In password
            If Char.IsDigit(ch) Then
                blnContainsNumber = True
                Exit For
            End If
        Next

        If Not blnContainsNumber Then
            Throw New Exception("Password must have at least one number")
        End If
    End Sub

    Public Sub MustHaveSpecialCharacter(ByVal password As String)
        Const cstrSpecialChars As String = "~`!@#$%^&*()_-+={[}]|\:;""'<,>.?/"

        Dim blnContainsSpecialCharacter As Boolean = False

        For Each ch As Char In password
            If InStr(cstrSpecialChars, ch, CompareMethod.Text) > 0 Then
                blnContainsSpecialCharacter = True
                Exit For
            End If
        Next

        If Not blnContainsSpecialCharacter Then
            Throw New Exception( _
                String.Format("Password must have at least one special character: {0}", cstrSpecialChars))
        End If
    End Sub
End Class



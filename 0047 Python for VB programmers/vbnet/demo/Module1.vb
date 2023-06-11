Module Module1
    Function html_tag(ByVal tag As String, ByVal name As String) As String
        Return String.Format("<{0}>{1}</{0}>", tag, name)
    End Function

    Sub Main()
        Dim new_hire As New Employee("T-800", "s")
        Dim senior_hire As New Employee("T-X", "m")
        new_hire.generate_payslip()
        senior_hire.generate_payslip()
        Debug.Print("Employee Base Pay: {0}", Employee.base_pay)
    End Sub
End Module

Class Employee
    Public Shared base_pay As Integer = 10000       ' "class" variable

    ' note that we need to declare even the instance variables here
    Private id As String = ""
    Private civil_status As String = ""

    Sub New(ByVal emp_id As String, ByVal civil_status As String)
        ' this.emp_id & this.civil_status are "instance" variables
        Me.id = emp_id
        Me.civil_status = civil_status
    End Sub
        
    Sub generate_payslip()
        ' tax & net_pay are "local" variables
        Dim tax As Single
        Dim net_pay As Single

        If Me.civil_status = "m" Then
            tax = Me.base_pay * 0.25
        Else
            tax = Me.base_pay * 0.32
        End If

        net_pay = Me.base_pay - tax
        Debug.Print("Payslip for {0}: {1} - {2} = {3}", Me.id, Me.base_pay, tax, net_pay)
    End Sub
End Class



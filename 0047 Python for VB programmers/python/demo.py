
# def html_tag(tag:str, name:str) -> str:
#     return "<{0}>{1}</{0}>".format(tag, name)


# print(html_tag("h2", "CoffeeWithDennis"))


class Employee:
    base_pay = 10_000       # 'class' variable

    def __init__(self, emp_id:str, civil_status:str):
        # self.emp_id & self.civil_status are 'instance' variables
        self.id = emp_id
        self.civil_status = civil_status

    def generate_payslip(self):
        # tax & net_pay are 'local' variables
        if self.civil_status == 'm':
            tax = self.base_pay * 0.25
        else:
            tax = self.base_pay * 0.32
        
        net_pay = self.base_pay - tax
        print("Payslip for {0}: {1} - {2} = {3}".format(self.id, self.base_pay, tax, net_pay))


new_hire = Employee('T-800', 's')
senior_hire = Employee('T-X', 'm')
new_hire.generate_payslip()
senior_hire.generate_payslip()

# class-level means you can access it from the class itself
print("Employee Base Pay: {0}".format(Employee.base_pay))
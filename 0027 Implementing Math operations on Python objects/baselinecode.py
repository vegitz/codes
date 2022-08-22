class Money:
    def __init__(self, value):
        self.value = float(value)

class Salary(Money):
    """ This comes from the Local Finance DB """
    pass

class Tax(Money):
    """ This comes from the BIR web service """
    pass

class Bonus(Money):
    """ This comes from Global Finance DB """
    pass


# say we have these values
gross_salary = Salary(10000)
tax = Tax(0.3)
bonus = Bonus(300)

# would be nice to do this
salary_tax = gross_salary * tax
bonus_tax = bonus * tax

net_bonus = bonus - bonus_tax
net_salary = (gross_salary - salary_tax) + net_bonus

# but it won't work as it is


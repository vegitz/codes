class Money:
    def __init__(self, value):
        self.value = float(value)

    def __repr__(self):
        return str(self.value)

    def __mul__(self, other):
        if isinstance(other, Money):
            return Money(self.value * other.value)
        else:
            raise Exception("Cannot multiply non-Money type")

    def __add__(self, other):
        if isinstance(other, Money):
            return Money(self.value + other.value)
        else:
            raise Exception("Cannot add non-Money type")

    def __sub__(self, other):
        if isinstance(other, Money):
            return Money(self.value - other.value)
        else:
            raise Exception("Cannot subtract non-Money type")


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

# now it would
print(f"Gross Salary = {str(gross_salary).rjust(10)}")
print(f"- Salary Tax = {str(salary_tax).rjust(10)}")
print(f"+ Bonus      = {str(bonus).rjust(10)}")
print(f"- Bonus Tax  = {str(bonus_tax).rjust(10)}")
print("----------------------------")
print(f"Net Bonus    = {str(net_bonus).rjust(10)}")
print(f"Net Salary   = {str(net_salary).rjust(10)}")


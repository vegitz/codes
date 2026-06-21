

# def make_css(**kwargs):
#     css = []
#     for key, value in kwargs.items():
#         css.append(f"{key}={value}")

#     return "&".join(css)

# print(make_css(style='italic', color='white', bold=True))






# def make_proper(*args):
#     for name in args:
#         print(str(name).title())

# make_proper('john lennon', 'paul mc cartney', 'george harisson', 'ringo star')



# def my_super_function(*args, **kwargs):
#     print(f"We received {len(args)} arguments:")
#     for a in args:
#         print(f"\t{a}")


# my_super_function('cat', 123, 'dog')






def compute_net_salary(gross_salary, deductions):
    return gross_salary - deductions


# case_a = compute_net_salary(35000, 2000)
# print("Net Salary A: ", case_a)

# case_b = compute_net_salary(2000, 35000)
# print("Net Salary B: ", case_b)


# case_c = compute_net_salary(35000)




def enroll_employee(name, status='single', country='Philippines'):
    print(f"Enrolling {name} as {status} and from {country}")

# # providing just the positional argument
# enroll_employee('juan')

# # passing a different status
# enroll_employee('jose', status='married')

# # passing a different country
# enroll_employee('Kenshin', country='Japan')


def sample(a, b, *, delimiter='+'):
    print(f"{a=}")
    print(f"{a}{delimiter}{b}")

sample(1,2)
sample(1,2,delimiter="~")









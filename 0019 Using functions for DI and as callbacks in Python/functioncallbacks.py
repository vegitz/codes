"""
Demo for illustrating function as object in Python

Referenced in this blog:
https://coffeewithdennis.com/

"""

__author__ = 'Dennis C. Meneses'
__date__ = '23-Jul-2022'
__py_version__ = '3.7.4'



# using function (transformer) in dependency injection scenario
def transform(text, transformer):
    """ applies the transformer function to text and returns the result """
    return transformer(text)

print(transform('fried chicken', str.upper))
print(transform('fried chicken', len))



# simple example
import time

def register_employee(empid, post_reg_function):
    """ simulate a long running process then call the function argument once done """
    # actual code that creates employee records in database
    # maybe calling web services too, etc.
    print(f"Registering {empid} to the employee database...")
    time.sleep(3)

    # once done, pass the next execution to the function
    post_reg_function(empid)


def enroll_id(empid):
    """ enrolls the employee id to time-in/out kiosk """
    print(f"Enrolling {empid} to kiosk...")


# here, we're passing the 'enroll_id' function (not invoking it)
register_employee("ACME-12345", enroll_id)





# # advanced example
import time

def register_employee(empid, civil_status, post_reg_functions):
    """ simulate a long running process then call the function argument once done """
    # actual code that creates employee records in database
    # maybe calling web services too, etc.
    print(f"Registering {empid} to the employee database...")
    time.sleep(3)

    return post_reg_functions[civil_status.lower()](empid)


def enroll_single(empid):
    """ enrolls the employee id to time-in/out kiosk """
    print(f"Enrolling {empid} as Single...")

def enroll_married(empid):
    """ enrolls the employee id to time-in/out kiosk """
    print(f"Enrolling {empid} as Married...")


civil_registration = {
    'single': enroll_single,
    'married': enroll_married,
}

register_employee("ACME-12345", 'single', civil_registration)
register_employee("ACME-12345", 'married', civil_registration)





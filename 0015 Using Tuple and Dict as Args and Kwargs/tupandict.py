"""
a demo on how to pass the tuple and dictionary
as args and kwargs respectively
"""

__author__ = 'Dennis C. Meneses'
__date__ = '16-Jul-2022'


def create_account(name, initial_deposit, type='savings', with_passbook=False):
    """ mock function to create a bank account """

    print(f"Creating a new {type.title()} account for {name.title()}")
    print(f"\tInitial Deposit = {initial_deposit}")
    
    if with_passbook:
        print(f"\tThis will have a passbook")
    else:
        print(f"\tThis will not have a passbook")



# define client info as tuple (list would also work)
client_info = ('John Doe', 2000)

# set the optional params as dictionary
acct_options = {
    'type': 'checking',
    'with_passbook': True
}

# the single and double asterisk "expands" the values
# to match the function parameters
create_account(*client_info, **acct_options)


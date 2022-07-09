"""
This module is for generating a random string of certain length.

It has a lot of use case in various domains and some of those
use cases are for generating:
> temporary password
> transaction id
> voucher number
> claim stub
> URL-shortening tag
> others...

This is also mentioned in one of the blogs below from the same author (see below __author__)
https://coffeewithdennis.com/blog/

GitHub repository:
https://github.com/vegitz/codes

"""

__author__ = "Dennis C Meneses"

import string
import random


def generate_random_string(length=6):
    """ 
    generates random characters of certain length.

    it uses the 'string' module for the set of characters to use
    it uses the 'random' module to randomly select a character

    to know about the module it's in, type this on the console:
    > python -i main.py

    and enter this:
    >>> print(__doc__)

    """

    # define the set of characters that we'll use as source.
    charset = string.ascii_letters + string.digits + string.punctuation
    # you can use the 'printable' property if you want
    # the extra charactes it provides

    # initialize the list where we'll store the random characters in.
    # we'll be using a list to collect the characters and join them later
    # you can also use the '+' or '+=' operators for this purpose.
    pwd = []

    # collect random characters 'length' number of times
    for i in range(length):
        # store the random character in our list
        pwd.append(random.choice(charset))

    # combine the characters and return it
    return ''.join(pwd)



def _demo():
    """ a function to test the 'generate_random_string' function """
    
    # define random length for testing
    test_lengths = [4, 6 ,10, 16]

    for pl in test_lengths:
        # generate random strings based on password length 'pl'
        pwd = generate_random_string(pl)
        # output the result
        print(f"Length of {pl} = {pwd}")


if __name__ == '__main__':
    # only execute the sample code if run by itself (and not imported from another module)
    _demo()


#
# for an article in coffeewithdennis.com
# by dennis c. meneses
#

from dataclasses import dataclass

"""
CREATE TABLE EMPLOYEE (
    emp_id      varchar(8),
    first_name  varchar(24),
    last_name   varchar(24),
)
"""

@dataclass
class Employee:
    """ This is the TABLE DEFINITION equivalent of Employee """
    emp_id: str
    first_name: str
    last_name: str


"""
CREATE TABLE ATTENDACE (
    emp_id      varchar(8),
    time_in     varchar(32),
    time_out    varchar(32) NULLABLE,
)
"""

@dataclass
class Attendance:
    """ This is the TABLE DEFINITION equivalent of Attendance """
    emp_id: str
    time_in: str
    time_out: str = None

employees = []          # this is the equivalent of the Employee table rows
attendances = []        # this is the equivalent of the Attendance table rows

# INSERT INTO Employee (emp_id, first_name, last_name) VALUES ('EM-100', 'John', 'Doe')
employees.append(Employee(emp_id='EM-100', first_name='John', last_name='Doe'))

# INSERT INTO Attendance (emp_id, time_in) VALUES ('EM-100', '2023-06-11 06:45:56')
attendances.append(Attendance(emp_id='EM-100', time_in='2023-06-11 06:45:56'))


# SELECT * FROM Attendance WHERE emp_id = 'EM-100'
matches = [emp for emp in employees if emp.emp_id == 'EM-100']

# UPDATE Attendate SET time_out = '2023-06-11 05:32:54' WHERE emp_id = 'EM-1000'
matches = [att for att in attendances if att.emp_id == 'EM-100']
if matches:
    matches[0].time_out = '2023-06-11 05:32:54'



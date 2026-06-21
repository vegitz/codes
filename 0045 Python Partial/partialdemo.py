import tkinter as tk
from functools import partial


def simple():
    def multiply(n1, n2):
        return n1 * n2


    # print(multiply(2, 3))

    # for i in range(3):
    #     print("2 x ", i, " = ", multiply(2, i))


    # create a new function using partial
    doubled = partial(multiply, 2)  

    # use the new function
    for i in range(3):
        print("2 x ", i, " = ", doubled(i))





def tkdemo():

    # def ok_clicked():
    #     print("ok button was clicked!")

    # def cancel_clicked():
    #     print("cancel button was clicked!")


    def button_clicked(button_id):
        print(f"{button_id} was clicked!")


    root = tk.Tk()
    root.title('Partial Demo using Tk')
    root.geometry('400x300+200+200')

    btnok = tk.Button(master=root, text='OK', command=partial(button_clicked, "ok"))
    btnok.place(x=24, y=24, width=100)

    btncancel = tk.Button(master=root, text='Cancel', command=partial(button_clicked,"cancel"))
    btncancel.place(x=128, y=24)

    root.mainloop()


tkdemo()

class Tagalog:
    def __call__(self, who):
        return "Kamusta, " + who

greeting = Tagalog()
print(greeting("pedro"))


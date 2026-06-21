from dataclasses import dataclass

@dataclass
class Field:
    name: str
    value: any

class From:
    def __init__(self, table:list):
        self.table:list = table
        self.index:int = 0
        self.clause:dict = None

    def __iter__(self):
        for row in self.table:
            if self.clause:
                temp = row.copy()
                row = {}
                for key, value in self.clause.items():
                    if temp[key] == value:
                        row[key] = value

            if row:
                yield row

    def where(self, **clause):
        self.clause = clause
        return self



orders = [
    {'food':'pizza', 'price':99},
    {'food':'burger', 'price':120},
    {'food':'fries', 'price':65},
]

rows = From(orders).where(price=120)
for row in rows:
    print(row)


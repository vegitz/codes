from flask import Flask
from markupsafe import escape

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


class ItemEndPoint:
    def __init__(self):
        self.itemlist = []

    def __call__(self, *args, **kwargs):
        print(args)
        print(kwargs)

        if len(args) == 0:
            fncname = 'items'
        else:
            fncname = args[0]
            args = args[1:]

        print(f"Locating {fncname}...")
        fnc = getattr(self, fncname, None)
        if fnc:
            return fnc(*args, **kwargs)
        else:
            return "Invalid API"


    def items(self):
        if len(self.itemlist) == 0:
            allitems = "No items yet.  You may add using /add/<item_name>"
        else:
            allitems = "<br/>".join(self.itemlist)

        return allitems

    def safe_add(self, item):
        self.itemlist.append(escape(item))
        return self.items()

    def raw_add(self, item):
        self.itemlist.append(item)
        return self.items()


itemrouter = ItemEndPoint()
app.add_url_rule('/items/<fnc>/<args>/', 'items', view_func=itemrouter)

import xmltodict
import json

# note: 
#----------
# xmltodict REQUIRES a single root node in a dictionary
# so you need to create an 'extra' root node
#

data = {
    "mocha": {
        "price": 80,
        "ingredients": {
            "ingredient": ["water", "coffee", "sweetener", "chocolate"]
        }
    }
}

class BasicEngine(object):
    def render(self, data, format):
        if format == 'xml':
            return xmltodict.unparse(data)
        elif format == 'json':
            return json.dumps(data)
        else:
            return f"No renderer for {format}"


class AdvancedEngine(object):
    def __init__(self):
        self.renderers = {
            'xml': xmltodict.unparse,
            'json': json.dumps,
        }

    def render(self, data, format):
        renderer = self.renderers.get(format, None)
        if renderer:
            return renderer(data)
        return f"No renderer for {format}"


print(BasicEngine().render(data, 'xml'))
print(AdvancedEngine().render(data, 'json'))


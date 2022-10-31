import xmltodict
import json

class CoffeeDrink(object):
    def __init__(self, name, ingredients = []):
        self.name = name
        self.ingredients = ingredients

drink = CoffeeDrink("mocha", ["water", "coffee", "sweetener", "chocolate"])

# in order to render complex or user-defined objects,
# then engine would need to know things about it.
# You cannot use the __dict__ for xmltodict
# since a single root node is required.
# plus, the format generated would be limited
# to what the engine supports

# print(json.dumps(drink.__dict__))               # would succeed
# print(xmltodict.unparse(drink.__dict__))        # would fail


# a better way in this case is make the component serialize itself

class CoffeeDrink(object):
    def __init__(self, name, ingredients = []):
        self.name = name
        self.ingredients = ingredients
    
    @property
    def snapshot(self):
        return {
            self.__class__.__name__ : {
                "name": self.name,
                "ingredients": {
                    "ingredient": self.ingredients
                }
            }
        }

    def render(self, format='json'):
        if format == 'xml':
            return xmltodict.unparse(self.snapshot, pretty=True)
        elif format == 'json':
            return json.dumps(self.snapshot, indent=4)
        raise NotImplementedError(f'{format.upper()} not supported')

class Engine(object):
    def render(self, obj, format):
        try:
            return obj.render(format)
        except Exception as e:
            return str(e)

drink = CoffeeDrink("mocha", ["water", "coffee", "sweetener", "chocolate"])

ngin = Engine()

print("\nrendering XML version")
print(ngin.render(drink, "xml"))

print("\nrendering JSON version")
print(ngin.render(drink, "json"))

print("\nrendering CSV version")
print(ngin.render(drink, "csv"))


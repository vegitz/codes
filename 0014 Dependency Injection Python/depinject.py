"""
This is a dependency injection demo code for Python 3.
"""

__author__ = 'Dennis C Meneses'
__date__ = '16-Jul-2022'


class Browser:
    """ A generic web browser """

    def __init__(self, search_engine):
        """ require a search engine upon instantiation """
        self.searchengine = search_engine

    def search(self, search_text):
        """ delegate the search to the engine """
        return self.searchengine.search(search_text)


class GooberEngine:
    """ A super fast search engine """

    def search(self, search_text):
        print(f"({self.__class__.__name__}) is searching for {search_text} ...")
        return []


class AstalaVistaEngine:
    """ An old search engine """

    def search(self, search_text):
        print(f"({self.__class__.__name__}) is searching for {search_text} ...")
        return []


Browser(GooberEngine()).search('dog')
Browser(AstalaVistaEngine()).search('cat')



# here's how you can make the selection dynamic:
# create a dictionary of engines
# that could come from a JSON file for example:
search_engines = {
    'goober': GooberEngine(),
    't800': AstalaVistaEngine()
}

print("Which Search Engine do you want to use?")
print("-" * 40)
for name in search_engines:
    print(f"\t{name}")
print("\n")
engine_name = input("Enter the name: ")

try:
    engine = search_engines[engine_name]
except Exception as e:
    print(f"Engine {engine_name} is not supported.")
else:
    print(f"Search Engine is now set to {type(engine).__name__}")


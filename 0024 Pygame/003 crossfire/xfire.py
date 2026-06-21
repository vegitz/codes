from core.gamengine import GameEngine
from games.crossfire.gameplay import GamePlay as xfire_gameplay
from games.crossfire import settings as gamesettings


def prepgame():
    return xfire_gameplay(gamesettings.TITLE, clr=gamesettings.BGCOLOR)


if __name__ == '__main__':
    g = GameEngine()
    g.load(prepgame())
    g.run()

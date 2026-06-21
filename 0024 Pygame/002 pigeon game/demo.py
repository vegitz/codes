import pygame as pg
from components import settings
from components.game import Game
from gamestates.gameplaystate import GamePlayState
from gamestates.pausedstate import PausedState


if __name__ == '__main__':
    screensize=(settings.SCREENWIDTH, settings.SCREENHEIGHT)
    game = Game('Pigeon Flight', screensize=screensize)
    
    game.states.append(GamePlayState('gameplay state', screensize, game))
    game.states.append(PausedState('paused state', screensize, game))
    game.run()

    pg.quit()

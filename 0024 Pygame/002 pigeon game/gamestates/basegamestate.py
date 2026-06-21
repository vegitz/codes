import pygame as pg
from components.game import Game

class GameState(object):
    def __init__(self, id, screensize, gameinstance:Game):
        self.id = id
        self.image = pg.Surface(screensize)
        self.rect = self.image.get_rect()
        self.game = gameinstance
        
        
    def update(self, keypressed, events, elapsed=1):
        pass

    def render(self):
        pass

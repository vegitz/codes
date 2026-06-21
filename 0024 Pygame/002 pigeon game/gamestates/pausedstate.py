import pygame as pg
from components.game import Game
from gamestates.basegamestate import GameState
from components.settings import getfont


class PausedState(GameState):
    def __init__(self, id, screensize, gameinstance: Game):
        super().__init__(id, screensize, gameinstance)
        self.font = getfont('fixedsys', 24)
        self.createpausedscreen()

    def createpausedscreen(self):
        timage, trect = self.font.render('Press SPACE to continue...', fgcolor=pg.Color('white'))
        trect.center = self.rect.center
        self.image.blit(timage, trect)

    def update(self, keypressed, events, elapsed=1):
        if keypressed['space']:
            print(f"closing {self.id} state")
            self.game.states.pop()


    def draw(self, surface:pg.Surface):
        surface.blit(self.image, self.rect)


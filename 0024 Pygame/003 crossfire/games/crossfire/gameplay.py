import pygame as pg
from core.gamestate import GameState

from .objects.players import Player


class GamePlay(GameState):
    def __init__(self, id, clr=...):
        super().__init__(id, clr)

        self.players = pg.sprite.Group()
        self.enemies = pg.sprite.Group()

        p1 = Player('Player-1')
        p1.rect.center = self.rect.center
        self.players.add(p1)


    def processevent(self, event):
        for p in self.players.sprites():
            p.processevent(event)


    def update(self, elapsed=1):
        self.image.fill(self.color)
        
        for p in self.players.sprites():
            p.update(elapsed=elapsed)

        for p in self.players.sprites():
            self.image.blit(p.image, p.rect)


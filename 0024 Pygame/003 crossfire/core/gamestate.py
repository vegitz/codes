import pygame as pg


class GameState:
    def __init__(self, id, clr=(255,0,0)):
        self.id = id
        current_screen = pg.display.get_surface()
        # inherit the current display size
        size = (current_screen.get_width(), current_screen.get_height())

        self.size = size
        self.color = pg.Color(clr)
        self.image = pg.Surface(self.size).convert()
        self.image.fill(self.color)
        self.rect = self.image.get_rect()
        self.is_dirty = False

    def processevent(self, event):
        pass


    def update(self, elapsed=1):
        pass


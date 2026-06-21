import pygame as pg
from components import settings

vec = pg.math.Vector2


class SpaceItem(pg.sprite.Sprite):
    def __init__(self, id, size=(32,32), img=None, *groups):
        super().__init__(*groups)
        self.id = id

        if img:
            self.image = img
            self.image = pg.transform.scale(self.image, size)
        else:
            self.image = pg.Surface(size)
        
        self.rect = self.image.get_rect()
        self.speed = 2
        self.acceleration = 0


    def update(self, *args, **kwargs):
        self.acceleration += 0.001
        self.speed += self.acceleration
        self.rect.y += self.speed


    def draw(self, surface:pg.Surface):
        surface.blit(self.image, self.rect)


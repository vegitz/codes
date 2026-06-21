import pygame as pg

vec = pg.math.Vector2


class Player(pg.sprite.Sprite):
    def __init__(self, id, size=(48,48), *groups):
        super().__init__(*groups)
        self.id = id
        self.image = pg.image.load('./images/pigeon-cartoon.png').convert_alpha()
        self.image = pg.transform.scale(self.image, size)
        
        self.rect = self.image.get_rect()
        print(f"{self.id} at {self.rect}")

        self.speed = 12
        self.velocity = vec(0, 0)


    def update(self, keypressed={}, elapsed=1):
        xspeed = 0
        yspeed = 0

        # horizontal movement
        if keypressed['left']:
            xspeed = -1 * self.speed
        elif keypressed['right']:
            xspeed = self.speed

        # vertical movement
        if keypressed['up']:
            yspeed = -1 * self.speed
        elif keypressed['down']:
            yspeed = self.speed

        self.velocity.x = xspeed
        self.velocity.y = yspeed

        self.rect.x += self.velocity.x
        self.rect.y += self.velocity.y

    def draw(self, surface:pg.Surface):
        surface.blit(self.image, self.rect)


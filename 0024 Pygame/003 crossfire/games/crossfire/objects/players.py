import pygame as pg
from games.crossfire import settings as gamesettings

vec = pg.math.Vector2

fireevent = pg.USEREVENT + gamesettings.EVENT_BULLET_FIRED


class Projectile(object):
    def __init__(self, pos, vel):
        self.pos = pos
        self.vel = vel

    def update(self, elapsed=1):
        self.pos[0] += self.vel.x
        self.pos[1] += self.vel.y


def fire_weapon(weapon, origin, velocity):
    evt = pg.event.Event(fireevent)
    pg.time.set_timer(evt, 500)
    return Projectile(pos=origin, vel=velocity)


class Player(pg.sprite.Sprite):
    def __init__(self, name, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.name = name
        self.image = pg.image.load(gamesettings.PLAYER1_IMAGE).convert()
        ckey = self.image.get_at((0,0))
        self.image.set_colorkey(ckey)

        self.rect = self.image.get_rect()
        self.speed = 8
        self.velocity = vec(0, 0)

        self.projectiles = []


    def _detect_movement_keys(self):
        self.velocity = vec(0, 0)
        keyspressed = pg.key.get_pressed()

        if keyspressed[pg.K_UP]:
            self.velocity.y -= self.speed
        
        if keyspressed[pg.K_LEFT]:
            self.velocity.x -= self.speed

        if keyspressed[pg.K_DOWN]:
            self.velocity.y += self.speed

        if keyspressed[pg.K_RIGHT]:
            self.velocity.x += self.speed

        self.rect.x += self.velocity.x
        self.rect.y += self.velocity.y


    def _detect_firing_keys(self, event):
        p = None

        if event.type == pg.KEYDOWN:
            if event.key == pg.K_i:
                # fire up
                p = fire_weapon(vec(0, -1))

            if event.key == pg.K_j:
                # fire left
                p = fire_weapon(vec(-1, 0))

            if event.key == pg.K_k:
                # fire down
                p = fire_weapon(vec(0, 1))

            if event.key == pg.K_l:
                # fire right
                p = fire_weapon(vec(1, 0))

    def processevent(self, event):
        self._detect_firing_keys(event)


    def update(self, elapsed=1):
        self._detect_movement_keys()



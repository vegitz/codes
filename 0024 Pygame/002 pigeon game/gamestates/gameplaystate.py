import pygame as pg
from components.game import Game
from gamestates.basegamestate import GameState
from components.player import Player
from components.spaceitem import SpaceItem
from random import randint, shuffle
from components import settings
from random import randint


def itemspawner(howmanyeach=10):
    CHERRYIMAGE = pg.image.load(settings.getimagefile('cherry.png')).convert_alpha()
    STRAWBERRYIMAGE = pg.image.load(settings.getimagefile('strawberry.png')).convert_alpha()
    VITAMINSIMAGE = pg.image.load(settings.getimagefile('vitamins-bottle.png')).convert_alpha()

    HAWKIMAGE = pg.image.load(settings.getimagefile('hawk.png')).convert_alpha()

    items = []
    cherries = [SpaceItem(i, img=CHERRYIMAGE) for i in range(howmanyeach)]
    strawberries = [SpaceItem(i, img=STRAWBERRYIMAGE) for i in range(howmanyeach)]
    vitamins = [SpaceItem(i, img=VITAMINSIMAGE) for i in range(howmanyeach)]

    items.extend(cherries)
    items.extend(strawberries)
    items.extend(vitamins)

    shuffle(items)
    for item in items:
        yield item



class GamePlayState(GameState):
    def __init__(self, id, screensize, gameinstance:Game):
        super().__init__(id, screensize, gameinstance)
        
        self.players = pg.sprite.Group()
        self.items = pg.sprite.Group()
        self.enemies = pg.sprite.Group()

        p1 = Player('pjon-1')
        p1.rect.bottom = self.rect.bottom
        p1.rect.centerx = self.rect.centerx

        self.players.add(p1)
        self.spawner = itemspawner()
        self.fixedfont = settings.getfont('fixedsys', 16, is_bold=True)
        self.statsribbon = pg.Surface((settings.SCREENWIDTH, 32), pg.SRCALPHA)

        self.spawnevent = pg.USEREVENT + 1
        self.game.subscribe_to_event(self.id, self.spawnevent, self.eventhandler, every=250)
        self.elapsed = 0

    def render_stats(self):
        self.statsribbon.fill((30,30,30))
        itemstat = f"Item(s): {len(self.items)}"
        timage, trect = self.fixedfont.render(itemstat, fgcolor=pg.Color('white'))
        self.statsribbon.blit(timage, (8,8))

    def eventhandler(self, eventid, *args, **kwargs):
        self.elapsed += 1
        # print(f"{self.elapsed} Event = {eventid}")

        if eventid == self.spawnevent:
            # spawn every N seconds
            if self.elapsed % 8 == 0:
                item = next(self.spawner)
                item.rect.x = randint(10, settings.SCREENWIDTH - item.rect.width)
                print(f"Spawned: {item}")
                self.items.add(item)


    def update(self, keypressed, events, elapsed=1):
        self.players.update(keypressed, elapsed=elapsed)
        self.items.update()
        # check for collission
        gotitems = pg.sprite.groupcollide(self.items, self.players, True, False)
        self.render_stats()


    def render(self):
        # self.players.draw(self.image)
        self.image.fill((0,0,0))

        # draw items
        for spr in iter(self.items):
            spr.draw(self.image)
            if spr.rect.top > settings.SCREENHEIGHT:
                print(f"killed {spr.id}")
                spr.kill()

        # draw player(s)
        for spr in self.players:
            spr.draw(self.image)

        
        self.image.blit(self.statsribbon, (0,0))


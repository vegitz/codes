import pygame as pg
from pygame.freetype import SysFont

pg.init()


class Label(pg.sprite.Sprite):
    def __init__(self, text, color='white', bgcolor=None, fontname='consolas'):
        pg.sprite.Sprite.__init__(self)
        
        self.font = SysFont(fontname, 24, bold=True)
        self.text = text
        self.color = color
        self.bgcolor = bgcolor

        # print(f"creating {self.__class__.__name__} for {self.text}...")
        self.resize()

    def resize(self, targetwidth=0):
        tsurf, trect = self.font.render(self.text, pg.Color('white'), bgcolor=self.bgcolor)
        self.image = tsurf

        if targetwidth > 0:
            wratio = trect.width / targetwidth
            adj_width = trect.width * wratio
            adj_height = trect.height * wratio
            self.image = pg.Surface((adj_width, adj_height))
            self.image = pg.transform.scale(tsurf, (adj_width, adj_height))

        self.rect = self.image.get_rect()
        # print(f"image resized for {self.text}")


    def move_to(self, x, y, container_rect:pg.Surface):
        self.rect.x = x + container_rect.x
        self.rect.y = y + container_rect.y

    def center_on(self, container_rect:pg.Surface):
        self.rect.centerx = container_rect.width // 2
        self.rect.centery = container_rect.height // 2
        # print(f"{self.text} centered at {self.rect.x}:{self.rect.y}")


class OvenDisplay(pg.sprite.Sprite):
    def __init__(self, width, height, initcolor='grey'):
        pg.sprite.Sprite.__init__(self)

        self.image = pg.Surface((width, height))
        self.image.fill(pg.Color(initcolor))
        self.width = width
        self.height = height
        self.color = initcolor
        self.rect = self.image.get_rect()


    def move_to(self, x, y):
        self.rect = pg.Rect(x, y, self.width, self.height)

    def update(self, temperature):
        self.temperature = temperature
        temperature = int(self.temperature)
        
        max_red = min(255, temperature)
        max_green = min(120, temperature)
        max_blue = min(230, temperature)
        

        # print(f"max colors: {max_red}, {max_green}, {max_blue}")
        self.color = (max_red, 150 - max_green, 255 - max_blue)

    def draw(self, surface: pg.Surface):
        lbl = Label(self.temperature)
        lbl.center_on(self.rect)

        # tsurf, trect = self.font.render(self.temperature, pg.Color('white'))
        # trect.x = (self.rect.width - trect.width) // 2
        # trect.y = (self.rect.height - trect.height) // 2
        # trect.x += self.rect.x
        # trect.y += self.rect.y

        self.image.fill(self.color)

        pg.draw.rect(self.image, self.color, self.rect)
        # surface.blit(tsurf, trect)
        self.image.blit(lbl.image, lbl.rect)

        # persist
        surface.blit(self.image, self.rect)


class DisplayTwin(object):
    def __init__(self, id):
        self.surface = pg.display.set_mode((800, 600))
        self.rect = self.surface.get_rect()

        pg.display.set_caption(f'Display Twin: {id}')
        self.clock = pg.time.Clock()
        self.frames_per_second = 30
        self.avatar = OvenDisplay(64, 96)
        self.avatar.move_to(64, 64)

    def on_iot_event(self, topic, data):
        evt = pg.event.Event(pg.USEREVENT, source='iot_device', data=data)
        pg.event.post(evt)


    def pause(self):
        lbl = Label('Press SPACE BAR to begin')
        lbl.center_on(self.rect)
        self.surface.blit(lbl.image, lbl.rect)
        pg.display.flip()

        self.paused = True
        while self.paused:
            for event in pg.event.get():
                if event.type == pg.KEYDOWN:
                    if event.key == pg.K_SPACE:
                        self.paused = False
                        break
        

    def run(self):
        self.running = True
        while self.running:
            elapsed = self.clock.tick(self.frames_per_second) / 1000
            dirty = False

            for event in pg.event.get():
                if event.type == pg.QUIT:
                    self.running = False
                    break
                if event.type == pg.USEREVENT:
                    if event.source == 'iot_device':
                        self.avatar.update(event.data)
                        dirty = True

            if dirty:
                self.surface.fill((0, 0, 0))
                self.avatar.draw(self.surface)
                pg.display.flip()
                

    def __del__(self):
        pg.quit()


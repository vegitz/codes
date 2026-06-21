import pygame as pg

pg.init()

SCREENWIDTH = 600
SCREENHEIGHT = 300
FPS = 30

resolution = (SCREENWIDTH, SCREENHEIGHT)

screen = pg.display.set_mode(resolution)
clock = pg.time.Clock()

running = True

while running:
    clock.tick(FPS)

    for event in pg.event.get():
        if event.type == pg.QUIT:
            running = False

    
pg.quit()

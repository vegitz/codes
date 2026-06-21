import pygame as pg

pg.init()


from core.gamestate import GameState
from games import settings


class GameEngine:
    def __init__(self):
        
        self.bgcolor = settings.GAME_BGCOLOR
        self.screen = pg.display.set_mode(settings.GAME_SCREENSIZE)
        self.clock = pg.time.Clock()
        self.states = []

    def load(self, game:GameState):
        self.states.append(game)
        pg.display.set_caption(game.id)


    def _callstatemethod(self, statemethod, *args, **kwargs):
        if len(self.states[-1:]) > 0:
            fnc = getattr(self.states[-1], statemethod)
            return fnc(*args, **kwargs)


    def _processevents(self):
        for event in pg.event.get():
            if event.type == pg.QUIT:
                self.running = False
            self._callstatemethod('processevent', event)


    def _update(self, elapsed=1):
        self._callstatemethod('update', elapsed)

    
    def _draw(self):
        self.screen.fill(self.bgcolor)
        if len(self.states[-1:]) > 0:
            state = self.states[-1]
            self.screen.blit(state.image, state.rect)

        pg.display.flip()


    def run(self, fps=30):
        if len(self.states) == 0:
            print('\n\nNo game to run.  Did you forget to call the "load" method?\n')
            return

        self.running = True
        while self.running:
            elapsed = self.clock.tick(fps) / 1000
            self._processevents()
            self._update(elapsed=elapsed)
            self._draw()

        pg.quit()


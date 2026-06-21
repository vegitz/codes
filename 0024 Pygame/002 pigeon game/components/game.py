import pygame as pg
from collections import defaultdict


class Game(object):
    def __init__(self, title, screensize=(300, 600)):
        self.title = title
        self.screensize = screensize

        self.screen = pg.display.set_mode(self.screensize)
        pg.display.set_caption(self.title)
        self.bgcolor = (0, 0, 0)

        self.clock = pg.time.Clock()
        self.pressed = {}

        self.setupcontrols()
        self.setupgamestates()

    def setupcontrols(self):
        self.repeated_keys = {
            'up': pg.K_UP,
            'down': pg.K_DOWN,
            'left': pg.K_LEFT,
            'right': pg.K_RIGHT,
            'space': pg.K_SPACE,
        }
        self.single_press_keys = {
            'quit': pg.QUIT,
            'space': pg.K_SPACE,
        }


    def setupgamestates(self):
        self.states = []
        self.event_subscribers = defaultdict(dict)


    def run(self, FPS=30):
        self.fps = FPS

        self.running = True
        while self.running:
            elapsed = self.clock.tick(self.fps) / 1000
            self.getevents()
            self.updatestate(elapsed)
            self.renderstate()


    def subscribe_to_event(self, stateid, eventid, callback, every=1000):
        pg.time.set_timer(eventid, every)
        self.event_subscribers[eventid][stateid] = callback


    def getevents(self):
        self.pressed = dict()
        current_event_id = self.states[-1].id

        # single-press keys
        self.pressed.update(dict({(k, False) for k in self.single_press_keys}))
        for event in pg.event.get():
            
            if event.type in self.event_subscribers:
                # call subscriber if event it subscribed to, exists
                subs = self.event_subscribers[event.type]
                if current_event_id in subs:
                    fnc = subs[current_event_id]
                    fnc(event.type)

            for key, control in self.single_press_keys.items():
                if control == event.type:
                    self.pressed[key] = True
                else:
                    self.pressed[key] = False

        # repeating (depressed) keys
        self.pressed.update(dict({(k, False) for k in self.repeated_keys}))
        keypressed = pg.key.get_pressed()
        for key, code in self.repeated_keys.items():
            if keypressed[code]:
                self.pressed[key] = True
            else:
                self.pressed[key] = False

    def endofgame(self):
        """ perform checks that would result in end-of-game """

        if self.pressed['quit']:
            print("game quit")
            return True
        
        if len(self.states) < 1:
            print("no more states")
            return True

        return False

    def updatestate(self, elapsed=1):
        if self.endofgame():
            self.running = False
            return

        self.states[-1].update(self.pressed, None)
        # m = [k for k, s in self.pressed.items() if s]
        # t = ", ".join(m)
        # print(f"Pressed: {t}")

    def renderstate(self):
        if self.endofgame():
            self.running = False
            return

        self.screen.fill(self.bgcolor)
        st = self.states[-1]
        st.render()
        self.screen.blit(st.image, st.rect)
        pg.display.flip()

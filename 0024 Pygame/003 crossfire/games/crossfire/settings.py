from os import path
from games import settings as mainsettings


TITLE = 'X-Fire'
BGCOLOR = (0, 200, 0)

GAME_DIR = path.join(mainsettings.GAMES_DIR, 'crossfire')
IMAGES_DIR = path.join(GAME_DIR, 'assets', 'images')

PLAYER1_IMAGE = path.join(IMAGES_DIR, 'player1.png')

ENEMY_INCUBATING_IMAGE = path.join(IMAGES_DIR, 'enemyincubating.png')
ENEMY_HATCHED_IMAGE = path.join(IMAGES_DIR, 'enemyhatched.png')

# events below will be added to USEREVENT
EVENT_BULLET_FIRED = 1

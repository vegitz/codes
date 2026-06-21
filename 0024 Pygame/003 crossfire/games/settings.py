from os import path
import pygame as pg

GAME_BGCOLOR = (10, 10, 10)
GAME_SCREENSIZE = (800, 600)


MAIN_SETTINGS_FILE = path.abspath(__file__)
MAIN_SETTINGS_DIR = path.dirname(MAIN_SETTINGS_FILE)

ROOT_DIR = path.dirname(MAIN_SETTINGS_DIR)

GAMES_DIR = path.join(ROOT_DIR, 'games')

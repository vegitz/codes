import pygame as pg
from pygame import freetype as ft
from os import path

pg.init()
ft.init()

FPS = 30
SCREENWIDTH = 400
SCREENHEIGHT = 600

SETTINGS_DIR = path.dirname(__file__)
ROOT_DIR = path.dirname(SETTINGS_DIR)
IMAGES_DIR = path.join(ROOT_DIR, 'images')

def getimagefile(filename):
    return path.join(IMAGES_DIR, filename)

def getfont(font_family, font_size, is_bold=False, is_italic=False):
    return ft.SysFont(font_family, font_size, bold=is_bold, italic=is_italic)


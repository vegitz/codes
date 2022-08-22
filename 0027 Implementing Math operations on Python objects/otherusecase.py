class Bullet:
    def __init__(self, qty=1):
        self.qty = qty

class Grenade:
    def __init__(self, qty=1):
        self.qty = qty

class Weapon:
    def __init__(self):
        self.bullets = 0
        self.grenades = 0

    def __add__(self, other):
        if isinstance(other, Bullet):
            self.bullets += other.qty
        elif isinstance(other, Grenade):
            self.grenades += other.qty
        else:
            raise Exception(f"Incompatible ammo: {type(other)}")

w = Weapon()
w + Bullet(3)
w + Grenade(2)
print("Bullets  = ", w.bullets)
print("Grenades = ", w.grenades)

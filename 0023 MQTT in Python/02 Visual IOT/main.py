import time
from iotdevices.oven import Oven
from digitaltwins.ovendt import OvenDigitalTwin


topics = ['status/temp']

oi = Oven('iot-oven-001', topics[0])

dt = OvenDigitalTwin('oven-001', topics)
dt.on_load = oi.run         # run publisher before entering main loop
dt.run()

print("Done")

dt = None
oi = None


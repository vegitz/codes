from paho.mqtt import client as mqttclient
import random
import time
import threading

class Oven(object):
    def __init__(self, id, topic, broker_host='localhost', broker_port=1883):
        self.id = id
        self.topic = topic

        # create an oven that publishes its temperature
        self.producer = mqttclient.Client(self.id)
        self.producer.connect(broker_host, broker_port)

    def run(self):
        print(f"starting {self.id} main loop...")
        oit = threading.Thread(target=self._publish, daemon=True)
        oit.start()

    def _publish(self):
        for temp in range(0, 300, 10):
            # temp = random.randint(80, 120)
            self.producer.publish(self.topic, temp)
            time.sleep(0.5)

    def __del__(self):
        print(f"stopping {self.id} main loop...")
        self.producer.loop_stop()

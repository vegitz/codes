from paho.mqtt import client as mqttclient
from .avatar import DisplayTwin


class OvenDigitalTwin(object):
    def __init__(self, id, topics, broker_host='localhost', broker_port=1883):
        self.id = id
        self.topics = topics

        # create a consumer that will display the oven temperature
        self.subscriber = mqttclient.Client(id, userdata={'id':self.id})

        # link the function for displaying the readings
        self.subscriber.on_message = self.display_oven_temp()
        self.subscriber.connect(host=broker_host, port=broker_port)
        self.on_load = None


    def _preload(self):
        if self.on_load:
            self.on_load()
        

    def display_oven_temp(self):
        def fnc(client, userdata, message):
            """ on_message """
            encoding = 'utf-8'

            if message.topic != "subscribe":
                # if it's not a subscription topic, display it
                # print(f"{message.topic}")   #, {userdata}")

                content = message.payload.decode(encoding)
                print(f"{message.topic}: {str(content).rjust(4)}")
                self.ui.on_iot_event(message.topic, content)
        return fnc


    def run(self):
        self.ui = DisplayTwin(self.id)
        self.ui.pause()

        self._preload()
        
        print(f"starting {self.id} main loop...")
        self.subscriber.loop_start()
        for topic in self.topics:
            print(f"\tsubscribing to `{topic}`...")
            self.subscriber.subscribe(topic)

        self.ui.run()


    def __del__(self):
        print(f"stopping {self.id} main loop...")
        self.subscriber.loop_stop()


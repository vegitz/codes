import time
from paho.mqtt import client as mqttclient

def display_oven_temp(client, userdata, message):
    """ on_message """
    encoding = 'utf-8'

    if message.topic != "subscribe":
        # if it's not a subscription topic, display it
        print(f"{message.topic}")
        content = message.payload.decode(encoding)
        print(f"\t{content}")


# create an oven that publishes its temperature
producer = mqttclient.Client('my-smart-oven')
producer.connect('localhost', 1883)

# create a consumer that will display the oven temperature
subscriber = mqttclient.Client('my-smart-tv', userdata={'id':'tv-smt-99'})

# link the function for displaying the readings
subscriber.on_message = display_oven_temp

subscriber.connect('localhost', 1883)
subscriber.loop_start()
subscriber.subscribe('oven-01/temp')
time.sleep(1)

producer.publish('oven-01/temp', 30)

time.sleep(2)
subscriber.loop_stop()

print("Done")



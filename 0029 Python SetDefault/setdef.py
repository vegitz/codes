
# devices_v1 = {}

# def record_device_temperature_v1(device_id, temperature):
#     if device_id not in devices_v1:
#         devices_v1[device_id] = []

#     devices_v1[device_id].append(temperature)


# devices_v2 = {}

# def record_device_temperature_v2(device_id, temperature):
#     devices_v2.setdefault(device_id, []).append(temperature)


# import random

# def take_measurements(recorder):
#     for t in range(5):
#         id = 'oven-%s' % (t,)
#         for x in range(3):
#             temp = random.randrange(0, 100)
#             recorder(id, temp)

# """
# take_measurements(record_device_temperature_v1)
# print(devices_v1)

# print("\n\n")
# """

# take_measurements(record_device_temperature_v2)
# print(devices_v2)




"""
Here's another mock use-case if you're using Django.
These codes aren't the real Django codes, just using them
to illustrate the idea :)
"""

class HttpResponse(object):
    pass

def simple_response(content, **headers):
    headers.setdefault("Content-Type", "text/html")
    resp = HttpResponse()

    print("Headers:")
    for key, value in headers.items():
        print(f"\t{key} = {str(value)}")

    return resp

def index(request):
    print("\nIndex")
    return simple_response("OK")

def api(request):
    print("\API")
    hdrs = {"Content-Type": "application/json"}
    return simple_response("OK", **hdrs)


index(None)
api(None)


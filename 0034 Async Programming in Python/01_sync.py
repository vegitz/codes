import time
from datetime import datetime as dt

dtstr = lambda : dt.now().strftime("%H:%M:%S.%f")


def call_a_webservice(url, simulated_duration_time):
    time.sleep(simulated_duration_time)

web_services = {
    'http://quick.one': 12,
    'http://slow.api': 13,
    'http://have.patience': 15
}

total_elapsed = 0
for url, simtime in web_services.items():
    print(f"{dtstr()} calling {url} ...")
    started = time.time()
    call_a_webservice(url, simtime)
    elapsed = time.time() - started
    total_elapsed += elapsed
    print(f"{dtstr()} done calling {url}. Elapsed time: {elapsed}")

print(f"All done! Total elapsed time: {total_elapsed}")

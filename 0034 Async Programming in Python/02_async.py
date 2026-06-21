import time
from datetime import datetime as dt
import threading

dtstr = lambda : dt.now().strftime("%H:%M:%S.%f")

web_services = {
    'http://quick.one': 12,
    'http://slow.api': 13,
    'http://have.patience': 15
}

def call_a_webservice(url, simulated_duration_time, call_when_done):
    started = time.time()
    print(f"{dtstr()} calling {url} ...")
    time.sleep(simulated_duration_time)
    elapsed = time.time() - started
    call_when_done(url, elapsed)


def elapsed_time_collector(url, elapsed_time):
    print(f"{dtstr()} done calling {url}. Elapsed time: {elapsed_time}")


main_start = time.time()
jobs = []
for url, simtime in web_services.items():
    job = threading.Thread(target=call_a_webservice, args=(url, simtime, elapsed_time_collector))
    job.start()
    jobs.append(job)

# wait for all jobs to complete
for job in jobs:
    job.join()

total_elapsed = time.time() - main_start
print(f"All done! Total elapsed time: {total_elapsed}")


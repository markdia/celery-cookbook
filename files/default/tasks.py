import time
import ssl
import json
from celery import Celery
from celery.task.http import URL

config = open('config.json')
config = json.load(config)

app = Celery('tasks', backend='amqp', broker='amqp://'+config['rabbit_user']+':'+config['rabbit_pass']+'@'+config['rabbit_host']+':'+str(config['rabbit_port'])+'//')
app.conf.BROKER_USE_SSL={
    'ca_certs': config['ca_certs'],
    'keyfile': config['keyfile'],
    'certfile': config['certfile'],
    'cert_reqs': ssl.CERT_REQUIRED,
}
app.conf.CELERY_TASK_SERIALIZER = 'json'
app.conf.CELERY_RESULT_SERIALIZER = 'json'
app.conf.CELERY_ACCEPT_CONTENT =['json']
app.conf.CELERY_TASK_RESULT_EXPIRES = None

@app.task
def add(x, y):
    return x + y

default['celery']['autostart'] = true
default['celery']['user'] = 'root'
default['celery']['group'] = 'root'
default['celery']['workdir'] = '/var/celery'
default['celery']['app'] = 'tasks'
default['celery']['include'] = 'celery.task.http'
default['celery']['config'] = {}

# A URL to grab the task file you wish to use celery,
# will attempt to get it with remote file
# default['celery']['taskfile'] = ''

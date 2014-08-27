name 'celery'
maintainer 'Colin Hubert'
maintainer_email 'chubert@turbine.com'
license 'Apache 2.0'
description 'Installs celery through pip and runs it through supervisord'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

recipe 'celery::default',
       'Installs celery through pip and runs it through supervisord'

depends 'python'
depends 'supervisor'

%w( ubuntu centos ).each do |os|
  supports os
end

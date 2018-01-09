apt_update 'daily' do
  frequency 86_400
  action :periodic
end

package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  gid 'tomcat'
  home '/opt/tomcat'
end

directory '/opt/tomcat' do
  #action :create
  group 'tomcat'
end

remote_file 'apache-tomcat-8.0.48.tar.gz' do
  source 'http://apache.volia.net/tomcat/tomcat-8/v8.0.48/bin/apache-tomcat-8.0.48.tar.gz'
end

#NO DESIRED
execute 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

#NO DESIRED
execute 'chgrp -R tomcat /opt/tomcat'

directory '/opt/tomcat/conf' do
  mode '0070'
end

#NO DESIRED
execute 'chmod g+r /opt/tomcat/conf/*'

#NO DESIRED
execute 'chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ opt/tomcat/temp/ /opt/tomcat/logs/'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#NO DESIRED
execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end

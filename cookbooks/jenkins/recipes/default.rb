#wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
remote_file '/tmp/jenkins-ci.org.key' do
  source 'https://pkg.jenkins.io/debian/jenkins-ci.org.key'
  notifies :run, 'execute[apt-key add /tmp/jenkins-ci.org.key]', :immediately
end

execute 'apt-key add /tmp/jenkins-ci.org.key' do
  action :nothing
end

#Add this or execute apt-add
#deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
execute 'printf "\n" | apt-add-repository ppa:webupd8team/java'

#sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
file '/etc/apt/sources.list.d/jenkins.list' do
  content 'deb http://pkg.jenkins.io/debian-stable binary/'
end

#sudo apt-get update
apt_update 'daily' do
  frequency 60
  action :periodic
end

#deb conf set
execute 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections; echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections'
#java
package 'oracle-java8-installer'

#sudo apt-get install jenkins
package 'jenkins'

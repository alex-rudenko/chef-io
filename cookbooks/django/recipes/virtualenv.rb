include_recipe 'django::default'

package 'python3-pip'

#NOT GOOD
execute 'pip3 install virtualenv'

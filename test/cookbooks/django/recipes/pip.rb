include_recipe 'django::default'

package 'python3-pip'

#REFACTOR, NOT GOOD
execute 'pip3 install django'

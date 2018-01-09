apt_update 'daily' do
  frequency 86_400
  action :periodic
end

#include_recipe 'django::package'
#include_recipe 'django::pip'

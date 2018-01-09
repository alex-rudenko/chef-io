describe command 'ls /' do
  its('stdout') { should include 'tmp' }
end

describe command 'django-admin --version' do
  its('stdout') { should include '1.6' } 
end

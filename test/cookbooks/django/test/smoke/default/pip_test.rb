describe command 'ls /' do
  its('stdout') { should include 'tmp' }
end

describe command 'django-admin --version' do
  its('stdout') { should include '2.0' } 
end

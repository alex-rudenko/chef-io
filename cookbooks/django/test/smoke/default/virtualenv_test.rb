describe command 'ls /' do
  its('stdout') { should include 'tmp' }
end

describe command 'virtualenv --version' do
  its('stdout') { should include '15.' } 
end

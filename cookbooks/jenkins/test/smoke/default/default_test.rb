describe command('ls /') do
  its(:stdout) { should include 'tmp' } 
end

describe command('curl http://127.0.0.1:8080') do
  its(:stdout) { should include 'hudson' } 
end

describe command('wget -S http://127.0.0.1:8080') do
  its(:stderr) { should include 'Jenkins' } 
end

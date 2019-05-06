# encoding: utf-8
# copyright: 2019, M2mobi

title 'verify nginx config setup'

describe file('/etc/nginx/fastcgi_params') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/uwsgi_params') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/rewrite_lunr') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/rewrite_lunr_api') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/rewrite_m2mobi') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/php.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/php_cors.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/conf.d/default.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/conf.d/localhost.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end

describe file('/etc/nginx/conf.d/test.wfc.m2mobi.com.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_writable.by('owner') }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
  it { should_not be_executable }
end
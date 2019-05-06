# encoding: utf-8
# copyright: 2019, M2mobi

title 'verify nginx service setup'

describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
end
# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkins::package
class jenkins::package {
    file{'/etc/apt/sources.list.d/jenkins.list':
    ensure  => present,
    content => template('profile/jenkins/jenkins.list.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Exec['refresh aptcache for jenkins']
  }
  exec{'refresh aptcache for jenkins':
    command      => 'apt-cache update',
    path         => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin',
    require      => File['/etc/apt/sources.list.d/jenkins.list'],
    refreshonly => true
  }
  package{'jenkins':
    ensure  => latest,
    require => File['/etc/apt/sources.list.d/jenkins.list'],
    notify  => Service['jenkins']
  }

  contain jenkins::service

}

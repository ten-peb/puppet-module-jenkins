# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include jenkins::service
class jenkins::service {
  include jenkins::package
  service{'jenkins':
    ensure  => running,
    enable  => true,
    require => Package['jenkins']
  }
}

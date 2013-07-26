class maria::yumrepository {

  $release = '5.5'

  $os = $::operatingsystem ? {
    'RedHat'    => 'rhel',
    'LinuxMint' => 'ubuntu',
    default     => inline_template('<%= @operatingsystem.downcase %>'),
  }

  $arch = $::architecture ? {
    /^.*86$/ => 'x86',
    /^.*64$/ => 'amd64',
    default  => $::architecture,
  }

  yumrepo { 'mariadb':
    descr    => 'MariaDB Yum Repo',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
    baseurl  => "http://yum.mariadb.org/${release}/${os}${::lsbmajdistrelease}-${arch}",
  }

}

class maria::aptrepository {

  $release = '5.5'

  $os = $::operatingsystem ? {
    'RedHat'    => 'rhel',
    'LinuxMint' => 'ubuntu',
    default     => inline_template('<%= @operatingsystem.downcase %>'),
  }

  $arch = $::architecture ? {
    /^.*86$/ => 'x86',
    /^.*64$/ => 'amd64',
    default  => $::architecture,
  }

  exec {'Import MariaDB Apt repo key':
    command     => '/usr/bin/apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && /usr/bin/touch /root/.my.keyimported',
    refreshonly => true,
    creates     => '/root/.my.keyimported',
  }

  file { '/etc/apt/sources.list.d/maria.list':
    content => "# MariaDB repository list
# http://mariadb.org/mariadb/repositories/
deb http://ftp.osuosl.org/pub/mariadb/repo/${release}/${os} ${::lsbdistcodename} main
deb-src http://ftp.osuosl.org/pub/mariadb/repo/${release}/${os} ${::lsbdistcodename} main",
  }

}

class maria::debpackages {

  package { 'mariadb-server':
    ensure => 'installed',
  }
  package { 'mariadb-client':
    ensure => 'installed',
  }

}

class maria::rpmpackages {

  package { 'MariaDB-server':
    ensure => 'installed',
    alias  => 'MySQL-server',
  }
  package { 'MariaDB-client':
    ensure => 'installed',
    alias  => 'MySQL-client',
  }

}

class maria::mytop {

  package { 'mytop':
    ensure => 'absent',
  }

  exec { 'Download MariaDB mytop':
    command => '/usr/bin/wget -O /usr/bin/mytop https://raw.github.com/atcurtis/mariadb/master/scripts/mytop.sh && /bin/chmod a+x /usr/bin/mytop',
    creates => '/usr/bin/mytop',
    require => Package['mytop'],
  }

}

Package {
   allow_virtual => true,
}

package { 'wget':
  provider => 'yum',
  name => 'wget',
  ensure => installed
}

package { 'curl':
  provider => 'yum',
  name => 'curl',
  ensure => installed
}

package { 'java-openjdk8':
  provider => 'yum',
  name => 'java-1.8.0-openjdk-devel',
  ensure => installed
}

service { 'firewalld-stop':
  name => 'firewalld',
  stop => 'true',
  enable => 'false'
}

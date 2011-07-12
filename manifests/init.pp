class maria::yumrepository {

   $basearch = "i386"
   yumrepo {


	 
   "ourdelta":
            descr       => "Ourdelta",
            enabled     => 1,
            gpgcheck    => 0,
            baseurl     => "http://master.ourdelta.org/yum/CentOS-MySQL50/5Server/"; 
        

}


}

class maria::aptrepo {
	exec {"Import MariaDB Apt repo key":
		command => "/usr/bin/apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1BB943DB && /usr/bin/touch /root/.my.keyimported",
		refreshonly => true,
		creates => "/root/.my.keyimported",
	}


	file { "/etc/apt/sources.list.d/maria.list":	
		content => "# MariaDB repository list - created 2011-07-05 07:31 UTC
# http://downloads.askmonty.org/mariadb/repositories/
deb http://mirror.switch.ch/mirror/mariadb/repo/5.2/debian squeeze main
deb-src http://mirror.switch.ch/mirror/mariadb/repo/5.2/debian squeeze main";
		
	
	}
	


}
class maria::debpackages {
	package { "mariadb-server":
			ensure => "installed";
		  "mariadb-client":
			ensure => "installed";
		
	}

}

class maria::rpmpackages {


   $basearch = "i386"
	package { "MySQL-OurDelta-server.$basearch":
            		alias  => "MySQL-server",
			ensure => "installed";
		"MySQL-OurDelta-client.$basearch":
            		alias  => "MySQL-client",
			ensure => "installed";

	}
	
}
	

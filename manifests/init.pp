class maria::repository {

 yumrepo {

	 
   "ourdelta":
            descr       => "Ourdelta",
            enabled     => 1,
            gpgcheck    => 0,
            baseurl     => "http://master.ourdelta.org/yum/CentOS-MySQL50/5Server/"; 
        

}


}


class maria::packages {


	package {
		"MySQL-OurDelta-server":
			ensure => "installed";
		"MySQL-OurDelta-client":
			ensure => "installed";

	}
	
}
	

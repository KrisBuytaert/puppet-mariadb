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
		"MySQL-OurDelta-server.$hardwaremodel":
            alias => "MySQL-server",
			ensure => "installed";
		"MySQL-OurDelta-client.$hardwaremodel":
            alias => "MySQL-client",
			ensure => "installed";

	}
	
}
	

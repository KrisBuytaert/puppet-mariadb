class maria::repository {

   $basearch = "i386"
 yumrepo {


	 
   "ourdelta":
            descr       => "Ourdelta",
            enabled     => 1,
            gpgcheck    => 0,
            baseurl     => "http://master.ourdelta.org/yum/CentOS-MySQL50/5Server/$basearch"; 
        

}


}


class maria::packages {


   $basearch = "i386"
	package {
		"MySQL-OurDelta-server.$basearch":
            alias => "MySQL-server",
			ensure => "installed";
		"MySQL-OurDelta-client.$basearch":
            alias => "MySQL-client",

			ensure => "installed";

	}
	
}
	

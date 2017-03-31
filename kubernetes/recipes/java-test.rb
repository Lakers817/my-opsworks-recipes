 directory '/usr/lib/jvm'do
   owner 'root'
   group 'root'
   mode '755'
   action :create
   end

 bash 'install_java' do
   user 'root'
   cwd '/tmp'
   code <<-EOH
   BASE_URL_8=http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71
   JDK_VERSION=${BASE_URL_8: -8}
   declare -a PLATFORMS=("-linux-x64.tar.gz")
   for platform in "${PLATFORMS[@]}"
   do
   wget -c -O "$JDK_VERSION$platform" --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "${BASE_URL_8}${platform}"
   done
   tar -xzvf jdk-8u71-linux-x64.tar.gz
   mv jdk1.8.0_71  /usr/lib/jvm/jdk1.8.0
   EOH
   not_if do
   File.directory?('/usr/lib/jvm/jdk1.8.0')
   end
    end

 bash 'execute_install' do
  user 'root'
  code <<-EOH
  update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0/bin/java" 1
  update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0/bin/javac" 1
  update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
  chmod a+x /usr/bin/java
  chmod a+x /usr/bin/javac
  chmod a+x /usr/bin/javaws
  EOH
  end



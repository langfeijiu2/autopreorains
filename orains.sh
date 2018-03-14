#/bin/bash
#input oracle_sid
echo ""
read -p "要安装的数据库实例是啥:" oraclesid
read -p "你想把oracle放在哪个主路径:" oraclepath
#set local-yum    &>> /tmp/orains.log
echo "挂载yum源，请等待...."
mkdir -p /media/cdrom    &> /tmp/orains.log
mount /dev/cdrom /mnt    &>> /tmp/orains.log
cp -rf /mnt/* /media/cdrom/    &>> /tmp/orains.log
echo "[local-yum]"                  > /etc/yum.repos.d/localyum.repo     &>> /tmp/orains.log
echo "name = localyum"              >> /etc/yum.repos.d/localyum.repo     &>> /tmp/orains.log
echo "baseurl=file:///media/cdrom"  >> /etc/yum.repos.d/localyum.repo     &>> /tmp/orains.log
echo "enable=1"                     >> /etc/yum.repos.d/localyum.repo     &>> /tmp/orains.log
echo "gpgcheck=0"                   >> /etc/yum.repos.d/localyum.repo     &>> /tmp/orains.log
echo "修改内核..."
#change kernel    &>> /tmp/orains.log
echo "fs.aio-max-nr = 1048576 "                >> /etc/sysctl     &>> /tmp/orains.log
echo "fs.file-max = 6815744 "                  >> /etc/sysctl     &>> /tmp/orains.log
echo "kernel.shmall = 2097152"                >> /etc/sysctl     &>> /tmp/orains.log
echo "kernel.shmmax = 956770304 "              >> /etc/sysctl     &>> /tmp/orains.log
echo "kernel.shmmni = 4096 "                   >> /etc/sysctl     &>> /tmp/orains.log
echo "kernel.sem = 250 32000 100 128 "         >> /etc/sysctl     &>> /tmp/orains.log
echo "net.ipv4.ip_local_port_range = 9000 65500 " >> /etc/sysctl     &>> /tmp/orains.log
echo "net.core.rmem_default = 262144 "         >> /etc/sysctl     &>> /tmp/orains.log
echo "net.core.rmem_max = 4194304 "            >> /etc/sysctl     &>> /tmp/orains.log
echo "net.core.wmem_default = 262144 "         >> /etc/sysctl     &>> /tmp/orains.log
echo "net.core.wmem_max = 1048576"             >> /etc/sysctl     &>> /tmp/orains.log
/etc/sysctl -p    &>> /tmp/orains.log

echo "session required pam_limits.so"          >> /etc/pam.d/login    &>> /tmp/orains.log

#add group and user
echo "添加用户..."
grep oinstall /etc/group    &>> /tmp/orains.log
	if [ $? -eq 1 ]
	then
	groupadd -g 200 oinstall     &>> /tmp/orains.log
	echo "添加用户组 oinstall"    &>> /tmp/orains.log
	fi
grep dba /etc/group
	if [ $? -eq 1 ]
	then
	groupadd -g 201 dba     &>> /tmp/orains.log
	echo "添加用户组 dba"    &>> /tmp/orains.log
	fi
id oracle
	if [ $? -eq 1 ]
	then
	useradd -u 200 -g oinstall -G dba oracle    &>> /tmp/orains.log
	echo "orapass" | passwd --stdin oracle    &>> /tmp/orains.log
	echo "添加用户 oracle 密码orapass"    &>> /tmp/orains.log
	fi
#add directory
echo "添加文件夹..."
mkdir -p /$oraclepath/app/    &>> /tmp/orains.log
chown -R oracle:oinstall /$oraclepath/app/    &>> /tmp/orains.log
chmod -R 775 /$oraclepath/app/    &>> /tmp/orains.log

#download packages
rm -rf /etc/yum.repos.d/*
yum clean all
yum make cache
echo "安装依赖包，请等待..."
yum install -y binutils-2.23.52.0.1-12.el7.x86_64    &>> /tmp/orains.log
yum install -y compat-libcap1-1.10-3.el7.x86_64    &>> /tmp/orains.log
yum install -y compat-libstdc++-33-3.2.3-71.el7.i686    &>> /tmp/orains.log
yum install -y compat-libstdc++-33-3.2.3-71.el7.x86_64    &>> /tmp/orains.log
yum install -y gcc-4.8.2-3.el7.x86_64    &>> /tmp/orains.log
yum install -y gcc-c++-4.8.2-3.el7.x86_64    &>> /tmp/orains.log
yum install -y glibc-2.17-36.el7.i686    &>> /tmp/orains.log
yum install -y glibc-2.17-36.el7.x86_64    &>> /tmp/orains.log
yum install -y glibc-devel-2.17-36.el7.i686    &>> /tmp/orains.log
yum install -y glibc-devel-2.17-36.el7.x86_64    &>> /tmp/orains.log
yum install -y ksh    &>> /tmp/orains.log
yum install -y libaio-0.3.109-9.el7.i686    &>> /tmp/orains.log
yum install -y libaio-0.3.109-9.el7.x86_64    &>> /tmp/orains.log
yum install -y libaio-devel-0.3.109-9.el7.i686    &>> /tmp/orains.log
yum install -y libaio-devel-0.3.109-9.el7.x86_64    &>> /tmp/orains.log
yum install -y libgcc-4.8.2-3.el7.i686    &>> /tmp/orains.log
yum install -y libgcc-4.8.2-3.el7.x86_64    &>> /tmp/orains.log
yum install -y libstdc++-4.8.2-3.el7.i686    &>> /tmp/orains.log
yum install -y libstdc++-4.8.2-3.el7.x86_64    &>> /tmp/orains.log
yum install -y libstdc++-devel-4.8.2-3.el7.i686    &>> /tmp/orains.log
yum install -y libstdc++-devel-4.8.2-3.el7.x86_64    &>> /tmp/orains.log
yum install -y libXi-1.7.2-1.el7.i686    &>> /tmp/orains.log
yum install -y libXi-1.7.2-1.el7.x86_64    &>> /tmp/orains.log
yum install -y libXtst-1.2.2-1.el7.i686    &>> /tmp/orains.log
yum install -y libXtst-1.2.2-1.el7.x86_64    &>> /tmp/orains.log
yum install -y sysstat*    &>> /tmp/orains.log
yum install -y make*    &>> /tmp/orains.log
yum install -y elfutils-libelf*    &>> /tmp/orains.log
yum install -y libXp*    &>> /tmp/orains.log
yum install -y unixODBC-2.3.1-6.el7.x86_64    &>> /tmp/orains.log
yum install -y unixODBC-2.3.1-6.el7.i686    &>> /tmp/orains.log
yum install -y unixODBC-devel-2.3.1-6.el7.x86_64    &>> /tmp/orains.log
yum install -y unixODBC-devel-2.3.1-6.el7.i686    &>> /tmp/orains.log
yum install -y lrzsz     &>> /tmp/orains.log

#modify bash_profile
echo "增加oracle用户变量..."
echo "export TMP=/tmp"             >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export TMPDIR=$TMP"          >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export EDITOR=vim"           >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export ORACLE_BASE=/$oraclepath/app/oracle" >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_home1" >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export LANG=en_US.utf-8"      >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export ORACLE_SID=$oraclesid"     >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export NLS_LANG=AMERICAN_CHINA.ZHS16GBK"   >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib"   >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export PATH=$ORACLE_HOME/bin:$PATH"    >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "EDITOR=vim"                  >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "stty erase ^H"               >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "alias rman='rlwrap rman'"     >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "alias sqlplus='rlwrap sqlplus'"     >> /home/oracle/.bash_profile    &>> /tmp/orains.log
echo "export LANG NLS_LANG TMP TMPDIR ORACLE_BASE ORACLE_HOME ORACLE_SID LD_LIBRARY_PATH EDITOR"             >> /home/oracle/.bash_profile    &>> /tmp/orains.log
setfacl -Rm u:oracle:rwx ./

echo "安装数据库软件去吧..."


#打开图形化界面    &>> /tmp/orains.log
export DISPLAY=localhost:0.0    &> /tmp/orains2.log
xhost +    &>> /tmp/orains2.log
echo "解压包，请等待..."
unzip -o /app/linux.x64_11gR2_database_1of2.zip    &>> /tmp/orains2.log
unzip -o /app/linux.x64_11gR2_database_2of2.zip    &>> /tmp/orains2.log
sudo -u oracle /app/database/runInstaller



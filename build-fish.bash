set -e # stop on error
set -x

if grep CentOS /etc/*release ; then
	echo CentOS
	yum -y install ncurses-devel cmake make
	yum -y groupinstall 'Development Tools' 
fi
if grep Ubuntu /etc/*release ; then
	echo Ubuntu
	apt-get install build-essential cmake ncurses-dev libncurses5-dev libpcre2-dev gettext
fi
cd /usr/src
if [ ! -d /usr/src/fish-shell ]; then
	git clone https://github.com/fish-shell/fish-shell
fi
cd fish-shell
if [ ! -d /usr/src/fish-shell/build ]; then
	mkdir build
fi
#export CMAKE_INSTALL_PREFIX=/tmp/.local
cd build 
cmake ..
make DESTDIR=/tmp/.root 
make DESTDIR=/tmp/.root install
ls -l $DESTDIR/local/bin/fish*
echo Done

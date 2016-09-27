execute 'install instance-linux' do
  cwd '/vagrant'
  command <<-EOF
  ./autogen.sh
  ./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc \
      --with-os-dir=/srv/ganeti/os
  make
  make install
  EOF
  action :run
end

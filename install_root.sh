#!/bin/bash

apt-get install gdb git

git clone https://github.com/pwndbg/pwndbg.git /opt/pwndbg
git clone https://github.com/longld/peda.git /opt/peda
git clone https://github.com/longld/peda.git /opt/gef

chmod +x /opt/pwndbg/setup.sh
/opt/pwndbg/setup.sh

cat <<EOT >> ~/.gdbinit

define init-peda
source /opt/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source /opt/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end

define init-gef
source /opt/gef/.gdbinit-gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end

EOT

cat <<EOT >> /usr/bin/peda
#!/bin/sh
exec gdb -q -ex init-peda "$@"
EOT

cat <<EOT >> /usr/bin/pwndbg
#!/bin/sh
exec gdb -q -ex init-pwndbg "$@"
EOT

cat <<EOT >> /usr/bin/gef
#!/bin/sh
exec gdb -q -ex init-gef "$@"
EOT

chmod +x /usr/bin/peda
chmod +x /usr/bin/pwndbg
chmod +x /usr/bin/gef

echo ""INSTALLED!!!!"

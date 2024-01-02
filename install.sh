#github.com/bruhpate
echo "Programma di installazione di arch"
echo "Test di connessione a internet"


risposta=$(ping -c 4 archlinux.org 2>&1)

if [ $? -ne 0 ]; then
	echo "Controlla di essere connesso a internet (failed ping to archlinux.org)."
	exit 0
fi

disk="/dev/sda"
echo "Hai 15 secondi per interrompere l'operazione"
sleep 15

fdisk $disk <<EOF
n
1
2048
+1024MB
n
2


w
EOF

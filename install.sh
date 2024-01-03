#github.com/bruhpate
echo "Programma di installazione di arch"
echo "Test di connessione a internet"


risposta=$(ping -c 4 archlinux.org 2>&1)

if [ $? -ne 0 ]; then
	echo "Controlla di essere connesso a internet (failed ping to archlinux.org)."
	exit 0
fi

#$1
disk="$1"
root_part=$disk"2"
boot_part=$disk"1"
echo "Eliminazione disco, hai 15 secondi per interrompere l'operazione"
sleep 15

dd if=/dev/zero of=$1 bs=512 count=1 conv=notrunc
fdisk $disk <<EOF
n
p
1
2048
+1G
n
p
2


w
EOF

echo "Disco partizionato"

#$2
echo "Installazione filesystem"
if [[ $2 == ext4 ]];then
	mkfs.ext4 $root_part
elif [[ $2 == btrfs ]];then
	mkfs.btrfs -f $root_part
fi
mkfs.vfat -F 32 $boot_part

mount $root_part /mnt
mkdir /mnt/boot
mount $boot_part /mnt/boot

mv pacman.conf /etc/pacman.conf

pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

cp install2.sh /mnt/root/
cp /mnt/root/.bashrc /mnt/root/.bashrc2
echo "sh /root/install2.sh" >> /mnt/root/.bashrc
arch-chroot /mnt


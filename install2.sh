ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc

echo "LANG=it_IT.UTF-8" >> /etc/locate.conf
echo "KEYMAP=it" >> /etc/vconsole.conf
echo "archlinux" >> /etc/hostname

passwd <<EOF
root
root
EOF

mkinitcpio -P

pacman -S grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

mv /root/.bashrc2 /root/.bashrc

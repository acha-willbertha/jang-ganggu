#!/bin/bash

# Nama file swap
SWAP_FILE=/swapfile

# Ukuran swap dalam gigabyte
SWAP_SIZE_GB=1

# Periksa apakah script dijalankan sebagai root
if [ "$(id -u)" -ne 0 ]; then
   echo "Script ini harus dijalankan sebagai root" 
   exit 1
fi

# Buat file swap dengan ukuran yang diinginkan
fallocate -l ${SWAP_SIZE_GB}G $SWAP_FILE

# Atur permission agar file swap hanya dapat diakses oleh root
chmod 600 $SWAP_FILE

# Konfigurasi file sebagai swap
mkswap $SWAP_FILE

# Aktifkan swap
swapon $SWAP_FILE

# Tambahkan ke /etc/fstab agar swap otomatis diaktifkan saat boot
echo "$SWAP_FILE none swap sw 0 0" | tee -a /etc/fstab

# Tampilkan informasi swap untuk memverifikasi
swapon --show

# Tampilkan informasi memori untuk memastikan swap telah ditambahkan
free -h

echo "Swap memory sebesar ${SWAP_SIZE_GB}GB telah ditambahkan dan diaktifkan."

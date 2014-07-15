Git-deploy
=========

Saat lu ngedevelop aplikasi web, ada saatnya dimana mesti ngaplod file lu ke server buat ngecek apakah apps lu bisa jalan di server atau ngga. Tapi, pasti kadang lu bingung file mana aja yang udah lu ubah. Akhirnya lu upload ulang semua filenya via ftp ataupun scp. Buat yang koneksinya kenceng sih oke-oke aja, tapi kita hidup di Indonesia cuy, internetnya lambat.

Dari masalah tersebut, gue punya ide simple. Gimana kalo kita transfer source apps kita via git. Loh kenapa git?

  - Enak bro, lu ga usah milih-milih file yang bakal lu upload.
  - Data yang diupload cuma diff-nya doang. Jadi kalo lu ngedit 2 baris file yang ukurannya 5MB, yang bakal diupload cuma yang dua baris itu doang.
  - Shit man, ini git. Kalo yang nge-push (upload) lebih dari satu orang, biasanya suka ada file yang konflik. Tapi kalo pake git, lu bisa dengan mudah lihat file yang konflik tadi baris-per-baris. Bandingin kalo pake ftp!

Tapi seting git sebagai media transfer ngga segampang mencintai seseorang, brow, Tapi ga sesulit melupkan sesorang juga sih. Makanya gue bikin tool ini agar hidup menjadi lebih mudah.

Version
----

0.1-alpha: Artinya aplikasi masih di tahap awal pengembangan. Bahkan gue belum ngetest secara mendalam. 

Features
------

* Semua kemudahan git
* Gue juga nambahin fitur Hook, dimana kalo applikasi lu mengandung file composer.json, tool ini akan secara otomatis mendownload composer dan menjalankan composer.
* Selain composer, gue juga nambahin Hook buat apps nodejs, via npm.

Requirements
--------------

* yang pasti ini ga bisa jalan di web hosting biasa. minimal lu butuh vps dengan akses ssh.
* yang ga kalah penting juga, lu mesti nginstall git di server lu. Kalo di debian bisa via `$ apt-get install git`. Di tempat lain, cari sendiri aja ya.
* NO-WINDOWS! gue baru coba ini di archlinux dan ubuntu.
* Kalo lu ngembangin aplikasi pake composer, lu butuh wget dan akses internet buat download composer.phar


Installation
--------------

Akses server lu via ssh, terus jalanin ini:

```sh
cd ~
git clone git@github.com:abiehaf/git-deploy.git git-deploy
cd git-deploy
sudo ./install
```

How to Use
------------

**Server**

Gue saranin lu bikin user baru dengan nama git. Kalo di debian tinggal jalanin `$ sudo adduser git`. Terus masukin password.

Abis bikin user baru, jalanin:

```sh
sudo -u git bash
git-deploy create nama-repo.git /var/www/nama-app

```
*Pastiin user git bisa nulis di directory /var/www. Caranya? cari sendiri lah, ya. kan udah gede.*


**Komputer Lu**

Nah sekarang lu udah siap ngedeploy nih. Misal nama domain lu domain.com.

```sh
cd /path/ke/proyek/lu/
git init
git add *
git commit -m "yey, gue deploy aplikasi pake tool buatan a abi"
git remote add deploy git@domain.com:nama-repo.git # bisa juga pake alamat ip git@1.2.3.4:nama-repo.git
git push deploy master
```

*Tada, file-file yang ada di folder /path/ke/proyek/lu/ bakal ke upload ke /var/www/nama-app di server lu.*

Untuk selanjutnya lu tinggal jalanin 
```sh
cd /path/ke/proyek/lu/
git add *
git commit -m "yey, buat kesekian kalinya, gue deploy aplikasi pake tool buatan a abi lagi"
git push
```

Buat cara pake git, googling sendiri aja ya. Kalo masih pusing dengan penjelasan gue, bisa contact gue di [@abiehaf](https://twitter.com/abiehaf) (sekalian follow ya :p )


License
----

**Copyright 2014 Abi Hafshin**

Software ini adalah Free Software, lu boleh make, ngubah, nyebarin aplikasi ini sesuka lu, tapi jangan lupa kasih tau sumber serta lisensi dari aplikasi ini.
Informasi lebih lengkap cek http://www.gnu.org/licenses/


---
title: Windows 安裝 mount User 家目錄
date: 2017-06-10 14:44:28
tags: [Windows, Note]
---

安裝 Linux 環境時，我們常會把某個分割區掛載到 /home
目錄，以起到方便管理的作用。

Windows 能不能把 D 槽掛到 C:\Users 目錄呢？

答案是可以的，雖然步驟非常繁雜。

以下是自己經過多次嘗試之後整理出來的流程，尚待翻譯。

# Windows Install Note

## Preface

If you are creating installation media on usbstick, it's highly recommend to
using [rufus](https://rufus.akeo.ie/).
Remember to select the partition scheme that is consistent to the target
machine for your installation.

## Partition

Partition disk(s) using `diskpart`.

Make sure to create EFI(ESP) partition and MSR(Microsoft Reserved Partition).

You can use `Ctrl + F10` to open command prompt during installation.

- `convert gpt`: change disk into GPT disk.
- `create partition efi size=250`: create EFI partition with size 250MB
- `create partition msr size=128`: create MSR partition with size 128MB

## Mount Disk to `User` Folder

After couple times of reboot, windows installation procedure will ask you to
use express setting or do some customization.

Use `Ctrl + Shift + F3` to enter Audit Mode when the you reach Setting screen
after reboot.

- `select volume <volume number>`: select the desired volume
- `detail volume`: check the selected volume
- `format fs=ntfs label="Home Dir" quick`
- `assign letter=E`

exit diskpart

- `C:`: cd to root of C drive
- `xcopy Users E: /s /e /f /b /h /x`
- `rmdir /s Users`
- `mkdir /s Users`

Enter diskpart

- `diskpart`: enter diskpart
- `select volume <volume number>`: select the desired volume
- `assign mount=C:\Users`
- `remove letter=E`: remove the letter assigned previously. (optional)
- `exit`: leave diskpart

Then you can using windows 10!!

## Links

- [[superuser] mount second drive as c users in wondows 7](http://superuser.com/questions/53029/mount-second-drive-as-c-users-in-windows-7)


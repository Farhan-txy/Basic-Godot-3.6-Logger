Universal Logger — Godot 3.6

Logger universal untuk Godot 3.5–3.6 yang dirancang untuk aplikasi, tool, dan editor.
Menggunakan pendekatan session-based, level-based, dan event-driven.

Fitur

Log level: DEBUG, INFO, WARN, ERROR, FATAL

Satu file log per sesi aplikasi

Append-only (tidak overwrite)

Autoload singleton

Live log UI melalui signal (opsional)

Tidak bergantung UI

Ringan dan kompatibel hardware lama

Struktur
res://
 ├─ Logger.gd
 └─ logs/
     └─ log_YYYY-MM-DD_HH-MM-SS.txt

Instalasi

Salin Logger.gd ke project

Buka Project Settings → AutoLoad

Tambahkan:

Name: Logger

Path: res://Logger.gd

Restart editor

Log Level

Urutan level:

DEBUG < INFO < WARN < ERROR < FATAL


Set level minimum:

Logger.min_level = Logger.LogLevel.INFO


Log di bawah level ini tidak ditulis.

API
Log biasa
Logger.debug("Parsing chunk", name)
Logger.info("Start conversion", name)
Logger.warn("Missing texture")
Logger.error("Failed to export")

Fatal error
Logger.fatal("Unsupported file format", name)
Logger.fatal("Critical failure", name, true)


Parameter true akan menghentikan aplikasi.

Format Log
[YYYY-MM-DD HH:MM:SS] [LEVEL] Message (Node: NodeName)


Contoh:

[2025-12-18 21:10:03] [INFO] Start conversion (Node: ConvertButton)

Session-based Logging

File log dibuat saat aplikasi mulai

Nama file berdasarkan timestamp

Setiap run menghasilkan file baru

Log lama tidak pernah dihapus atau ditimpa

Live Log UI (Opsional)

Logger mengirim event:

signal log_emitted(level, line)


UI dapat mendengarkan event ini tanpa mengubah logger.

Hotkey

Logger tidak menangani input.
Shortcut (F1, F2, dll) di-handle oleh UI atau main node.

Lokasi Log

Default (development):

res://logs/


Catatan:

res:// tidak writable setelah export

Untuk rilis gunakan user://logs/

Maintenance Notes

Jangan log di _process()

Jangan gunakan File.WRITE setelah file dibuat

Logger harus singleton (autoload)

Jangan recreate file di tengah sesi

Reusability

Logger dapat digunakan ulang dengan:

Copy Logger.gd

Set sebagai AutoLoad

Gunakan API yang sama

Tidak perlu perubahan kode.

Kompatibilitas

Godot 3.5.x – 3.6.x

OpenGL (GLES2/GLES3)

Windows / Linux

CPU tanpa SSE4.2

Ringkasan

Logger ini bersifat universal, ringan, dan mudah dirawat.
Dirancang untuk tool dan aplikasi, bukan khusus game.
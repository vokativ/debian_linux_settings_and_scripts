@ECHO OFF

CD "C:\Program Files\Calibre2\"
START /WAIT calibre
robocopy "C:\Users\neman\Calibre Library" "\\M_N_storage\home\Calibre Library" /e /purge /W:0 /R:1 /MT:12
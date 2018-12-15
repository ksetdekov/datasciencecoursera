library(googlesheets)
gs_ls()
head(gs_ls())
gsheets <- gs_ls()
gsheets$sheet_title
gsheets$sheet_title[1]
gs_title("Про пальцы (Ответы)")
fingers <- gs_title("Про пальцы (Ответы)")
gs_ws_ls(fingers)
resp <- gs_read(ss=fingers, ws = 1, skip=0)
View(resp)
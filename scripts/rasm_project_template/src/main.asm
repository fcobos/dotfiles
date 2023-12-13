; PROJECT_NAME

RELEASE_DSK    = 1
RELEASE_TAPE   = 1


  org #100

progBegin

progEnd

save"build/PROJECT_NAME.bin",progBegin,progEnd-progBegin

if RELEASE_DSK
save"PROJECT_NAME.bin",progBegin,progEnd-progBegin,DSK,"build/PROJECT_NAME.dsk"
endif

if RELEASE_TAPE
save"PROJECT_NAME.bin",progBegin,progEnd-progBegin,TAPE,"build/PROJECT_NAME.cdt"
endif

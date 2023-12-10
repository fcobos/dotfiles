; PROJECT_NAME

RELEASE_DSK    = 1
RELEASE_TAPE   = 1


  org #100


theEnd

save"build/PROJECT_NAME.bin",#100,theEnd-#100

if RELEASE_DSK
save"PROJECT_NAME.bin",#100,theEnd-#100,DSK,"build/PROJECT_NAME.dsk"
endif

if RELEASE_TAPE
save"PROJECT_NAME.bin",#100,theEnd-#100,TAPE,"build/PROJECT_NAME.cdt"
endif

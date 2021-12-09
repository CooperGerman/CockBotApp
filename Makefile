#
#         ██████╗ ██████╗  ██████╗██╗  ██╗██████╗  ██████╗ ████████╗
#        ██╔════╝██╔═══██╗██╔════╝██║ ██╔╝██╔══██╗██╔═══██╗╚══██╔══╝
#        ██║     ██║   ██║██║     █████╔╝ ██████╔╝██║   ██║   ██║
#        ██║     ██║   ██║██║     ██╔═██╗ ██╔══██╗██║   ██║   ██║
#        ╚██████╗╚██████╔╝╚██████╗██║  ██╗██████╔╝╚██████╔╝   ██║
#         ╚═════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝
# This File contains automation receipes for several actions related
# to building the CockBotApp.
# make help to see help

DATE:=$(shell date --iso-8601)

default: all

all : build

deploy: clean build push

push:
	rm -rf gitsubmodules/CooperGerman.github.io/*
	cp -r build/web/* gitsubmodules/CooperGerman.github.io
	cd gitsubmodules/CooperGerman.github.io ;\
	git checkout main ;\
	git add . ;\
	git commit -m "[\`DEPLOYMENT\`] : $(DATE) release" ;\
	git push origin main

build :
	flutter build web --web-renderer html

clean :
	flutter clean



THEME=hexo-theme-next

.PHONY: all theme init update

all: init update theme

init:
	npm install
	git submodule init

update:
	git submodule update --recursive

theme:
	cp theme_config.yml themes/$(THEME)/_config.yml

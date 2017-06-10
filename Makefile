THEME = hexo-theme-next
PUBLIC = public

.PHONY: all theme init update clean

all: init update theme

init:
	npm install
	git submodule init

update:
	git submodule update --recursive

theme:
	cp theme_config.yml themes/$(THEME)/_config.yml

clean:
	rm -rf $(PUBLIC)

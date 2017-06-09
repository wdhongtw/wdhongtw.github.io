THEME=hexo-theme-next

.PHONY: all theme

theme:
	mv theme_config.yml themes/$(THEME)/_config.yml

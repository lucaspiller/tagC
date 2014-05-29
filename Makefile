.PHONY: server dev

server:
	# npm install http-server -g
	http-server -p 4444 -c-1

dev:
	grunt && grunt watch

setup-ghpages:
	rm -Rf _deploy
	mkdir _deploy
	cd _deploy && git init && git remote add origin git@github.com:lucaspiller/tagC.git && git checkout -b gh-pages

publish: setup-ghpages
	rm -Rf _deploy/*
	cp -R lib _deploy
	cp style.css _deploy
	cp index.html _deploy
	cd _deploy && git add . && git add -u . && git commit -m "Updated `date`" && git push origin gh-pages --force

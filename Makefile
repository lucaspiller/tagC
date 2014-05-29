.PHONY: server dev

server:
	# npm install http-server -g
	http-server -p 4444 -c-1

dev:
	grunt && grunt watch

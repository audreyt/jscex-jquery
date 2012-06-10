all :: deps
	env PATH="$$PATH:./node_modules/LiveScript/bin" livescript -c -o . src

deps ::
	npm i

demo :: deps
	node example.js

test :: demo

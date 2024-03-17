run:
	npm run dev

build:
	npm run build
	npm run deploy

deploy: build
	git add ./dist -f
	git commit -m "update dist"
	git push origin $(shell git rev-parse --abbrev-ref HEAD)
	git subtree push --prefix dist origin gh-pages

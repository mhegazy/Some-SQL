#!/bin/bash
rm -rf dist/*.*
rm -rf *.d.ts
rm -rf docs

#type declerations
./node_modules/.bin/tsc --stripInternal -d --declarationDir "." -t "ES5" --rootDir "src"

#node build
export NODE_ENV=build && ./node_modules/.bin/webpack
cp dist/some-sql.min.js index.js

#browser build
export NODE_ENV=production && ./node_modules/.bin/webpack

#docs 
./node_modules/.bin/typedoc --out docs . --target ES5 --exclude memory-db.ts --excludeExternals --excludePrivate
touch docs/.nojekyll

#clean up
rm -rf src/*.js
mv dist/some-sql.min.js dist/some-sql.min.0.1.3.js
echo "$(cat dist/some-sql.min.0.1.3.js)" | gzip -9f | wc -c;
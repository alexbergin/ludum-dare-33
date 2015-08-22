# Ludum Dare 33
### Theme: You Are The Monster

## Setup
1. Install `Node`, `Grunt`, and `Bower`.
2. Clone the repo
3. Run `npm install`
4. Run `bower install`
5. Run `grunt start` to compile into `app/` and start browsersync.
6. Run `grunt build` to compile the project into `dist/` for deployment.

## Structure

Only files in `/src` should be edited; everything is compiled from there. Browsersync points to `app/` while developing and all js libraries are installed there under `app/scripts/vendor`.

## Tools

Mustache and JSON are compiled into HTML, Coffeescript into JavaScript, and Sass into CSS. Bower is used to manage client side libraries. RequireJS is used to load modules. THREEJS and CANNONJS are used for rendering and physics respectively.

## Notes

There's a weird thing with CANNONJS wanting to be loaded from `vendor/cannon.js/build/cannon.min.js` when minified that I haven't been able to figure out, so it's included in the build on its own.
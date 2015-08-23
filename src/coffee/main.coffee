require.config
	baseUrl: "scripts"

	paths:
		"CANNON": "vendor/cannon.js/build/cannon"
		"CannonDebugRenderer": "vendor/cannon.js/tools/threejs/CannonDebugRenderer"
		"classlist": "vendor/classlist/classList"
		"OBJLoader": "vendor/threejs/examples/js/loaders/OBJLoader"
		"requestAnimationFrame": "vendor/requestAnimationFrame/app/requestAnimationFrame"
		"requirejs": "vendor/requirejs/require"
		"THREE": "vendor/threejs/build/three"

	shim:

		"OBJLoader":
			deps: [ "THREE" ]

		"CannonDebugRenderer":
			deps: [ "CANNON" , "THREE" ]
		
require [ "site/boot" ] , ( App ) -> 
	window.site = new App()
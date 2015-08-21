define [

	"site/utilities/Material"

] , (

	Material

) ->

	class Combo extends Material

		src: =>

			colors = [
				0xffcccc
				0xfaffcc
				0xccffd7
				0xcce7ff
				0xf6ccff
			]

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: colors[ Math.floor( colors.length * Math.random()) ]
				specular: 0xFFFFFF
				shininess: 0.3
				transparent: true
				opacity: 1
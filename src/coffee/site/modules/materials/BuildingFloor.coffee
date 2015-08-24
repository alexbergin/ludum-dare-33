define [

	"site/utilities/Material"

] , (

	Material

) ->

	class BuildingFloor extends Material

		src: =>

			options = [
				0xDCE3E5
				0xD4DBDD
				0xD4DBDD
				0xCBD1D3
			]

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: options[ Math.floor( Math.random() * options.length )]
				transparent: true
				opacity: 1
				specular: 0xFFFFFF
				shininess: 0.3
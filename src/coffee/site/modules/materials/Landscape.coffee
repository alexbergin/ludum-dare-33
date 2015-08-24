define [

	"site/utilities/Material"

] , (

	Material

) ->

	class Landscape extends Material

		src: =>

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: 0xFFFBBF
				specular: 0xFFFFFF
				shininess: 0.3
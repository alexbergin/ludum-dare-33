define [

	"site/utilities/Material"

] , (

	Material

) ->

	class HotDog extends Material

		src: =>

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: 0xFFCDCD
				specular: 0xFFFFFF
				shininess: 0.3
define [

	"site/utilities/Material"

] , (

	Material

) ->

	class MonsterLeg extends Material

		src: =>

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: 0xcce7ff
				specular: 0xFFFFFF
				shininess: 0.3
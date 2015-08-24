define [

	"site/utilities/Material"

] , (

	Material

) ->

	class MonsterHead extends Material

		src: =>

			@.style = new THREE.MeshBasicMaterial
				shading: THREE.SmoothShading
				vertexColors: THREE.FaceColors
				color: 0x1f1c10
				specular: 0xFFFFFF
				shininess: 0.3
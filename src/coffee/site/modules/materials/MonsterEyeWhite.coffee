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
				color: 0xffffff
				specular: 0xFFFFFF
				shininess: 0.3
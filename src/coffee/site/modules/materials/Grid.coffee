define [

	"site/utilities/Material"

] , (

	Material

) ->

	class Grid extends Material

		src: =>

			@.style = new THREE.MeshBasicMaterial
				wireframe: true
				color: 0xffcccc
define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class Grid extends Model

		src: ->

			geometry = new THREE.PlaneGeometry 5000 , 5000 , 500 , 500
			material = new THREE.MeshBasicMaterial
				color: 0xFFFBED
			@.mesh = new THREE.Mesh geometry , material

			@.geometryReady()
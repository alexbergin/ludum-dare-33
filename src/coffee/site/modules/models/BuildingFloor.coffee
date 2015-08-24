define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class BuildingFloor extends Model

		src: ->

			geometry = new THREE.BoxGeometry( 10 , 3 , 10 )
			material = new THREE.MeshBasicMaterial
				color: 0xFFFBED
			@.mesh = new THREE.Mesh geometry , material

			@.geometryReady()
define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class MonsterLeg extends Model

		src: ->

			geometry = new THREE.CylinderGeometry 0.15 , 0.15 , 6.3 , 6
			material = new THREE.MeshBasicMaterial
				color: 0xFFFBED
			@.mesh = new THREE.Mesh geometry , material

			@.geometryReady()
define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class MonsterHead extends Model

		src: ->

			geometry = new THREE.SphereGeometry 3 , 9 , 9
			material = new THREE.MeshBasicMaterial
				color: 0xFFFBED
			@.mesh = new THREE.Mesh geometry , material

			@.geometryReady()
define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class Landscape extends Model

		src: ->

			geometry = new THREE.PlaneGeometry 300 , 300 , 1 , 1
			material = new THREE.MeshBasicMaterial
				color: 0xFFFBED
			@.mesh = new THREE.Mesh geometry , material

			@.geometryReady()
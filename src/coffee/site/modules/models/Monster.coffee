define [ 

	"site/utilities/Model"

] , (

	Model

) ->

	class Combo extends Model

		radius: 3
		height: 15

		src: ->

			material = @.entity.material.style
			parts = []

			# head
			geometry = new THREE.SphereGeometry @.radius , 16 , 16
			parts.push new THREE.Mesh geometry , material
			parts[0].position.y = ( @.radius ) / 2.25

			# body
			geometry = new THREE.CylinderGeometry @.radius , 0 , @.height - @.radius , 16 , 1 , false
			parts.push new THREE.Mesh geometry , material
			parts[1].position.y = -( @.height - @.radius ) / 2.25

			mesh = new THREE.Mesh new THREE.Geometry , material
			for part in parts
				mesh.geometry.mergeMesh part

			mesh.geometry.mergeVertices()

			@.mesh = mesh
			@.geometryReady()
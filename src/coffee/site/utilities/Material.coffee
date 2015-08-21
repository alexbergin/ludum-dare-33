define [

	"site/utilities/EntityProperty"

] , (

	EntityProperty

) ->

	class Materials extends EntityProperty

		init: ->

			# this is just a threejs material def for now,
			# want to eventually load in a .mat file
			@.src()

			# convert back to buffer geometry to make it faster
			@.entity.mesh?.geometry = new THREE.BufferGeometry().fromGeometry @.entity.mesh.geometry
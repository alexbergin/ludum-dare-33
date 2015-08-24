define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class BuildingFloor extends Collision

		prefs:

			mass: 0.6
			angularVelocity: 0.0
			angularDamping: 0.2
			linearDamping: 0.2
			material:
				friction: 0.75

		src: ->

			parts = []

			parts.push 
				shape: new CANNON.Box new CANNON.Vec3 5 , 1.5 , 5

			for part in parts
				@.body.addShape(
					part.shape, 
					part.offset, 
					part.quaternion
				)

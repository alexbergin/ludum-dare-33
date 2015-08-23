define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class MonsterHead extends Collision

		prefs:

			mass: 3
			angularVelocity: 0.0
			angularDamping: 1
			linearDamping: 0
			material:
				friction: 0

		src: ->

			parts = []

			parts.push 
				shape: new CANNON.Sphere 3

			for part in parts
				@.body.addShape(
					part.shape, 
					part.offset, 
					part.quaternion
				)

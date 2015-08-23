define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class MonsterHead extends Collision

		prefs:

			mass: 4
			angularVelocity: 0.0
			angularDamping: 0.9999999
			linearDamping: 0.01
			material:
				friction: 1

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

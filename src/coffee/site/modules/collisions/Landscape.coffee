define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class Landscape extends Collision

		prefs:

			mass: 0
			angularVelocity: 0.0
			angularDamping: 0.01
			linearDamping: 0.01
			material:
				friction: 0.1

		src: ->

			# gross but needed

			parts = []

			parts.push 
				shape: new CANNON.Plane()

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

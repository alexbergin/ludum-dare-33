define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class Landscape extends Collision

		prefs:

			mass: 0
			angularVelocity: 0.0
			angularDamping: 0.0
			linearDamping: 0.0
			material:
				friction: 0.25

		src: ->

			parts = []
			parts.push 
				shape: new CANNON.Plane()

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

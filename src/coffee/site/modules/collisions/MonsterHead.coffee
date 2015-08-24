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

			q = new Math.quaternion new CANNON.Vec3 Math.radians( 90 ) , 0 , 0

			parts.push 
				shape: new CANNON.Cylinder 3.3 , 4 , 3.5 , 8
				quaternion: q

			for part in parts
				@.body.addShape(
					part.shape, 
					part.offset, 
					part.quaternion
				)

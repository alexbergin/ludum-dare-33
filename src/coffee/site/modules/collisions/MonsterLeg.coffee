define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class MonsterLeg extends Collision

		prefs:

			mass: 0.25
			angularVelocity: 0.0
			angularDamping: 0.5
			linearDamping: 0.5
			material:
				friction: 0.5

		src: ->

			parts = []

			parts.push 
				shape: new CANNON.Cylinder 0.15 , 0.15 , 6 , 6
				quaternion: Math.quaternion new THREE.Euler Math.radians( -90 ) , 0 , 0

			for part in parts
				@.body.addShape(
					part.shape, 
					part.offset, 
					part.quaternion
				)

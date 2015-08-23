define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class MonsterLeg extends Collision

		prefs:

			mass: 0.25
			angularVelocity: 0.0
			angularDamping: 0.1
			linearDamping: 0.1
			material:
				friction: 0.35

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

define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class Monster extends Collision

		prefs:

			mass: 5
			angularVelocity: new CANNON.Quaternion 0 , 0 , 0 , 0
			angularDamping: 0.66
			linearDamping: 0.00
			material:
				friction: 0.0

		src: ->

			radius = @.entity.model.radius
			height = @.entity.model.height
			parts = []

			parts.push
				shape: new CANNON.Sphere radius
				offset: new CANNON.Vec3 0 , (( height - radius ) / 2 ) - (( height - radius ) / 2.25 ), 0

			rotation = new THREE.Quaternion()
			euler = new THREE.Euler Math.radians( -90 ) , 0 , 0
			rotation.setFromEuler euler

			parts.push
				shape: new CANNON.Cylinder radius , 0 , height - radius , 4
				offset: new CANNON.Vec3 0 , -(( height - radius ) / 2.25 ) , 0
				quaternion: rotation

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

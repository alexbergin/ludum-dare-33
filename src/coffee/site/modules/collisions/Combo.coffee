define [

	"site/utilities/Collision"

] , (

	Collision

) ->

	class Combo extends Collision

		prefs:

			mass: 4
			angularVelocity: new CANNON.Quaternion 0 , 0 , 0 , 0
			angularDamping: 0.01
			linearDamping: 0.01
			material:
				friction: 0.1

		src: ->

			s = @.entity.model.scale
			f = @.entity.model.formation
			c = @.entity.model.center

			console.log @.entity 

			parts = []

			i = 0
			while i < f.length
				o = f[i]
				parts.push 
					shape: new CANNON.Box new CANNON.Vec3 s/2 , s/2 , s/2
					offset: new CANNON.Vec3 o.x * s - c.x , o.y * s - c.y , 0
				i++

			for part in parts
				@.body.addShape part.shape , part.offset , part.quaternion

			@.body.computeAABB()

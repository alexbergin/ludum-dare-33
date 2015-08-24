define [

	"site/utilities/EntityProperty"

] , (

	EntityProperty

) ->

	class Collision extends EntityProperty

		init: ->

			# setup the body based on prefs
			@.body = new CANNON.Body

				mass: @.prefs.mass or 0
				angularDamping: @.prefs.angularDamping or 0.01
				linearDamping: @.prefs.linearDamping or 0.01
				material: @.prefs.material

			@.setup() 

		setup: ->

			# set the initial body position
			position = @.entity.position
			vertices = [ "x" , "y" , "z" ]
			for vertex in vertices
				@.body.position[ vertex ] = @.entity.position[ vertex ]

			# set the initial body rotation
			rotation = @.entity.rotation
			q = new THREE.Quaternion()
			euler = new THREE.Euler rotation.x , rotation.y , rotation.z
			q.setFromEuler euler
			@.body.quaternion.set q._x , q._y , q._z , q._w

			# only do geometric collisions for now
			# because i'm hella lazy
			@.src()

			# add the body definition to the world
			@.entity.root.world.add @.body

		loop: ->

			# sync the positioning of the threejs object with the cannon object
			if @.entity.model.mesh? and @.body? and @.unlocked isnt true

				# vectors/props we loop through
				vectors = [ "position" , "quaternion" ]
				props = [ "x" , "y" , "z" , "w" ]
				
				for vector in vectors
					for prop in props

						# three value = cannon values
						if @.entity.model.mesh[vector][ prop ]?
							@.entity.model.mesh[vector][ prop ] = @.body[vector][ prop ]

		destroy: ->

			@.entity.root.world.remove @.body
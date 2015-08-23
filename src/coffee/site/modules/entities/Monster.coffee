define [

	"site/utilities/Entity"
	"site/modules/models/Monster"
	"site/modules/collisions/Monster"
	"site/modules/materials/Monster"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class Monster extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @
			@.canJump = true
			@.onGround = true

		loop: ( left , right , up ) ->

			@.left = left
			@.right = right
			@.up = @.jump up

			@.collision?.loop()
			@.restrictRotation()
			@.restrictPosition()
			@.checkGround()
			@.applyInput()

		jump: ( attempt ) ->

			if @.canJump and attempt and @.onGround
				@.canJump = false
				setTimeout =>
					@.canJump = true
				, 500

				return true
			else
				return false

		restrictRotation: ->

			verticies = [ "x" , "y" ]
			for vertex in verticies
				@.collision.body.invInertia[ vertex ] = 0
				@.collision.body.inertia[ vertex ] = 0

		restrictPosition: ->
			verticies = [ "z" ]
			for vertex in verticies
				@.collision.body.velocity[ vertex ] = 0
				@.collision.body.position[ vertex ] = 0

		checkGround: ->

			@.onGround = @.root.world.colliding(
				@.root.test.landscape.collision.body, 
				@.collision.body
			)

		applyInput: ->

			xvel = 0
			yvel = 0

			if @.left then xvel += 4
			if @.right then xvel -= 4

			p = @.collision.body.position

			applyAt = new CANNON.Vec3 p.x , p.y - 150 , p.z

			if @.up
				@.up = false
				yvel += 1000

			if @.onGround is false
				xvel *= 0.75
			else
				bottomForce = new CANNON.Vec3 3 * xvel , yvel , 0
				@.collision.body.applyForce bottomForce , @.collision.body.position

			topForce = new CANNON.Vec3 xvel , yvel , 0
			@.collision.body.applyForce topForce , applyAt
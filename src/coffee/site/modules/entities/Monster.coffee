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

		loop: ( left , right ) ->

			@.left = left
			@.right = right

			@.collision?.loop()
			@.restrictRotation()
			@.restrictPosition()
			@.applyInput()

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


		applyInput: ->

			velocity = 0
			if @.left then velocity += 2
			if @.right then velocity -= 2

			p = @.collision.body.position

			applyAt = new CANNON.Vec3 p.x , p.y - 150 , p.z

			topForce = new CANNON.Vec3 velocity , 0 , 0
			bottomForce = new CANNON.Vec3 3 * velocity , 0 , 0

			@.collision.body.applyForce topForce , applyAt
			@.collision.body.applyForce bottomForce , @.collision.body.position
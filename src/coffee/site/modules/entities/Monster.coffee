define [

	"site/utilities/SubClass"
	"site/modules/entities/MonsterHead"
	"site/modules/entities/MonsterLeg"

] , (

	SubClass
	MonsterHead
	MonsterLeg

) ->

	class Monster extends SubClass

		preferences:
			power: 2

		init: ->

			@.build()
			@.assemble()
			@.addListeners()

		addListeners: ->

			@.motor =
				q: false
				w: false
				o: false
				p: false

			window.addEventListener "keydown" , @.onKeyDown
			window.addEventListener "keyup" , @.onKeyUp

		onKeyUp: ( e ) =>

			switch e.keyCode

				when 81 then @.motor.q = false
				when 87 then @.motor.w = false
				when 79 then @.motor.o = false
				when 80 then @.motor.p = false

				when 82 then @.reset()

		onKeyDown: ( e ) =>

			switch e.keyCode

				when 81 then @.motor.q = true
				when 87 then @.motor.w = true
				when 79 then @.motor.o = true
				when 80 then @.motor.p = true

		build: ->

			@.head = new MonsterHead @.root,
				position: 
					y: 15

			@.legs = []
			i = 0
			n = 8
			while i < n

				slice = ( 360 / n )
				angle = Math.radians(( 0.5 * slice ) + ( slice * i ))
				
				x = Math.cos( angle )
				z = Math.sin( angle )

				top =
					position:
						x: x * 6
						y: 18
						z: z * 6

				bottom =
					position:
						x: x * 12
						y: 18
						z: z * 12

				leg = 
					top: new MonsterLeg @.root , top
					bottom: new MonsterLeg @.root , bottom

				i++

				@.legs.push leg

		assemble: ->

			i = 0
			world = @.root.root.world.w

			for leg in @.legs

				slice = ( 360 / @.legs.length )
				angle = Math.radians(( 0.5 * slice ) + ( slice * i ))

				x = Math.sin( angle )
				z = Math.cos( angle )

				n = Math.sin( Math.radians( Math.degrees( angle ) + 90 ))
				m = Math.cos( Math.radians( Math.degrees( angle ) + 90 ))

				options =
					collideConnected: true
					pivotA: new CANNON.Vec3 0 , 3.05 , 0
					axisA:  new CANNON.Vec3 n , 0 , m
					pivotB: new CANNON.Vec3 x * 3.15 , 0 , z * 3.15
					axisB:  new CANNON.Vec3 n , 0 , m

				@["thigh#{i}"] = new CANNON.HingeConstraint(
					leg.top.collision.body
					@.head.collision.body
					options
				)

				world.addConstraint @["thigh#{i}"]

				options =
					collideConnected: true
					pivotA: new CANNON.Vec3( 0 , 3.0 , 0 )
					axisA:  new CANNON.Vec3( 0 , 1 , 0 )
					pivotB: new CANNON.Vec3( 0 , -3.0 , 0 )
					axisB:  new CANNON.Vec3( 0 , 1 , 0 )
					twistAngle:  Math.radians( 90 )
					angle:  Math.radians( 5 )

				@["shin#{i}"] = new CANNON.ConeTwistConstraint(
					leg.bottom.collision.body
					leg.top.collision.body
					options
				)

				world.addConstraint @["shin#{i}"]

				i++

		reset: =>

			@.score = Math.abs( @.head.collision.body.position.x )
			console.log "score: #{@.score}"


		loop: ->

			@.head.loop()

			for leg in @.legs
				leg.bottom.loop()
				leg.top.loop()

			@.power()
			@.camera()
			@.collision()

		collision: ->

			test = @.root.root.world.colliding
			land = @.root.landscape.collision.body
			head = @.head.collision.body

			if test( head , land ) then @.reset() 

		power: ->

			fCodes = [ "p" , "q" ]
			rCodes = [ "o" , "w" ]

			@.head.collision.body.position.z = 0
			@.head.collision.body.velocity.z = 0

			i = 0
			while i < @.legs.length

				code = Math.floor(( i / @.legs.length ) * 2 )

				joint = @["thigh#{i}"]
				bottom = @["shin#{i}"]

				if @.log is undefined
					@.log = true
					console.log bottom

				forwardPowered = @.motor[fCodes[ code ]]
				backwardsPowered = @.motor[rCodes[ code ]]

				v = 0
				if forwardPowered
					v = @.preferences.power
					bottom.angle = Math.radians( 5 )

				if backwardsPowered
					v = -@.preferences.power * 0.75
					bottom.angle = Math.radians( 90 )

				if forwardPowered or backwardsPowered
					joint.enableMotor()
				else
					joint.disableMotor()
					bottom.angle = Math.radians( 5 )

				joint.setMotorSpeed v

				i++

		camera: ->

			camera = @.root.root.camera
			light = @.root.root.light.light
			monster = @.head.model.mesh

			camera.facing = 
				x: monster.position.x
				y: 5
				z: monster.position.z

			yAngle = monster.rotation.y

			x = monster.position.x + Math.sin( yAngle ) * 20
			z = monster.position.z + Math.cos( yAngle ) * 20

			camera.anchor.x = x
			camera.anchor.z = z

			@.root.landscape.position.x = x
			@.root.landscape.position.z = z

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

		init: ->

			@.build()
			@.assemble()

			@.power = 2
			setInterval =>
				@.motor()
				setTimeout =>
					@.motor()
				, 350
			, 3000


		build: ->

			@.head = new MonsterHead @.root,
				position: 
					y: 15

			@.legs = []
			i = 0
			while i < 4

				angle = Math.radians( -45 + ( 90 * i ))
				
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
				angle = Math.radians( -( 0.5 * slice ) + ( slice * i ))

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
					twistAngle:  Math.radians( 5 )
					angle:  Math.radians( 5 )

				@["shin#{i}"] = new CANNON.ConeTwistConstraint(
					leg.bottom.collision.body
					leg.top.collision.body
					options
				)

				world.addConstraint @["shin#{i}"]

				i++

		loop: ->

			@.head.loop()

			for leg in @.legs
				leg.bottom.loop()
				leg.top.loop()

		motor: ->

			i = 0
			while i < @.legs.length

				slice = ( 360 / @.legs.length )
				angle = Math.radians( -( 0.5 * slice ) + ( slice * i ))


				joint = @["thigh#{i}"]
				v = @.power

				if v > 0
					joint.enableMotor()
					joint.setMotorSpeed v
				else
					joint.disableMotor()

				i++

			@.power = -@.power
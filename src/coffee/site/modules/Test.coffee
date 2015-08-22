define [

	"site/utilities/SubClass"
	"site/modules/entities/Landscape"
	"site/modules/entities/Monster"

] , (

	SubClass
	Landscape
	Monster

) ->

	class Test extends SubClass

		leftA: false
		rightA: false
		leftB: false
		rightB: false

		init: ->

			# listen for input
			@.addListeners()

			# generate the landscape
			@.landscape = new Landscape @ ,
				position:
					x: 0 , y: -10 , z: 0
				rotation:
					x: Math.radians( -90 ) , y: 0 , z: 0

			# pass the entity the root context so it can
			# access the stage + cannon world
			@.monsterA = new Monster @ , 
				position:
					x: -15
					y: 2

			@.monsterB = new Monster @ , 
				position:
					x: 15
					y: 2

			# make the monsters bouncy
			monsterBounce = new CANNON.ContactMaterial(
				@.monsterA.collision.body.material,
				@.monsterB.collision.body.material,
				{ friction: 0.001 , restitution: 0.9 }
			)
			@.root.world.w.addContactMaterial monsterBounce

			@.state()

		loop: ->

			# update each entity by calling its loop
			@.monsterA.loop @.leftA , @.rightA
			@.monsterB.loop @.leftB , @.rightB
			@.state()
			@.camera()

		addListeners: ->

			window.addEventListener "keydown" , @.onDown
			window.addEventListener "keyup" , @.onUp

		onDown: ( e ) =>

			switch e.keyCode
				when 65 then @.leftA = true
				when 68 then @.rightA = true
				when 37 then @.leftB = true
				when 39 then @.rightB = true

		onUp: ( e ) =>

			switch e.keyCode
				when 65 then @.leftA = false
				when 68 then @.rightA = false
				when 37 then @.leftB = false
				when 39 then @.rightB = false

		state: ->

			monsters = [ @.monsterA , @.monsterB ]

			for monster in monsters

				vertical = monster.model.mesh.position.y
				rotation = Math.degrees( monster.model.mesh.rotation.z ) + 90

				while rotation > 360
					rotion -= 360

				while rotation < 0
					rotation += 360

				if rotation > 165 or rotation < 15
					@.killed monster

		camera: ->

			mAx = @.monsterA.model.mesh.position.x
			mBx = @.monsterB.model.mesh.position.x

			x = ( mAx + mBx ) / 2
			distance = Math.abs( mAx - mBx ) * 1.6666
			z = Math.constrain( distance , 70 , 300 )

			@.root.camera.facing.x = x
			@.root.camera.anchor.x = x
			@.root.camera.anchor.z = z

		killed: ( monster ) ->
			
			if monster is @.monsterA
				console.log "Monster B Wins!"
			else
				console.log "Monster A Wins!"

			monsters = [ @.monsterA , @.monsterB ]
			vertices = [ "x" , "y" , "z" ]

			for monster in monsters

				for vertex in vertices
					monster.collision.body.inertia[ vertex ] = 0
					monster.collision.body.angularVelocity[ vertex ] = 0
					monster.collision.body.invInertia[ vertex ] = 0
					monster.collision.body.velocity[ vertex ] = 0
					monster.collision.body.force[ vertex ] = 0

				monster.collision.body.quaternion.set 0 , 0 , 0 , 1

			@.monsterA.collision.body.position.set -15 , 2 , 0
			@.monsterB.collision.body.position.set 15 , 2 , 0



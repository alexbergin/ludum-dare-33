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
					x: -10
					y: 5
				rotation:
					z: Math.radians( Math.random() - 0.5 )

			@.monsterB = new Monster @ , 
				position:
					x: 10
					y: 5
				rotation:
					z: Math.radians( Math.random() - 0.5 )

		loop: ->

			# update each entity by calling its loop
			@.monsterA.loop @.leftA , @.rightA
			@.monsterB.loop @.leftB , @.rightB
			# @.camera()

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

		camera: ->

			mAx = @.monsterA.model.mesh.position.x
			mBx = @.monsterB.model.mesh.position.x

			x = ( mAx + mBx ) / 2
			distance = Math.abs( mAx - mBx ) * 1.5
			z = Math.constrain( distance , 60 , 250 )

			@.root.camera.facing.x = x
			@.root.camera.anchor.x = x
			@.root.camera.anchor.z = z
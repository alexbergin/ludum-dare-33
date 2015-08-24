define [

	"site/utilities/SubClass"
	"site/modules/entities/BuildingFloor"
	"site/modules/effects/Poof"

] , (

	SubClass
	BuildingFloor
	Poof

) ->

	class Building extends SubClass

		init: ( options ) ->

			@.prefs options
			@.place()

		prefs: ( o ) ->

			@.options =
				height: o.height or 5 + Math.floor( Math.random() * 9 )
				x: o.x or 0
				z: o.z or Math.random() * 3 - 1.5

			@.startingZ = @.options.z

		place: ->

			@.floors = []

			i = 0
			while i < @.options.height

				floor = new BuildingFloor @.root,
					position:
						x: @.options.x
						y: 0.5 + i * 3.5
						z: @.options.z

				floor.beenTouched = false
				floor.onGround = false

				@.floors.push floor

				i++

		loop: ->

			i = @.floors.length - 1
			while i >= 0
				floor = @.floors[i]
				floor.loop()
				@.canDestroy floor , i
				i--

			@.canReBuild()

		canReBuild: ->

			@.totalBroken = 0
			allBroken = true
			for floor in @.floors
				if floor.destroyed isnt true
					allBroken = false
				else
					@.totalBroken++
			if allBroken then @.reBuild()

		reBuild: ->

			if @.pointDisabled isnt true
				@.root.root.interface.score++
			else
				@.pointDisabled = false

			monster = @.root.root.game.monster
			moving = monster.head.collision.body.velocity.x

			if moving >= 0 then mult = 1 else mult = -1

			x = monster.head.collision.body.position.x + ( 40 * mult )

			@.prefs( x: x )
			@.place()

		canDestroy: ( floor , i ) ->

			test = @.root.root.world.colliding

			ground = @.root.root.game.landscape.collision.body
			part = floor.collision.body
			monster = @.root.root.game.monster
			legs = monster.legs

			if test( ground , part ) isnt false
				floor.onGround = true
			else
				if floor.beenTouched isnt true
					floor.onGround = false

			for leg in legs
				bottom = leg.bottom.collision.body
				if test( bottom , part ) isnt false
					floor.beenTouched = true

			if floor.position.z > @.startingZ + 0.1 or floor.position.z < @.startingZ - 0.1
				floor.beenTouched = true

			if Math.abs( floor.position.x - monster.head.collision.body.position.x ) > 60
				floor.onGround = floor.beenTouched = true
				@.pointDisabled = true

			if i is 0 and @.totalBroken is 0
				return
			else
				if floor.onGround and floor.beenTouched and floor.destroyed isnt true
					new Poof @.root.root , 0x9f9c9a , part.position
					floor.destroyed = true
					floor.destroy()

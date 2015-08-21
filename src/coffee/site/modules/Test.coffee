define [

	"site/utilities/SubClass"
	"site/modules/entities/Landscape"
	"site/modules/entities/Combo"
	"site/modules/effects/Poof"

] , (

	SubClass
	Landscape
	Combo
	Poof

) ->

	class Test extends SubClass

		combos: []

		init: ->

			# generate the landscape
			@.landscape = new Landscape @ ,
				position:
					x: 0 , y: -10 , z: 0
				rotation:
					x: Math.radians( -90 ) , y: 0 , z: 0

			# pass the entity the root context so it can
			# access the stage + cannon world
			setInterval =>
				@.makeCombo()
			, 350

			# create the first dog
			@.makeCombo()

		makeCombo: ->

			# limit the number of total dogs
			while @.combos.length >= 5
				combo = @.combos[ 0 ]
				color = combo.material.color
				position = combo.model.mesh.position
				velocity = combo.collision.body.velocity

				new Poof @.root , color , position , velocity
				combo.destroy()
				@.combos.shift()

			# create the new dog
			combo = new Combo @ ,

				position:
					x: 0 , y: 15 , z: 0

				rotation:
					x: Math.radians( Math.random() * 360 )
					y: Math.radians( Math.random() * 360 )
					z: Math.radians( Math.random() * 360 )

			# store it so we can delete it later
			@.combos.push combo

		loop: ->

			# update each entity by calling its loop
			for combo in @.combos
				combo.loop()
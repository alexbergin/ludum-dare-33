define [

	"site/utilities/SubClass"
	"site/modules/entities/Landscape"
	"site/modules/entities/HotDog"

] , (

	SubClass
	Landscape
	HotDog

) ->

	class Test extends SubClass

		dogs: []

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
				@.makeDog()
			, 250

			# create the first dog
			@.makeDog()

		makeDog: ->

			# limit the number of total dogs
			while @.dogs.length >= 100
				@.dogs[ 0 ].destroy()
				@.dogs.shift()

			# create the new dog
			dog = new HotDog @ ,

				position:
					x: 0 , y: 15 , z: 0

				rotation:
					x: Math.radians( Math.random() * 360 )
					y: Math.radians( Math.random() * 360 )
					z: Math.radians( Math.random() * 360 )

			# store it so we can delete it later
			@.dogs.push dog

		loop: ->

			# update each entity by calling its loop
			for dog in @.dogs
				dog.loop()
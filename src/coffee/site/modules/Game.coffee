define [

	"site/utilities/SubClass"
	"site/modules/entities/Landscape"
	"site/modules/entities/Monster"

] , (

	SubClass
	Landscape
	Monster

) ->

	class Game extends SubClass

		init: ->

			# generate the landscape
			@.landscape = new Landscape @ ,
				position:
					x: 0 , y: 0 , z: 0
				rotation:
					x: Math.radians( -90 ) , y: 0 , z: 0

			# make the monster
			@.monster = new Monster @

		loop: ->

			@.monster.loop()
define [

	"site/utilities/SubClass"
	"site/modules/entities/Landscape"
	"site/modules/entities/Monster"
	"site/modules/entities/Building"

] , (

	SubClass
	Landscape
	Monster
	Building

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

			@.building = new Building @ ,
				x: -25
		loop: ->

			@.monster.loop()
			@.building.loop()
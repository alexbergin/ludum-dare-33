define [

	"site/utilities/Entity"
	"site/modules/models/MonsterLeg"
	"site/modules/collisions/MonsterLeg"
	"site/modules/materials/MonsterLeg"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class MonsterLeg extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
define [

	"site/utilities/Entity"
	"site/modules/models/MonsterLegLower"
	"site/modules/collisions/MonsterLeg"
	"site/modules/materials/MonsterLeg"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class MonsterLegLower extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
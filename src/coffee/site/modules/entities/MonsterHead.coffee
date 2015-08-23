define [

	"site/utilities/Entity"
	"site/modules/models/MonsterHead"
	"site/modules/collisions/MonsterHead"
	"site/modules/materials/MonsterHead"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class MonsterHead extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
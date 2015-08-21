define [

	"site/utilities/Entity"
	"site/modules/models/Combo"
	"site/modules/collisions/Combo"
	"site/modules/materials/Combo"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class Combo extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @


		loop: ->

			@.collision?.loop()
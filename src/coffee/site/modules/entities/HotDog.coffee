define [

	"site/utilities/Entity"
	"site/modules/models/HotDog"
	"site/modules/collisions/HotDog"
	"site/modules/materials/HotDog"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class HotDog extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
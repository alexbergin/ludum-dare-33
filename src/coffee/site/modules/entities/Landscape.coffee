define [

	"site/utilities/Entity"
	"site/modules/models/Landscape"
	"site/modules/collisions/Landscape"
	"site/modules/materials/Landscape"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class Landscape extends Entity

		unlocked: true

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
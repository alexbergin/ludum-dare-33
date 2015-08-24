define [

	"site/utilities/Entity"
	"site/modules/models/BuildingFloor"
	"site/modules/collisions/BuildingFloor"
	"site/modules/materials/BuildingFloor"

] , (

	Entity
	Model
	Collision
	Material

) ->

	class BuildingFloor extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
			@.collision = new Collision @

		loop: ->

			@.collision?.loop()
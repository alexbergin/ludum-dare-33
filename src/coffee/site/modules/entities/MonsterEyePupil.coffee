define [

	"site/utilities/Entity"
	"site/modules/models/MonsterEyePupil"
	"site/modules/materials/MonsterEyePupil"

] , (

	Entity
	Model
	Material

) ->

	class MonsterEyePupil extends Entity

		init: ->

			# set up properties and pass the context
			@.material = new Material @
			@.model = new Model @
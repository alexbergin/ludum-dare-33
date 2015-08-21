define ->

	class EntityProperty

		constructor: ( entity ) ->

			# save the entity's context
			@.entity = entity

			# setup the rest of the class
			@.init?()
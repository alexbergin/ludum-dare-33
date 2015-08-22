define ->

	class Poof

		options:
			scaleMin: 0.2
			scaleMax: 0.75
			minVel: -0.05
			maxVel: 0.05
			lifeMin: 250
			lifeMax: 500
			countMin: 30
			countMax: 60

		constructor: ( root , color , position , velocity ) ->

			p = position
			v = velocity
			o = @.options
			c = Math.floor( Math.randomBetween( o.countMin , o.countMax ))
			i = 0

			while i < c

				life = Math.randomBetween o.lifeMin , o.lifeMax
				scale = Math.randomBetween o.scaleMin , o.scaleMax

				options =
					color: 0xE1E4EA
					scale: scale
					life: life
					position: 
						x: position.x + Math.randomBetween o.minVel , o.maxVel
						y: position.y + Math.randomBetween o.minVel , o.maxVel
						z: position.z + Math.randomBetween o.minVel , o.maxVel
					velocity: 
						x: ( v.x * 0.02 ) + 2 * Math.randomBetween o.minVel , o.maxVel
						y: ( v.y * 0.02 ) + Math.randomBetween o.minVel , o.maxVel
						z: ( v.z * 0.02 ) + 2 * Math.randomBetween o.minVel , o.maxVel
					gravity:
						x: 0 , y: 0.01 , z: 0

				root.particles.create options
				i++

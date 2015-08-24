define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Interface extends SubClass

		init: ->

			@.score = 0
			@.getElements()
			@.addListeners()
			@.onResize()

		getElements: ->

			@.canvas = document.createElement "canvas"
			@.canvas.setAttribute "class" , "interface"
			document.querySelector( "main" ).appendChild @.canvas
			@.ctx = @.canvas.getContext "2d"

		addListeners: ->

			window.addEventListener "resize" , @.onResize

		onResize: =>

			@.canvas.setAttribute "width" , @.root.width * @.root.scale
			@.canvas.setAttribute "height" , @.root.height * @.root.scale

			@.canvas.style.width = "#{@.root.width * @.root.scale}px"
			@.canvas.style.height = "#{@.root.height * @.root.scale}px"

		loop: ->

			@.clear()
			@.render()

		clear: ->
			@.ctx.clearRect 0 , 0 , @.root.width * @.root.scale , @.root.height * @.root.scale

		render: ->

			fontSize = 64 # Math.floor( window.innerHeight / 30 )

			@.ctx.imageSmoothingEnabled= false
			@.ctx.font = "#{fontSize}px uni0553"
			@.ctx.fillStyle = "black"
			@.ctx.textAlign = "center"

			width = @.root.width * @.root.scale
			height = @.root.height * @.root.scale

			@.ctx.fillText( @.score.toString() , Math.floor( width / 2 ), height - fontSize )
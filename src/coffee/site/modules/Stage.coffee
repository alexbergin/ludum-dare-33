define [

	"site/utilities/SubClass"

] , (

	SubClass

) ->

	class Stage extends SubClass

		# renderer preferences
		prefs:
			clearColor: 0xF7FDFF

		init: ->

			# setup tasks
			@.getElements()
			@.addListeners()
			@.build()
			@.onResize()

		getElements: ->

			# save the page element for later
			@.page = document.querySelector "main"

		addListeners: ->

			# resize the renderer to always match the window
			window.addEventListener "resize" , @.onResize

		build: ->

			# create the THREE elements
			@.scene = new THREE.Scene()
			@.renderer = new THREE.WebGLRenderer()

			# set renderer preferences
			@.renderer.setClearColor @.prefs.clearColor
			@.renderer.shadowMapEnabled = true
			@.renderer.shadowMapType = THREE.PCFShadowMap

			# append to the page
			@.renderer.domElement.classList.add "stage"
			@.page.appendChild @.renderer.domElement

		onResize: =>

			# scale we're set at
			scale = 4

			# get the width + height
			@.root.height = window.innerHeight / scale
			@.root.width = window.innerWidth / scale

			# resize the renderer
			@.renderer.setSize @.root.width , @.root.height

		loop: ->

			# render the scene to the canvas
			@.renderer.render @.scene , @.root.camera.main

		# adds an obj + mesh to scene
		add: ( obj ) => @.scene.add obj

		# removes an obj + mesh from scene
		remove: ( obj ) =>
			obj.geometry.dispose()
			obj.material.dispose()
			@.scene.remove obj

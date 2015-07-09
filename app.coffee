
class Material extends Layer
	constructor: (opts={}) ->
		opts.elevation ?= 0

		super opts
	
	@define "elevation",
		get: -> @_elevation
		set: (value) ->
			# alert if out of Material elevation range
			if value > 24 or value < 0
				throw Error "Elevation must be between 0–24. See https://www.google.com/design/spec/what-is-material/elevation-shadows.html#elevation-shadows-elevation-android-"
			
			# make sure we don't clip our shadows
			@clip = false

			# create shadows if they don't exist
			unless @_shadow1
				# TODO: this is a hack because `Layer#_subLayers`
				# is set after construction
				@_subLayers = []

				@_shadow1 = new Layer
					name: "shadow1"
					superLayer: @
					width: @width
					height: @height
					borderRadius: @borderRadius
					backgroundColor: "transparent"
					
				@_shadow2 = @_shadow1.copy()
				@_shadow2.name = "shadow2"
				@_shadow2.superLayer = @

			@_elevation = value
			
			@_shadow1.shadowY = value
			@_shadow1.shadowBlur = value
			@_shadow1.shadowColor = "rgba(0,0,0,0.24)"
			
			@_shadow2.shadowY = value / 2
			@_shadow2.shadowBlur = value / 2
			@_shadow2.shadowColor = """rgba(
				0,0,0,
				#{Utils.modulate value, [1, 24], [0, 0.24], true }
			)"""

	# Add `Material` properties to other classes
	@mixin = (ClassName) ->
		ClassName.define "elevation",
			get: @::getElevation
			set: @::setElevation

module?.exports = Material

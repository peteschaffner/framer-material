
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

			# create shadows if they don't exist
			unless @_shadow1
				# make sure we don't clip our shadows
				@clip = false

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

# {Material} = require "myModule"
#
Material.mixin Layer
# new Material elevation: 2

# Remove framer cursor
document.body.style.cursor = "auto"

# Variables
rows = 24
gutter = 10
width  = 400
height = 100

# Create background
new BackgroundLayer backgroundColor: "#eee"

# Create scrolling container for material
scroll = new ScrollComponent
	width: Screen.width, height: Screen.height
	contentInset: top: 150, bottom: 150
	scrollHorizontal: false
	mouseWheelEnabled: true

# Loop to create layers
for index in [0...rows]
	elevation = index + 1

	card = new Layer
		superLayer: scroll.content
		width:  width
		height: height 
		y: index * (height + gutter + index)
		borderRadius: 3
		backgroundColor: "#fafafa"
		elevation: elevation
	
	card.centerX()
	Utils.labelLayer card, elevation,
		color: "rgba(0,0,0,0.54)"
		fontSize: "14px"

# FAB (Floating Action Button)
fab = new Layer
	x: 24
	y: 24
	width: 56
	height: 56
	borderRadius: 56
	backgroundColor: "#FF4081"
	elevation: 6

fab.on Events.TouchStart, ->
	@animate
		properties: elevation: 24
		curve: "cubic-bezier(0.4, 0, 0.2, 1)"
		time: 0.2

fab.on Events.TouchEnd, ->
	@animate
		properties: elevation: 6
		curve: "cubic-bezier(0.4, 0, 0.2, 1)"
		time: 0.3
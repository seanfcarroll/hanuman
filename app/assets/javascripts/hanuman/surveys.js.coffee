# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # instantiate the bloodhound suggestion engine
  colors = new Bloodhound(
    datumTokenizer: (d) ->
      Bloodhound.tokenizers.whitespace d.color

    queryTokenizer: Bloodhound.tokenizers.whitespace
    local: [
      {
        color: "white"
      }
      {
        color: "red"
      }
      {
        color: "blue"
      }
      {
        color: "green"
      }
      {
        color: "yellow"
      }
      {
        color: "brown"
      }
      {
        color: "black"
      }
    ]
  )

  # initialize the bloodhound suggestion engine
  colors.initialize()

  # instantiate the typeahead UI
  $(".typeahead").typeahead null,
    displayKey: "color"
    source: colors.ttAdapter()
$ ->
  #
    # Make sure older browsers support the HTML5 Placeholder Attribute
    unless "placeholder" of document.createElement("input")
      $("input[placeholder]").each ->
        val = $(this).attr("placeholder")
        @value = val  if @value is ""
        $(this).focus(->
          @value = ""  if @value is val
        ).blur ->
          @value = val  if $.trim(@value) is ""

    # Clear default placeholder values on form submit
    $("form").submit ->
      $(this).find("input[placeholder]").each ->
        @value = ""  if @value is $(this).attr("placeholder")

    $(window).stellar

    headerHeight = $(window).height()
    navHeight = $("#nav").height()
    $(".intro-header").height(headerHeight)
    offset = if $("body.home").length > 0 then (headerHeight - navHeight) else 0

    nav = $('#nav').waypoint 'sticky',
            offset: -(offset)

    $(window).resize ->
      headerHeight = $(window).height()
      $(".site-header").height(headerHeight)


   $(".site-nav__navicon-button").click (e) ->
     e.preventDefault()
     $this = $(this)
     linkList = $this.next()
     $this.toggleClass("open")
     linkList.toggleClass("open")

  $(".work-teasers").mixItUp()

  $(".work-images > a").magnificPopup
    type: 'image'

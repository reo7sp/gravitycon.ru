window.addEventListener "load", ->
	items = document.querySelectorAll(".fractions-panel__item")
	form = document.querySelector(".fancy-form")
	formInitialDisplay = form.style.display
	form.style.display = "none"
	for item in items
		item.addEventListener "click", (e) ->
			className = e.target.className
			fractionName = className.substr(className.lastIndexOf('-') + 1)
			form.style.display = formInitialDisplay
			form.querySelector("input[name='fraction']").value = fractionName
			document.querySelector(".fractions-panel").style.display = "none"
			return
		continue
	return

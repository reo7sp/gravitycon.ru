gulp     = require "gulp"
plugins  = require("gulp-load-plugins")()

version  = 3

srcCss   = [ "blocks/**/*.less", "basic/*.less", "lib/**/*.css" ]
srcJs    = [ "blocks/**/*.coffee", "basic/*.coffee" ]
srcHtml  = "*.html"
srcImg   = "img/**"
srcOther = [ "*.php", "*.ico", "*.txt" ]
dst      = "bin"

gulp.task "css", ->
	gulp.src srcCss
		.pipe plugins.plumber()
		.pipe plugins.cached "css"
		.pipe plugins.less()
		.pipe plugins.autoprefixer()
		.pipe plugins.minifyCss()
		.pipe plugins.remember "css"
		.pipe plugins.concat "style-v#{ version }.css"
		.pipe gulp.dest dst
		.pipe plugins.livereload()

gulp.task "js", ->
	gulp.src srcJs
		.pipe plugins.plumber()
		.pipe plugins.cached "js"
		.pipe plugins.coffee()
		.pipe plugins.jshint()
		.pipe plugins.jshint.reporter "default"
		.pipe plugins.uglify()
		.pipe plugins.remember "js"
		.pipe plugins.concat "app-v#{ version }.js"
		.pipe gulp.dest dst
		.pipe plugins.livereload()

gulp.task "html", ->
	plugins.nunjucksRender.nunjucks.configure(["template"])
	gulp.src srcHtml
		.pipe plugins.plumber()
		.pipe plugins.nunjucksRender()
		.pipe plugins.minifyHtml()
		.pipe gulp.dest dst
		.pipe plugins.livereload()

gulp.task "img", ->
	gulp.src srcImg
		.pipe plugins.plumber()
		.pipe plugins.cached "img"
		.pipe gulp.dest "#{ dst }/img"
		.pipe plugins.remember "img"
		.pipe plugins.livereload()

gulp.task "other", ->
	gulp.src srcOther
		.pipe plugins.plumber()
		.pipe plugins.cached "other"
		.pipe gulp.dest dst
		.pipe plugins.remember "other"
		.pipe plugins.livereload()

gulp.task "watch", ->
	plugins.livereload.listen()
	gulp.watch srcCss, { debounceDelay: 1000 }, [ "css" ]
	gulp.watch srcJs, { debounceDelay: 1000 }, [ "js" ]
	gulp.watch [ srcHtml, "template/**" ], { debounceDelay: 1000 }, [ "html" ]
	gulp.watch srcImg, { debounceDelay: 1000 }, [ "img" ]
	gulp.watch srcOther, { debounceDelay: 1000 }, [ "other" ]

gulp.task "compile", [ "css", "js", "html", "img", "other" ]

gulp.task "default", [ "compile", "watch" ]


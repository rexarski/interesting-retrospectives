# housekeeping
unlink("content/blog/post/*.html")
unlink("content/cn/post/*.html")
unlink("content/project/*.html")
unlink("public/*", recursive = TRUE)

# preview
blogdown::hugo_build(local = TRUE); blogdown::serve_site()

# deploy
# blogdown::hugo_build(local = FALSE)

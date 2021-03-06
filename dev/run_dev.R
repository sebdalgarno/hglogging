# Set options here
options(golem.app.prod = TRUE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
rm(list=ls(all.names = TRUE))
golem::document_and_reload()

hglogging::run_app()

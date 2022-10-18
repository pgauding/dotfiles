# ${R_HOME}/bin/Rprof -*- sh -*- for processing Rprof() files

## SVN stuff(?)
# args=
# while test -n "${1}"; do
#   args="${args}nextArg${1}"
#   shift
# done

# ## NB: Apple's ICU needs LC_COLLATE set when R is started.
# echo 'tools:::.Rprof()' | R_DEFAULT_PACKAGES=utils LC_COLLATE=C "${R_HOME}/bin/R" --vanilla --slave --args ${args}

# local({r <- getOption("repos")
#     r["CRAN"] <- "https://rweb.crmda.ku.edu/cran/"
#     r["KRAN"] <- "https://rweb.crmda.ku.edu/kran/"
#     options(repos=r)})

## Changes q() to not ask to save workspace image
q <- function(save = "no", ...){
    quit(save=save, ...)
    }

## Alias `pwd` to `getwd`
# pwd <- function () {
# .Internal(getwd())
# <bytecode: 0x7fe75fdbd310>
# <environment: namespace:base>
# }

## OPTIONS
options(width = 80)

## Set Repositories
local({
	 r = getOption("repos")
	 r["CRAN"] <- "https://cran.case.edu/"
	 # r["CRAN"] <- "https://mirrors.nics.utk.edu/cran"
#	 r["CRAN"] <- "https://rweb.crmda.ku.edu/cran"
#	 r["KRAN"] <- "https://rweb.crmda.ku.edu/kran"
	 options(repos = r)
})

## Allow tab-completion in library() and require() calls
utils::rc.settings(ipck=TRUE)

## Set Hugo version
#options(blogdown.hugo.version = "0.85.0")

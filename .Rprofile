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

## OPTIONS
options(width = 80)

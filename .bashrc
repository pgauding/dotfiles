doit2bib ()
{
    echo >> bib.bib;
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtext" >> bib.bib;
    echo >> bib.bib
}

eval "$(pandoc --bash-completion)"

export PATH="/usr/local/mysql/bin:$PATH"

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for EPD_free-7.3-2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

##
# Your previous /Users/patrickgauding/.bash_profile file was backed up as /Users/patrickgauding/.bash_profile.macports-saved_2013-07-18_at_00:36:56
##

# MacPorts Installer addition on 2013-07-18_at_00:36:56: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

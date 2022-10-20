## List of Current Aliases

## Functions
# alias l='ls -lahF'
# alias ll='ls -lahG'
# alias ls='ls -lahF'
# alias sl='ls -lahF'
# alias lt='ls -lahtF'
# alias lo='ls -l'

# Switch to exa
alias ls='exa -alg --color=always' # my preferred listing
alias sl='ls'
alias lt='exa -alg --sort=modified'
alias lT='exa -aT --color=always' # tree listing

alias df='df -H'
alias bashedit='open -a emacs ~/.bash_aliases'
alias bashreload='. ~/.bash_profile'
alias eject2='diskutil eject /dev/disk2'
alias sleepnow='pmset sleepnow'
alias night='pmset sleepnow'
alias .emacs='open -a emacs ~/dotfiles/.emacs'
alias oepn='open'
alias cadt='cat'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -h'

alias op='open'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias tmptxt='open -a emacs ~/tmp/tmp.txt'
alias tmpr='open -a emacs ~/tmp/tmp.R'

alias htop='sudo htop'
alias powermetrics='sudo powermetrics'

alias bibcommit='git commit ~/Documents/research/dissertation/bib/gauding-diss.bib -m "add some cites"'

## Locations
alias docs='cd ~/Documents'

alias fs16='cd ~/Documents/FS16'
alias ss17='cd ~/Documents/SS17'
alias us17='cd ~/Documents/US17'

alias fs17='cd ~/Documents/FS17'
alias fs707='cd ~/Documents/FS17/POLS707_FS17'
alias fs904='cd ~/Documents/FS17/POLS904_FS17'
alias fs943='cd ~/Documents/FS17/PUAD943_FS17'
alias fs993='cd ~/Documents/FS17/POLS993_FS17'

alias ss18='cd ~/Documents/SS18'
alias ss306='cd ~/Documents/SS18/POLS306_SS18'
alias ss716='cd ~/Documents/SS18/POLS716_SS18'
alias ss909='cd ~/Documents/SS18/POLS909_SS18'
alias ss936='cd ~/Documents/SS18/PUAD936_SS18'
alias ssc='cd ~/Documents/SS18/CRMDA'

alias us18='cd ~/Documents/US18'
alias comps='cd /Users/patrickgauding/Documents/us18/comps'
alias ordthomp='cd ~/Documents/US18/thompson/project'

alias fs18='cd ~/Documents/FS18'
alias fs306='cd ~/Documents/FS18/POLS306_FS18'
alias ubpl850='cd ~/Documents/FS18/UBPL850_FS18'

alias ss18='cd ~/Documents/SS18'
alias ss19='cd ~/Documents/SS19'

alias m18='cd ~/Documents/Milford18'
alias tmp='cd ~/tmp'

alias us19='cd ~/Documents/US19'
alias fs19='cd ~/Documents/FS19'

alias diss='cd ~/Documents/research/dissertation'

alias vita='cd ~/Documents/vita'

alias int='cd ~/Documents/Interesting_Papers/'
alias pirate='cd ~/Documents/Pirated\ Software'
alias pauljohn='cd ~/Documents/pauljohn_manuscripts'
alias crmda='cd ~/Documents/FS18/crmda'
alias dotfiles='cd ~/dotfiles'
alias jobm='cd ~/Documents/jobmarket'

alias data='cd ~/Documents/data'
alias zr='cd ~/Documents/research'
alias zt='cd ~/Documents/teaching'

alias finance='cd ~/Documents/finance'

## Applications
alias reader='open -a "Adobe Acrobat Reader"'
alias weather='ansiweather -l Lawrence,US -u imperial'
alias textmate='open -a textmate'
alias stata='open -a statabe'
alias spotify='open -a spotify'
alias itunes='open -a itunes'
alias audacity='open -a audacity'
alias pyware='open -a "Pyware 3D"'
alias lyx='open -a lyx'
alias word='open -a "Microsoft Word"'
alias excel='open -a "Microsoft Excel"'
alias powerpoint='open -a "Microsoft PowerPoint"'
alias chrome='open -a "Google Chrome"'
alias firefox='open -a firefox'
alias prefs='open -a "System Preferences"'
alias rstudio='open -a rstudio'
alias pdf='open *.pdf'
alias em='open -a emacs'
##alias emacs='emacsclient -nw'
alias sysprefs='open -a "System Preferences"'
alias zotero='open -a Zotero'
alias bibdesk='open -a Bibdesk'
alias apps='open -a "App Store"'
alias cisco='open -a "Cisco AnyConnect Secure Mobility Client"'
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
##alias condaup='conda update --prefix /Users/patrickgauding/anaconda3 anaconda --verbose'
##alias anaconda='anaconda-navigator.app'
alias gitkey='source ~/.ssh/gitkey.sh'
alias gkgp='source ~/.ssh/gitkey.sh ; git push'
alias safari='open -a Safari'
alias libre='open -a libreoffice'
alias matlab='open -a MATLAB_R2018b'
alias bayesapp='open ~/GIT/mcmc-demo/app.html'
alias game='open -a emacs -batch -l dunnet'
alias texup='sudo tlmgr update --all'
alias tor='open -a "Tor Browser"'
alias console='open -a console'
alias purge='sudo purge'
alias preview='open -a preview'
alias skim='open -a skim'
alias idrive='open -a idrive'
alias bt='btop'
alias rn='random number'

alias switchtozsh='chsh -s $(which zsh)'
alias maps='telnet mapscii.me'
alias edtheme='em ~/.oh-my-zsh/custom/themes/agnosterzak.zsh-theme'
alias shiftit='open -a shiftit'
alias mail='open -a Mail'

alias python='python3'
alias py='python3'
alias pip='pip3'

alias TODO='open -a emacs ~/Library/Mobile\ Documents/iCloud~com~appsonthemove~beorg/Documents/org/TODO.org'
alias icat='kitty icat'

alias dlist='diskutil list'
alias deject='diskutil eject'

alias negs='cd ~/Documents/GTAC/negotiations/2020'
alias obs='open -a obs'

alias bi='brew install'
alias bu='brew uninstall'

alias 'omp=ocrmypdf'

alias 't-stream=python3 ~/GIT/t-stream/src/app.py'

alias 'show=kitty +kitten icat'

alias 'ydl=youtube-dl'
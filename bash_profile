
# added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

#activate .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Replaceing rm to move things to the trash folder
alias rm='trash'
alias rmf='/bin/rm'
alias rmdirf='/bin/rmdir'
alias gcc='/usr/local/bin/gcc-8'
alias g++='/usr/local/bin/g++-8'
alias c++='/usr/local/bin/c++-8'

# cancel the hidden file when using tar
COPYFILE_DISABLE=1
export COPYFILE_DISABLE

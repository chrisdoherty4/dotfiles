# On MacOS there's a warning about zsh being the default in later versions.
# Disable it.
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load the .bashrc if present
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


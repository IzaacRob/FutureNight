#Author: IzaacRob (https://github.com/IzaacRob)

# Actual prompt
PROMPT='%F{red}
┌─[%F{blue}⚡%f%F{blue}%n%f%F{red}]%f $(root_dir)$(git_prompt_info)
%F{red}└── %f'

# Last prompt
PREVIOUS_PROMPT='%F{red}──[%f%F{blue}⚡%f%F{blue}$1%f%F{red}]%f'

# Error prompt
ERROR_PROMPT='%F{red}──[%f%F{red}$LAST_COMMAND%f%F{red}]%f'

# Variable to store the last executed command
LAST_COMMAND=""

function git_prompt_info() {
  # Checks if we are inside a Git repository
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    # If we are inside a Git repository, display the symbol and the branch name
    echo "  $(git rev-parse --abbrev-ref HEAD)"
  fi
}

function root_dir() {
  # Gets the root directory of the current project
  # If we are at the root, return an empty string; otherwise, display the relative path
  # /Users/user
  if [[ $PWD == "/Users/joseizaacroblestrinidad" ]]; then
    echo ""
  else
    echo "%F{red}[%f%F{green}%f %F{green}%~%f%F{red}]%f"
  fi
}

# preexec function: To display previously executed commands
function preexec() {
  LAST_COMMAND="$1"
  # Print the executed command with formatting for the previous prompt
  echo -ne "\033[2A\033[2K" # Move up one line and clear its content
  print -P "$PREVIOUS_PROMPT"
}

# precmd function: To restore the normal prompt or detect errors
function precmd() {
  # If the last command failed, show the ERROR_PROMPT
  if [[ $? -ne 0 ]]; then
    echo -ne "\033[2A\033[2K"
    print -P "$ERROR_PROMPT"
  fi

  # Restore the main prompt
  PS1=$PROMPT
}

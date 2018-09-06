source /home/rebelm/dot/bash-git-prompt/prompt-colors.sh
#
override_git_prompt_colors() {
  time="\$(date +%H:%M:%S)"
  top="\$(basename \$(git rev-parse --show-toplevel))"
  GIT_PROMPT_THEME_NAME="Custom"
  GIT_PROMPT_STAGED="${Yellow}●"
  GIT_PROMPT_CONFLICTS="${Red}‡"
  GIT_PROMPT_CHANGED="${Red}○"
  GIT_PROMPT_UNTRACKED="${Blue}…"
  GIT_PROMPT_STASHED="${Black}◊"
  GIT_PROMPT_CLEAN="${Green}√"
  # Something is generating a space before the $GIT_PROMPT_PREFIX
  # Undo that by echoing a backspace
  GIT_PROMPT_PREFIX="$(echo -e '\b')[${Blue}${top}${resetColor}:"
  GIT_PROMPT_SUFFIX="]"
  GIT_PROMPT_START_USER=""
  GIT_PROMPT_END_USER="\n[${Blue}${time}${ResetColor}] _LAST_COMMAND_INDICATOR_${Green}\u${ResetColor}@${Green}\h${ResetColor}> "
  GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
  GIT_PROMPT_COMMAND_OK=""
  GIT_PROMPT_COMMAND_FAIL="${Red}_LAST_COMMAND_STATE_ "
  GIT_PROMPT_END_ROOT="# "
  GIT_PROMPT_SYMBOLS_AHEAD="↑"
  GIT_PROMPT_SYMBOLS_BEHIND="↓"
}

reload_git_prompt_colors "Custom"

setopt prompt_subst
() {
  local PR_USER PR_PROMPT PR_HOST
  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{@FOREGROUND@}%n%f%b'
    PR_PROMPT='%F{@FOREGROUND@} %F{@MUTED@}❯%f'
  else
    PR_USER='%B%F{@ACCENT@}root%f%b'
    PR_PROMPT='%B%F{@ACCENT@} ❯%f%b'
  fi
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%B%U%F{@ACCENT@}%m%f%u%b'
  else
    PR_HOST='%F{@MUTED@}%m%f'
  fi
  local return_code="%(?..%F{@URGENT@}%? ↵%f)"
  local user_host="${PR_USER}%F{@DIM@}@${PR_HOST}"
  local current_dir="%B%F{@FOREGROUND@}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'
  PROMPT="${venv_prompt}${user_host} %F{@DIM@}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "
  RPROMPT="${return_code}"
  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{@MUTED@}git:(%F{@FOREGROUND@}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{@MUTED@})%f"
  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{@MUTED@}ruby:(%F{@FOREGROUND@}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{@MUTED@})%f"
  ZSH_THEME_VIRTUALENV_PREFIX="%F{@MUTED@}venv:(%F{@FOREGROUND@}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{@MUTED@})%f "
}

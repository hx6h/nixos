setopt prompt_subst

() {
  local PR_USER PR_PROMPT PR_HOST

  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{#e5e5e5}%n%f%b'
    PR_PROMPT='%F{#e5e5e5} %F{#aaaaaa}❯%f'
  else
    PR_USER='%B%F{#ffffff}root%f%b'
    PR_PROMPT='%B%F{#ffffff} ❯%f%b'
  fi

  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%B%U%F{#cccccc}%m%f%u%b'
  else
    PR_HOST='%F{#aaaaaa}%m%f'
  fi

  local return_code="%(?..%F{#ffffff}%? ↵%f)"

  local user_host="${PR_USER}%F{#666666}@${PR_HOST}"
  local current_dir="%B%F{#cccccc}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'

  PROMPT="${venv_prompt}${user_host} %F{#777777}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

  RPROMPT="${return_code}"

  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#999999}git:(%F{#e5e5e5}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#999999})%f"

  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#aaaaaa}ruby:(%F{#e5e5e5}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#aaaaaa})%f"

  ZSH_THEME_VIRTUALENV_PREFIX="%F{#bbbbbb}venv:(%F{#e5e5e5}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{#bbbbbb})%f "
}

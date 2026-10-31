setopt prompt_subst

() {
  local PR_USER PR_PROMPT PR_HOST

  # USER / ROOT
  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{#A3B8A8}%n%f%b'
    PR_PROMPT='%F{#75B99A} %F{#579879}❯%f'
  else
    PR_USER='%B%F{#D99A91}root%f%b'
    PR_PROMPT='%B%F{#75B99A} ❯%f%b'
  fi

  # HOST
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%B%U%F{#D99A91}%m%f%u%b'
  else
    PR_HOST='%F{#718A7D}%m%f'
  fi

  # RETURN CODE
  local return_code="%(?..%F{#D99A91}%? ↵%f)"

  # PROMPT ELEMENTS
  local user_host="${PR_USER}%F{#39765B}@${PR_HOST}"
  local current_dir="%B%F{#C1D8C8}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'

  # MAIN PROMPT
  PROMPT="${venv_prompt}${user_host} %F{#718A7D}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

  # RIGHT PROMPT
  RPROMPT="${return_code}"

  # GIT
  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#718A7D}git:(%F{#75B99A}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#718A7D})%f"

  # RUBY
  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#D99A91}ruby:(%F{#C1D8C8}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#D99A91})%f"

  # VIRTUALENV
  ZSH_THEME_VIRTUALENV_PREFIX="%F{#75B99A}venv:(%F{#C1D8C8}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{#75B99A})%f "
}

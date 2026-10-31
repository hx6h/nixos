setopt prompt_subst

() {
  local PR_USER PR_PROMPT PR_HOST

  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{#e0def4}%n%f%b'
    PR_PROMPT='%F{#c4a7e7} %F{#ea9a97}❯%f'
  else
    PR_USER='%B%F{#eb6f92}root%f%b'
    PR_PROMPT='%B%F{#eb6f92} ❯%f%b'
  fi

  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%B%U%F{#f6c177}%m%f%u%b'
  else
    PR_HOST='%F{#908caa}%m%f'
  fi

  local return_code="%(?..%F{#eb6f92}%? ↵%f)"

  local user_host="${PR_USER}%F{#6e6a86}@${PR_HOST}"
  local current_dir="%B%F{#e0def4}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'

  PROMPT="${venv_prompt}${user_host} %F{#908caa}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

  RPROMPT="${return_code}"

  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#908caa}git:(%F{#c4a7e7}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#908caa})%f"

  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#908caa}ruby:(%F{#f6c177}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#908caa})%f"

  ZSH_THEME_VIRTUALENV_PREFIX="%F{#9ccfd8}venv:(%F{#e0def4}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{#9ccfd8})%f "
}

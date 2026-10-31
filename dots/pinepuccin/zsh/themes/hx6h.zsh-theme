setopt prompt_subst

() {
  local PR_USER PR_PROMPT PR_HOST

  # USER / ROOT
  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{#e0def4}%n%f%b'
    PR_PROMPT='%F{#ea9a97}♥ %F{#c4a7e7}❯%f'
  else
    PR_USER='%B%F{#eb6f92}root%f%b'
    PR_PROMPT='%B%F{#c4a7e7}♥ ❯%f%b'
  fi

  # HOST
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%B%U%F{#ea9a97}%m%f%u%b'
  else
    PR_HOST='%F{#908caa}%m%f'
  fi

  # RETURN CODE
  local return_code="%(?..%F{#eb6f92}%? ↵%f)"

  # PROMPT ELEMENTS
  local user_host="${PR_USER}%F{#6e6a86}@${PR_HOST}"
  local current_dir="%B%F{#e0def4}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'

  # MAIN PROMPT
  PROMPT="${venv_prompt}${user_host} %F{#908caa}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

  # RIGHT PROMPT
  RPROMPT="${return_code}"

  # GIT
  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#908caa}git:(%F{#c4a7e7}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#908caa})%f"

  # RUBY
  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#ea9a97}ruby:(%F{#e0def4}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#ea9a97})%f"

  # VIRTUALENV
  ZSH_THEME_VIRTUALENV_PREFIX="%F{#c4a7e7}venv:(%F{#e0def4}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{#c4a7e7})%f "
}

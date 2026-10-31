setopt prompt_subst

() {
  local PR_USER PR_PROMPT PR_HOST

  # USER / ROOT
  if [[ $UID -ne 0 ]]; then
    PR_USER='%B%F{#C4C4C4}%n%f%b'
    PR_PROMPT='%F{#CCCCCC} %F{#858585}❯%f'
  else
    PR_USER='%B%F{#D99A91}root%f%b'
    PR_PROMPT='%B%F{#CCCCCC} ❯%f%b'
  fi

  # HOST
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT ]]; then
    PR_HOST='%B%U%F{#E6E6E6}%m%f%u%b'
  else
    PR_HOST='%F{#858585}%m%f'
  fi

  # RETURN CODE
  local return_code="%(?..%F{#D99A91}%? ↵%f)"

  # PROMPT ELEMENTS
  local user_host="${PR_USER}%F{#575757}@${PR_HOST}"
  local current_dir="%B%F{#E6E6E6}%~%f%b"
  local git_branch='$(git_prompt_info)'
  local venv_prompt='$(virtualenv_prompt_info)'

  # MAIN PROMPT
  PROMPT="${venv_prompt}${user_host} %F{#858585}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

  # RIGHT PROMPT
  RPROMPT="${return_code}"

  # GIT
  ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#858585}git:(%F{#CCCCCC}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#858585})%f"

  # RUBY
  ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#858585}ruby:(%F{#E6E6E6}"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#858585})%f"

  # VIRTUALENV
  ZSH_THEME_VIRTUALENV_PREFIX="%F{#858585}venv:(%F{#CCCCCC}"
  ZSH_THEME_VIRTUALENV_SUFFIX="%F{#858585})%f "
}

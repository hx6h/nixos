setopt prompt_subst

() {

local PR_USER PR_PROMPT PR_HOST

if [[ $UID -ne 0 ]]; then
  PR_USER='%B%F{#cba6f7}%n%f%b'
  PR_PROMPT='%F{#cba6f7} %F{#89b4fa}❯%f'
else
  PR_USER='%B%F{#f38ba8}root%f%b'
  PR_PROMPT='%B%F{#f38ba8} ❯%f%b'
fi

if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%B%U%F{#cba6f7}%m%f%u%b'
else
  PR_HOST='%F{#cba6f7}%m%f'
fi

local return_code="%(?..%F{#f38ba8}%? ↵%f)"

local user_host="${PR_USER}%F{#6c7086}@${PR_HOST}"
local current_dir="%B%F{#89b4fa}%~%f%b"
local git_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

PROMPT="    ${venv_prompt}${user_host} %F{#6c7086}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{#cba6f7}git:(%F{#cdd6f4}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#cba6f7})%f"

ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{#f5c2e7}ruby:(%F{#cdd6f4}"
ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{#f5c2e7})%f"

ZSH_THEME_VIRTUALENV_PREFIX="%F{#a6e3a1}venv:(%F{#cdd6f4}"
ZSH_THEME_VIRTUALENV_SUFFIX="%F{#a6e3a1})%f "

}

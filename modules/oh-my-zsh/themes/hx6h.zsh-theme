setopt prompt_subst

() {

local PR_USER PR_PROMPT PR_HOST

if [[ $UID -ne 0 ]]; then
  PR_USER='%B%F{212}%n%f%b'
  PR_PROMPT='%F{212} %F{205}❯%f'
else
  PR_USER='%B%F{196}root%f%b'
  PR_PROMPT='%B%F{196} ❯%f%b'
fi

if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%B%U%F{212}%m%f%u%b'
else
  PR_HOST='%F{212}%m%f'
fi

local return_code="%(?..%F{196}%? ↵%f)"

local user_host="${PR_USER}%F{244}@${PR_HOST}"
local current_dir="%B%F{212}%~%f%b"
local git_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

PROMPT="    ${venv_prompt}${user_host} %F{244}in%f ${current_dir}\$(ruby_prompt_info)${git_branch} ${PR_PROMPT} "

RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{212}git:(%F{253}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{212})%f"
ZSH_THEME_RUBY_PROMPT_PREFIX=" %F{212}ruby:(%F{253}"
ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{212})%f"
ZSH_THEME_VIRTUALENV_PREFIX="%F{212}venv:(%F{253}"
ZSH_THEME_VIRTUALENV_SUFFIX="%F{212})%f "

}

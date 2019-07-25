# shellcheck shell=bash disable=SC1090,SC2155

export GOPATH="$HOME/go"

paths=(
  "$HOME/.local/bin"
  "$GOPATH/bin"
  "$HOME/.poetry/bin"
  "$HOME/.yarn/bin"
  "$HOME/.pyenv/bin"
  "/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool/"
  "/usr/local/opt/openssl@1.1/bin"
  "/usr/local/opt/libarchive/bin"
  "/usr/local/opt/python/libexec/bin"
  "/usr/local/opt/curl/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
)

for path in "${paths[@]}"
do
  [ -d "$path" ] && PATH="$path:$PATH"
done

hash pyenv 2>/dev/null && eval "$(pyenv init -)"
hash pyenv 2>/dev/null && eval "$(pyenv virtualenv-init -)"
hash rbenv 2>/dev/null && eval "$(rbenv init -)"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

[ -r ~/.profile ] && source ~/.profile
[ -r ~/.bash_profile.local ] && source ~/.bash_profile.local
[ -r ~/.bashrc ] && source ~/.bashrc
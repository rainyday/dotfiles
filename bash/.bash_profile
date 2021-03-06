# shellcheck shell=bash disable=SC1090,SC2155
export GOPATH="$HOME/go"

paths=(
  "$HOME/.local/bin"
  "$GOPATH/bin"
  "$HOME/.poetry/bin"
  "$HOME/.yarn/bin"
  "$HOME/.pyenv/bin"
  "$HOME/.cargo/bin"
  "$HOME/Library/Python/"*/bin
  "/Applications/VMware Fusion.app/Contents/Library/VMware OVF Tool/"
  "/usr/local/opt/openssl@1.1/bin"
  "/usr/local/opt/libarchive/bin"
  "/usr/local/opt/curl/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
)

for path in "${paths[@]}"
do
  [ -d "$path" ] && PATH="$path:$PATH"
done

unset path paths

hash pyenv 2>/dev/null && eval "$(pyenv init -)"
hash pyenv-virtualenv-init 2>/dev/null && eval "$(pyenv virtualenv-init -)"
hash pipx 2>/dev/null && eval "$(register-python-argcomplete pipx)"
hash rbenv 2>/dev/null && eval "$(rbenv init -)"

# Only override agent if not in ssh session!
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
fi

[ -r "$HOME/.profile" ] && source "$HOME/.profile"
[ -r "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"
[ -r "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# iTerm2 Integration (needs to be last for some reason)
[ -r "${HOME}/.iterm2_shell_integration.bash" ] && source "${HOME}/.iterm2_shell_integration.bash"

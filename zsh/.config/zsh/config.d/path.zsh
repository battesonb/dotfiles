# Responsible for amending the environment path variable with required paths

# Dart-related paths
export PATH="/usr/lib/dart/bin:$PATH"

# Rust-related paths
export PATH="$HOME/.cargo/bin:$PATH"

# Prepare nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

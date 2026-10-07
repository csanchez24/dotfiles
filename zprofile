# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/carlosjosesanchezespinosa/.docker/bin"
# End of Docker Desktop section.

# ~/.zprofile
# Este archivo se carga en LOGIN shells (después de zshenv)
# Configuraciones que solo necesitan ejecutarse una vez al iniciar sesión

# ============================================================================
# Homebrew Environment (si no está en zshenv)
# ============================================================================
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# Pyenv initialization 
# ============================================================================
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# ============================================================================
# SSH Agent (para login shells)
# ============================================================================
# Iniciar ssh-agent si no está corriendo
if [[ ! -S "${SSH_AUTH_SOCK}" ]]; then
  eval "$(ssh-agent -s)" >/dev/null
  
  # Auto-agregar llaves comunes
  if [[ -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null
  fi
  if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
  fi
fi

# ============================================================================
# GPG Agent (si usas GPG para Git signing)
# ============================================================================
if command -v gpg-agent >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

# ============================================================================
# macOS Specific
# ============================================================================
if [[ "$OSTYPE" == darwin* ]]; then
  # Deshabilitar mensajes de bash deprecation en macOS
  export BASH_SILENCE_DEPRECATION_WARNING=1
  
  # Usar comandos GNU si están instalados (vía Homebrew)
  if [[ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]]; then
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  fi
fi

# ============================================================================
# Cleanup
# ============================================================================
# Ejecutar cualquier comando de limpieza necesario aquí

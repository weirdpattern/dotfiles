for files in ~/.config/zsh/aliases/*.sh(N-.); do
  source "$files";
done

for files in ~/.config/zsh/exports/*.sh(N-.); do
  source "$files";
done

for files in ~/.config/zsh/registrations/*.sh(N-.); do
  source "$files";
done

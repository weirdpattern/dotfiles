for files in ~/.config/zsh/aliases/*.sh(N-@,N-.); do
  source "$files";
done

for files in ~/.config/zsh/exports/*.sh(N-@,N-.); do
  source "$files";
done

for files in ~/.config/zsh/registrations/*.sh(N-@,N-.); do
  source "$files";
done

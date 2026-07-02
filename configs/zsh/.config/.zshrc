for aliases in ~/.config/zsh/aliases/*.sh(N-@,N-.); do
  source "$aliases";
done

for exports in ~/.config/zsh/exports/*.sh(N-@,N-.); do
  source "$exports";
done

for registrations in ~/.config/zsh/registrations/*.sh(N-@,N-.); do
  source "$registrations";
done

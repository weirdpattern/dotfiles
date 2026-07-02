for aliases (~/.config/zsh/aliases/*.sh); do
  source "$aliases"
done

for exports (~/.config/zsh/exports/*.sh); do
  source "$exports"
done

for registrations (~/.config/zsh/registrations/*.sh); do
  source "$registrations"
done

for aliases (~/.config/zsh/aliases/*.zsh); do
  source "$aliases"
done

for exports (~/.config/zsh/exports/*.zsh); do
  source "$exports"
done

for registrations (~/.config/zsh/registrations/*.zsh); do
  source "$registrations"
done
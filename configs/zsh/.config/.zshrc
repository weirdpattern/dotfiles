for aliases in ~/.config/zsh/aliases/*.sh; do
  source "$aliases";
done;

for exports in ~/.config/zsh/exports/*.sh; do
  source "$exports";
done;

for registrations in ~/.config/zsh/registrations/*.sh; do
  source "$registrations";
done;

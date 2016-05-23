# Load our dotfiles
for file in ~/.{bash_prompt,bash_exports,bash_aliases,bash_functions,bash_overrides}; do
    [ -r "$file" ] && source "$file"
done
unset file

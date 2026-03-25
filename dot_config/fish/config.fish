source ~/.env.sh

if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/yazi.fish

    # smart cd (remembers and fuzzy matches directories)
    zoxide init fish | source

    # Abbreviations (like alias, but auto-expanding)
    abbr vim nvim
    abbr svim sudoedit
end

mise activate fish | source

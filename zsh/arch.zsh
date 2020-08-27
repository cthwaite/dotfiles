if [[ -x "$(command -v fzf)" ]]; then
    # -- fzf package helpers
    alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
    alias yayfzf="yay -Slq | fzf -m --preview 'yay -Si {1}' | xargs -ro yay -S"
    function pacsrc {
        local -r pack=$(pacman -Qei |awk '/^Name/ { name=$3 } /^Groups/ { if ( $3 != "base" && $3 != "base-devel" ) { print name } }')
        echo $pack | fzf -m --preview 'pacman -Qi {1}'
    }
fi



power-consumption() {
    upower -i /org/freedesktop/UPower/devices/battery_BAT0
}

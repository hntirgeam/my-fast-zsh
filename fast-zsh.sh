#!/bin/bash

input=1

start() {
    echo "Select version"
    echo "  1) Server"
    echo "  2) User"
    echo "  3) Quit"

    read n
    case $n in
    1)
        echo "Default server"
        input=1
        return
        ;;
    2)
        echo "Default user"
        input=2
        return
        ;;
    3)
        echo "Bye."
        exit
        ;;
    *) echo "Invalid option" ;;
    esac

}

start

if command -v git &>/dev/null && command -v zsh &>/dev/null && command -v &>/dev/null && command -v curl &>/dev/null; then
    echo -e "git & zsh & curl are already installed \n"
else
    if sudo apt install -y zsh git curl || sudo pacman -S zsh git curl || sudo dnf install -y zsh git curl || sudo yum install -y zsh git curl || sudo brew install git zsh curl || pkg install git zsh curl; then
        echo -e "git & zsh & curl Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git curl \n" && exit
    fi
fi

if [ -d "~/.oh-my-zsh" ]; then
    echo "Directory ~/.oh-my-zsh exists."
else
    echo "Installing Oh My ZSH\n"
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions"]; then
    echo "autosuggestions already downladed \n"
else
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions &>/dev/null
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"]; then
    echo "syntax-highlighting already downladed \n"
else
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &>/dev/null
fi

res=True
for dir in \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions" \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"; do
    if ! [ -d "$dir" ]; then
        res=False
        break
    else
        if input==1; then
            sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/g' ~/.zshrc
            sed -i 's/plugins(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
        else
            sed -i 's/plugins(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
        fi

    fi
done

exit

# find ZSH_THEME="robbyrussell"
# change to ZSH_THEME="gnzh"

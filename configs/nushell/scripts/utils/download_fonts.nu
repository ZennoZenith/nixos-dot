let fonts_url = [
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Agave.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/RobotoMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.tar.xz
]

mkdir ~/.fonts

cd ~/.fonts
$fonts_url | each {|e| wget $e }

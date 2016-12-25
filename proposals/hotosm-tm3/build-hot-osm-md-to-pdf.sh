#!/usr/bin/env sh

pandoc hot-osm-tm3-tech-challenge.md --latex-engine=xelatex -o hot-osm-tm3-tech-challenge.pdf

# troubleshooting:
# if you get `xelatex not found` error:
# echo "export PATH=/Library/TeX/texbin:$PATH" >> ~/.bashrc
# . ~/.bashrc
# OR
# echo "export PATH=/Library/TeX/texbin:$PATH" >> ~/.zshrc
# . ~/.zshrc


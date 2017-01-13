#!/usr/bin/env sh

pandoc pg-orchestra.md --latex-engine=xelatex -o pg-orchestra.pdf

# troubleshooting:
# if you get `xelatex not found` error:
# echo "export PATH=/Library/TeX/texbin:$PATH" >> ~/.bashrc
# . ~/.bashrc
# OR
# echo "export PATH=/Library/TeX/texbin:$PATH" >> ~/.zshrc
# . ~/.zshrc

[ -f ~/.bashrc ] && . ~/.bashrc

# TeX Live completo: binários oficiais
case ":$PATH:" in
  *:/home/joaob/.local/share/texlive/2026/bin/x86_64-linux:*) ;;
  *) export PATH="/home/joaob/.local/share/texlive/2026/bin/x86_64-linux:/home/joaob/.local/bin:$PATH" ;;
esac

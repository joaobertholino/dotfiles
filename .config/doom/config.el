;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "João Bertholino"
      user-mail-address "comercial.bertholino@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; ─────────────────────────────────────────
;;;  LaTeX — Configuração Completa
;;; ─────────────────────────────────────────

(after! latex

  ;; ── Motor de compilação ──────────────────
  (setq-default TeX-engine 'luatex)          ; LuaLaTeX (melhor para Unicode/fontes)
  ;; Alternativas: 'pdflatex  'xetex

  ;; ── Compilador padrão ────────────────────
  (setq TeX-command-default "LatexMk"
        TeX-save-query       nil              ; salva sem perguntar antes de compilar
        TeX-parse-self       t               ; parse automático do .tex ao abrir
        TeX-auto-save        t               ; gera pasta auto/ com info de parse
        TeX-electric-sub-and-superscript t)  ; {} automático após ^ e _

  ;; ── latexmk: compilação completa ─────────
  ;; Resolve referências, BibTeX e índices automaticamente
  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -pvc -lualatex -synctex=1 \
                  -interaction=nonstopmode -shell-escape %s"
                 TeX-run-command nil t
                 :help "Compila e recompila automaticamente com latexmk"))

  ;; ── Viewer (PDF com SyncTeX) ──────────────
  (setq TeX-view-program-selection '((output-pdf "Zathura")))
  (setq TeX-source-correlate-mode        t    ; SyncTeX ligado
        TeX-source-correlate-start-server t)  ; permite salto PDF → fonte

  ;; ── Syntax highlight aprimorado ──────────
  (setq font-latex-match-reference-keywords
        '(("cite"        "[{")
          ("citep"       "[{")
          ("citet"       "[{")
          ("autocite"    "[{")
          ("label"       "{")
          ("ref"         "{")
          ("pageref"     "{")
          ("eqref"       "{")))

  (setq font-latex-match-textual-keywords
        '(("emph"        "{")
          ("textit"      "{")
          ("textbf"      "{")
          ("textsc"      "{")
          ("textrm"      "{")
          ("underline"   "{")))

  (setq font-latex-match-warning-keywords
        '(("TODO"  "")
          ("FIXME" "")))

  ;; Negrito e itálico reais no buffer para os respectivos comandos
  (setq font-latex-fontify-script      t
        font-latex-fontify-sectioning  'color)

  ;; ── Ambientes matemáticos ─────────────────
  (setq LaTeX-math-list
        '((?a "alpha"   "Greek")
          (?b "beta"    "Greek")
          (?g "gamma"   "Greek")
          (?d "delta"   "Greek")
          (?e "epsilon" "Greek")
          (?l "lambda"  "Greek")
          (?m "mu"      "Greek")
          (?p "pi"      "Greek")
          (?s "sigma"   "Greek")
          (?o "omega"   "Greek")
          (?8 "infty"   "Misc")))

  ;; ── Indentação e formatação ───────────────
  (setq LaTeX-indent-level          2
        LaTeX-item-indent           2
        TeX-brace-indent-level      2
        LaTeX-top-newline-count     2)

  ;; ── Fechamento automático de ambientes ────
  ;; Após \begin{env}, o \end{env} é inserido automaticamente
  (setq LaTeX-electric-left-right-brace t)

  ;; ── cdlatex: modo matemático ágil ─────────
  ;; Tab-completion de símbolos: `a → \alpha, etc.
  (add-hook 'LaTeX-mode-hook #'cdlatex-mode)

  ;; ── Preview inline de equações ───────────
  (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)
  (setq preview-auto-cache-preamble t        ; preamble cacheado → preview rápido
        preview-scale-function      1.3)     ; tamanho do preview no buffer

  ;; ── Spell check ───────────────────────────
  (add-hook 'LaTeX-mode-hook #'flyspell-mode)
  (setq ispell-program-name "aspell"
        ispell-dictionary   "pt_BR")         ; mude para "en" se preferir

  ;; ── Contagem de palavras ──────────────────
  (add-hook 'LaTeX-mode-hook #'wc-mode)

  ;; ── Fold de seções e ambientes ────────────
  (add-hook 'LaTeX-mode-hook #'TeX-fold-mode)
  (setq TeX-fold-auto t)                     ; fold automático ao abrir

  ;; ── Fill automático ───────────────────────
  (add-hook 'LaTeX-mode-hook #'auto-fill-mode)
  (setq fill-column 90))

;;; ─────────────────────────────────────────
;;;  Referências bibliográficas com citar
;;; ─────────────────────────────────────────

(after! citar
  (setq citar-bibliography '("~/Documents/refs.bib")) ; seu arquivo .bib
  (setq citar-library-paths '("~/Documents/papers/"))
  (setq citar-notes-paths   '("~/Documents/notes/"))

  ;; Integração com embark (ações contextuais em citações)
  (with-eval-after-load 'embark
    (citar-embark-mode +1)))

;;; ─────────────────────────────────────────
;;;  LSP com Digestif
;;; ─────────────────────────────────────────

(after! lsp-latex
  ;; Digestif deve estar no PATH (luarocks install digestif)
  (setq lsp-latex-texlab-executable "texlab")  ; ou "digestif"
  (setq lsp-latex-build-on-save t)             ; compila ao salvar
  (setq lsp-latex-lint-on-save  t))

;;; ─────────────────────────────────────────
;;;  Atalhos customizados (leader key)
;;; ─────────────────────────────────────────

(map! :after latex
      :map LaTeX-mode-map
      :localleader
      ;; Compilação
      "b"  #'TeX-command-master         ; compila
      "v"  #'TeX-view                   ; abre PDF
      "k"  #'TeX-kill-job               ; encerra compilação
      "l"  #'TeX-recenter-output-buffer ; mostra log

      ;; Ambientes
      "e"  #'LaTeX-environment          ; insere \begin{}...\end{}
      "s"  #'LaTeX-section              ; insere \section, \subsection...
      "m"  #'TeX-insert-macro           ; insere macro genérica

      ;; Preview
      "p p" #'preview-at-point          ; preview sob o cursor
      "p b" #'preview-buffer            ; preview do buffer inteiro
      "p c" #'preview-clearout-buffer   ; limpa previews

      ;; Fold
      "f f" #'TeX-fold-dwim             ; fold/unfold sob o cursor
      "f b" #'TeX-fold-buffer           ; fold do buffer inteiro
      "f c" #'TeX-fold-clearout-buffer  ; desfaz todos os folds

      ;; Referências
      "r"  #'citar-insert-citation      ; insere citação

      ;; Spell
      "S"  #'ispell-buffer)             ; corrige ortografia do buffer

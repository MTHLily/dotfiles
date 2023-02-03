;;; doom-tokyo-night-theme.el --- inspired by VSCode's Tokyo Night theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: December 15, 2021 (#650)
;; Author: FosterHangdaan <https://github.com/FosterHangdaan>
;; Maintainer:
;; Source: https://github.com/enkia/tokyo-night-vscode-theme
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-tokyo-night-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-tokyo-night-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'katsushika-theme
  :type 'boolean)

(defcustom doom-tokyo-night-brighter-comments t
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'katsushika-theme
  :type 'boolean)

(defcustom doom-tokyo-night-comment-bg doom-tokyo-night-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their legibility."
  :group 'katsushika-theme
  :type 'boolean)

(defcustom doom-tokyo-night-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to determine the exact padding."
  :group 'katsushika-theme
  :type '(or integer boolean))


;;
;;; Theme definition

(def-doom-theme katsushika
  "A clean, dark theme that celebrates the lights of downtown Tokyo at night."

  ; Color Scheme
  ; gui       256
  ; "#C34043" "#C34043" => This keyword, HTML elements, Regex group symbol, CSS units, Terminal Red
  ; "#E82424" "#E82424" => Number and Boolean constants, Language support constants
  ; "#C0A36E" "#C0A36E" => Function parameters, Regex character sets, Terminal Yellow
  ; "#6A9589" "#6A9589" => Strings, CSS class names
  ; "#76946A" "#76946A" => Object literal keys, Markdown links, Terminal Green
  ; "#7AA89F" "#7AA89F" => Regex literal strings
  ; "#98BB6C" "#98BB6C" => Language support functions, CSS HTML elements
  ; "#A3D4D5" "#A3D4D5" => Object properties, Regex quantifiers and flags, Markdown headings, Terminal Cyan, Markdown code, Import/export keywords
  ; "#7E9CD8" "#7E9CD8" => Function names, CSS property names, Terminal Blue
  ; "#938AA9" "#938AA9" => Control Keywords, Storage Types, Regex symbols and operators, HTML Attributes, Terminal Magenta
  ; "#c0caf5" "#c0caf5" => Variables, Class names, Terminal White
  ; "#DCD7BA" "#DCD7BA" => Editor foreground
  ; "#9CABCA" "#9CABCA" => Markdown Text, HTML Text
  ; "#E6C384" "#E6C384" => Parameters inside functions (semantic highlighting only)
  ; "#957FB8" "#957FB8" => Comments
  ; "#363646" "#363646" => Terminal black
  ; "#24283b" "#24283b" => Editor background (Storm)
  ; "#1F1F28" "#1F1F28" => Editor background (Night)

  ;; name        default   256       16
  ((bg         '("#1F1F28" nil       nil            ))
   (bg-alt     '("#2A2A37" nil       nil            ))
   (base0      '("#43434A" "#43434A" "black"        ))
   (base1      '("#3A3A4C" "#3A3A4C" "brightblack"  ))
   (base2      '("#5D5B5C" "#5D5B5C" "brightblack"  ))
   (base3      '("#76746F" "#76746F" "brightblack"  ))
   (base4      '("#908D82" "#908D82" "brightblack"  ))
   (base5      '("#A9A695" "#A9A695" "brightblack"  ))
   (base6      '("#C3BEA7" "#C3BEA7" "brightblack"  ))
   (base7      '("#DCD7BA" "#DCD7BA" "brightblack"  ))
   (base8      '("#DCD7BA" "#DCD7BA" "white"        ))
   (fg-alt     '("#C8C093" "#C8C093" "brightwhite"  ))
   (fg         '("#DCD7BA" "#DCD7BA" "white"        ))

   (grey       base4)
   (red        '("#C34043" "#C34043" "red"          ))
   (orange     '("#E82424" "#E82424" "brightred"    ))
   (green      '("#76946A" "#76946A" "green"        ))
   (teal       '("#98BB6C" "#98BB6C" "brightgreen"  ))
   (yellow     '("#C0A36E" "#C0A36E" "yellow"       ))
   (blue       '("#7E9CD8" "#7E9CD8" "brightblue"   ))
   (dark-blue  '("#957FB8" "#957FB8" "blue"         ))
   (magenta    '("#938AA9" "#938AA9" "magenta"      ))
   (violet     '("#9CABCA" "#9CABCA" "brightmagenta"))
   (cyan       '("#7AA89F" "#7AA89F" "brightcyan"   ))
   (dark-cyan  '("#A3D4D5" "#A3D4D5" "cyan"         ))
   ; Additional custom colors
   (dark-green '("#6A9589" "#6A9589" "green"        ))
   (brown      '("#E6C384" "#E6C384" "yellow"       ))

   ;; face categories -- required for all themes
   (highlight      cyan)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      base0)
   (builtin        red)
   (comments       (if doom-tokyo-night-brighter-comments base5 base1))
   (doc-comments   (doom-lighten (if doom-tokyo-night-brighter-comments base5 base1) 0.25))
   (constants      orange)
   (functions      blue)
   (keywords       magenta)
   (methods        blue)
   (operators      dark-cyan)
   (type           base8)
   (strings        dark-green)
   (variables      base8)
   (numbers        orange)
   (region         base0)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-tokyo-night-brighter-modeline)
   (-modeline-pad
    (when doom-tokyo-night-padded-modeline
      (if (integerp doom-tokyo-night-padded-modeline) doom-tokyo-night-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
	base3
	`(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
	base3
	`(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- Extra Faces ------------------------
  (
   ((line-number-current-line &override) :foreground base8)
   ((line-number &override) :foreground comments :background (doom-darken bg 0.025))

   (font-lock-comment-face
    :foreground comments
    :background (if doom-tokyo-night-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   ;;; Doom Modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-path :foreground base8 :weight 'normal)
   (doom-modeline-buffer-file :foreground brown :weight 'normal)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id
    :foreground highlight)

   ;;; Indentation
   (whitespace-indentation :background bg)
   (whitespace-tab :background bg)

   ;;; Ivy
   (ivy-subdir :foreground blue)
   (ivy-minibuffer-match-face-1 :foreground green :background bg-alt)
   (ivy-minibuffer-match-face-2 :foreground orange :background bg-alt)
   (ivy-minibuffer-match-face-3 :foreground red :background bg-alt)
   (ivy-minibuffer-match-face-4 :foreground yellow :background bg-alt)

   ;;; Elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;;; Solaire
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;;; Telephone
   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))
   (telephone-line-evil-emacs
    :inherit 'mode-line
    :background dark-blue)

   ;;;; rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground fg)
   (rainbow-delimiters-depth-2-face :foreground blue)
   (rainbow-delimiters-depth-3-face :foreground orange)
   (rainbow-delimiters-depth-4-face :foreground green)
   (rainbow-delimiters-depth-5-face :foreground cyan)
   (rainbow-delimiters-depth-6-face :foreground yellow)
   (rainbow-delimiters-depth-7-face :foreground teal)

   ;;; Treemacs
   (treemacs-root-face :foreground magenta :weight 'bold :height 1.2)
   (doom-themes-treemacs-root-face :foreground magenta :weight 'ultra-bold :height 1.2)
   (doom-themes-treemacs-file-face :foreground fg-alt)
   (treemacs-directory-face :foreground base8)
   (treemacs-file-face :foreground fg)
   (treemacs-git-modified-face :foreground green)
   (treemacs-git-renamed-face :foreground yellow)

   ;;; Magit
   (magit-section-heading :foreground blue)
   (magit-branch-remote   :foreground orange)
   (magit-diff-our :foreground (doom-darken red 0.2) :background (doom-darken red 0.7))
   (magit-diff-our-highlight :foreground red :background (doom-darken red 0.5) :weight 'bold)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-darken red 0.7))
   (magit-diff-removed-highlight :foreground red :background (doom-darken red 0.5) :weight 'bold)

   ;; --- Major-Mode Faces -------------------
   ;;; elisp
   (highlight-quoted-symbol :foreground yellow)

   ;;; js2-mode
   (js2-function-param :foreground yellow)
   (js2-object-property :foreground green)

   ;;; typescript-mode
   (typescript-this-face :foreground red)
   (typescript-access-modifier-face :foreground brown)

   ;;; rjsx-mode
   (rjsx-tag :foreground red)
   (rjsx-text :foreground violet)
   (rjsx-attr :foreground magenta :slant 'italic :weight 'medium)
   (rjsx-tag-bracket-face :foreground (doom-darken red 0.3))

   ;;; css-mode / scss-mode
   (css-property             :foreground blue)
   (css-selector             :foreground teal)
   (css-pseudo-class         :foreground orange)

   ;;; markdown-mode
   (markdown-markup-face :foreground violet)
   (markdown-header-face :inherit 'bold :foreground dark-cyan)
   (markdown-blockquote-face :foreground violet :background (doom-lighten bg 0.04))
   (markdown-table-face :foreground violet :background (doom-lighten bg 0.04))
   ((markdown-code-face &override) :foreground dark-cyan :background (doom-lighten bg 0.04))

   ;;; org-mode
   (org-hide :foreground hidden)
   (org-block :background (doom-darken base2 0.65))
   (org-block-begin-line :background (doom-darken base2 0.65) :foreground comments :extend t)
   (solaire-org-hide-face :foreground hidden)

   ;;; web-mode
   (web-mode-json-context-face :foreground brown)
   (web-mode-json-key-face :foreground teal)
   ;;;; Block
   (web-mode-block-delimiter-face :foreground yellow)
   ;;;; Code
   (web-mode-constant-face :foreground constants)
   (web-mode-variable-name-face :foreground variables)
   ;;;; CSS
   (web-mode-css-pseudo-class-face :foreground orange)
   (web-mode-css-property-name-face :foreground blue)
   (web-mode-css-selector-face :foreground teal)
   (web-mode-css-function-face :foreground yellow)
   ;;;; HTML
   (web-mode-html-attr-engine-face :foreground yellow)
   (web-mode-html-attr-equal-face :foreground operators)
   (web-mode-html-attr-name-face :foreground magenta)
   (web-mode-html-tag-bracket-face :foreground (doom-darken red 0.3))
   (web-mode-html-tag-face :foreground red))


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-tokyo-night-theme.el ends here

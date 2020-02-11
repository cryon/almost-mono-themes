;;; almost-mono-themes.el --- Almost monochromatic color themes -*- lexical-binding: t; -*-

;; Copyright (C) 2019, 2020 John Olsson

;; Author: John Olsson <john@cryon.se>
;; Maintainer: John Olsson <john@cryon.se>
;; URL: https://github.com/cryon/almost-mono-themes
;; Created: 9th May 2019
;; Version: 1.0.0
;; Keywords: faces
;; Package-Requires: ((emacs "24"))

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A suite of almost monochrome Emacs themes

;;; Code:

(defconst almost-mono-themes-colors
  '((white . ((background . "#ffffff")
	      (foreground . "#000000")
	      (weak	  . "#888888")
	      (weaker	  . "#dddddd")
	      (weakest    . "#efefef")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#3c5e2b")))

    (black . ((background . "#000000")
	      (foreground . "#ffffff")
	      (weak	  . "#aaaaaa")
	      (weaker	  . "#666666")
	      (weakest	  . "#222222")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#a7bca4")))

    (gray .  ((background . "#2b2b2b")
	      (foreground . "#ffffff")
	      (weak	  . "#aaaaaa")
	      (weaker	  . "#666666")
	      (weakest	  . "#222222")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#a7bca4")))

    (cream . ((background . "#f0e5da")
	      (foreground . "#000000")
	      (weak	  . "#7d7165")
	      (weaker	  . "#c4baaf")
	      (weakest    . "#dbd0c5")
	      (highlight  . "#fda50f")
	      (warning	  . "#ff0000")
	      (success	  . "#00ff00")
	      (string     . "#3c5e2b")))))

(defmacro almost-mono-themes--variant-with-colors (variant &rest body)
  "Execute BODY in a scope where the different colors for given VARIANT is bound."
  `(let* ((colors (or (cdr (assoc ,variant almost-mono-themes-colors))
		      (error "No such theme variant")))
	  (background (cdr (assoc 'background colors)))
	  (foreground (cdr (assoc 'foreground colors)))
	  (weak	      (cdr (assoc 'weak colors)))
	  (weaker     (cdr (assoc 'weaker colors)))
	  (weakest    (cdr (assoc 'weakest colors)))
	  (highlight  (cdr (assoc 'highlight colors)))
	  (warning    (cdr (assoc 'warning colors)))
	  (success    (cdr (assoc 'success colors)))
	  (string     (cdr (assoc 'string colors))))
     ,@body))

(defmacro almost-mono-themes--faces-spec ()
  "Provide the faces specification."
  (quote
   (mapcar
    (lambda (entry) (list (car entry) `((t ,@(cdr entry)))))
    `(

      ;; default
      (default (:background ,background :foreground ,foreground))
      (fringe  (:background ,background))
      (region  (:background ,highlight  :foreground ,foreground))
      (show-paren-match (:background ,background :foreground ,success :bold t))
      (show-paren-mismatch (:background ,background :foreground ,warning :bold t))
      (minibuffer-prompt (:weight bold :foreground ,foreground))
      (isearch (:background ,weak :foreground ,foreground :bold t))
      (lazy-highlight (:background ,weaker :foreground ,foreground))
      (link (:underline t))

      ;; mode line
      (mode-line (:box (:line-width -1 :color ,weaker)
		       :background ,weakest :foreground ,foreground))

      (mode-line-inactive (:box (:line-width -1 :color ,weaker)
				:background ,background :foreground ,weaker))

      ;; font lock
      (font-lock-keyword-face (:bold t))
      (font-lock-function-name-face (:bold t))
      (font-lock-variable-name-face (:foreground ,foreground))
      (font-lock-warning-face (:foreground ,foreground :underline (:color ,warning :style wave)))
      (font-lock-builtin-face (:bold t))
      (font-lock-variable-name-face (:foreground ,foreground :italic t))
      (font-lock-constant-face (:bold t :italic t))
      (font-lock-type-face (:italic t))
      (font-lock-preprocessor-face (:italic t))
      (font-lock-comment-face (:foreground ,weak :italic t))
      (font-lock-string-face (:foreground ,string))
      (font-lock-doc-face (:inherit font-lock-comment-face))
      (line-number (:foreground ,weaker))
      (linum (:inherit line-number))
      (vertical-border (:foreground ,weaker))

      ;; eshell
      (eshell-prompt (:foreground ,foreground :bold t))
      (eshell-ls-directory (:foreground ,foreground :bold t))
      (eshell-ls-archive (:inherit eshell-ls-unreadable))
      (eshell-ls-backup (:inherit eshell-ls-unreadable))
      (eshell-ls-clutter (:inherit eshell-ls-unreadable))
      (eshell-ls-executable (:inherit eshell-ls-unreadable))
      (eshell-ls-missing (:inherit eshell-ls-unreadable))
      (eshell-ls-product (:inherit eshell-ls-unreadable))
      (eshell-ls-readonly (:inherit eshell-ls-unreadable))
      (eshell-ls-special (:inherit eshell-ls-unreadable))
      (eshell-ls-symlink (:inherit eshell-ls-unreadable))

      ;; company mode
      (company-tooltip (:background ,weakest :foreground ,foreground))
      (company-tooltip-selection (:background ,weaker :foreground ,foreground))
      ;;(company-tooltip-search (:background "#ff0000" :foreground "#00ff00"))
      (company-tooltip-common (:bold t))
      (company-tooltip-common-selection (:bold t))
      (company-scrollbar-bg (:background ,weaker))
      (company-scrollbar-fg (:background ,weak))
      (company-tooltip-annotation-selection (:background ,weaker :foreground ,foreground :italic t))
      (company-tooltip-annotation (:background ,weakest :foreground ,weak :italic t))

      ;; git gutter
      (git-gutter:modified (:background ,highlight :foreground ,highlight))
      (git-gutter:added (:background ,success :foreground ,success))
      (git-gutter:deleted (:background ,warning :foreground ,warning))

      ;; hl line
      (hl-line (:background ,weakest))
      (highlight-current-line-face (:inherit hl-line))

      ;; ido
      (ido-first-match (:bold t))
      (ido-only-match (:bold t))
      (ido-subdir (:italic t))
      (ido-virtual (:foreground ,weak))
      (ido-vertical-match-face (:bold t :italic nil))

      ;; org mode
      (org-table (:foreground ,weak))

      ))))


(defun almost-mono-themes--variant-name (variant)
  "Create symbol for color theme variant VARIANT."
  (intern (format "almost-mono-%s" (symbol-name variant))))

(defmacro almost-mono-themes--define-theme (variant)
  "Define a theme for the almost-mono variant VARIANT."
  (let ((name (almost-mono-themes--variant-name variant))
        (doc (format "almost mono theme (%s version)" variant)))
    `(progn
       (deftheme ,name ,doc)
       (put ',name 'theme-immediate t)
       (almost-mono-themes--variant-with-colors
        ',variant
        (apply 'custom-theme-set-faces ',name
               (almost-mono-themes--faces-spec)))
       (provide-theme ',name))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
	       (file-name-as-directory (file-name-directory load-file-name))))

(provide 'almost-mono-themes)

;;; almost-mono-themes.el ends here

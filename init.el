;; .emacs.d/init.el


;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; ensure correct bash $PATH is used (for mac)
;; (exec-path-from-shell-initialize)

;; Add TeX distribution to the PATH
(setenv "PATH"
  (concat
   "/Library/TeX/texbin" ":"
   "~/.local/bin/" ":"
   (getenv "PATH")
  )
)

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    flycheck                        ;; On the fly syntax checking
    blacken                         ;; Black formatting on save
    ein                             ;; Emacs IPython Notebook
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages (uncomment for new install)
;; If the package listed is not already installed, install it
;; (mapc #'(lambda (package)
;;           (unless (package-installed-p package)
;;             (package-install package)))
;;       myPackages)




;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'mytheme t)             ;; My custom theme
(global-linum-mode t)               ;; Enable line numbers globally
(set-face-attribute 'default nil :height 120) ;; font size
(setq-default header-line-format 
              (list " " (make-string 79 ? ) "|")) ;; ruler, 79 lines

;; Set default virtual environment

;; Add this to exec-path, where packages are looked for. Does not currently work
;; (add-to-list 'exec-path "/Users/aph416/opt/anaconda3/bin")
(add-to-list 'exec-path "/Library/TeX/texbin")





;; ====================================
;; Development Setup
;; ====================================

;; Elpy≈el
(elpy-enable)

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; RefTeX
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-ref-macro-prompt nil)

;; Anaconda mode, alternative to elpy
;; (add-hook 'python-mode-hook 'anaconda-mode)

;; Activate virtual environment, elpy doesn't autocorrect otherwise
(require 'pyvenv)
(pyvenv-activate "~/opt/anaconda3/envs/calliope")


;; END
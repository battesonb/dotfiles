;; Move all emacs configuration into its own files/directories. Not all of this is committed to
;; source control.
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
(setq auto-save-file-name-transforms `((".*" ,(concat user-emacs-directory "auto-saves") t))
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backup"))))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; Behaviour changes
(setq vc-follow-symlinks t)
(setq inhibit-startup-screen t)
(menu-bar-mode (string-equal "darwin" system-type)) ;; Not as noisy on Mac
(tool-bar-mode 0)
(column-number-mode)
(global-display-line-numbers-mode)
(set-face-attribute 'default nil :height 180)

;; Add "Interactive Do" package for common completions
(require 'ido)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Replace M-x (execute-extended-command) with smex, if installed.
(if (featurep 'smex)
    (global-set-key (kbd "M-x") 'smex))

;; Multiple cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

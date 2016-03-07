; from emacsredux.com
(defun switch-to-previous-buffer()
  "Switch to previously open buffer"
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

; from stevey's 10 ways to improve ...
; alternative to alt-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "C-'") 'switch-to-previous-buffer)

; disable UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(defalias 'qrr 'query-replace-regexp)

; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . , temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))

; disables to create inter-lock file
(setq create-lockfiles nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(load-theme 'solarized-dark t)

; key-chord
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "oo" 'switch-to-previous-buffer)

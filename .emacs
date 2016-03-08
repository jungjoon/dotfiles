;; from emacsredux.com
(electric-indent-mode +1)
(electric-pair-mode +1)

(defun switch-to-previous-buffer()
  "Switch to previously open buffer"
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun smart-open-line ()
  "insert an empty line after the current line"
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun prelude-open-with (arg)
  "open visited file in default external program"
  "with prefix ARG always prompt for command to use"
  (interactive "p")
  (when buffer-file-name
    (shell-command (concat
		    (cond
		     ((and (not arg) (eq system-type 'windows-nt)) "start")
		     ((and (not arg) (eq system-type '(gnu gnu/linux))) "xdg-open")
		     (t (read-shell-command "Open current file with: "))) ; TODO check evaluation order
		    " "
		    (shell-quote-argument buffer-file-name)))))

(global-set-key (kbd "C-c o") 'prelude-open-with)

(defun copy-file-name-to-clipboard ()
  "copy the current buffer filename to clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
		      default-directory
		    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(global-set-key (kbd "C-c c") 'copy-file-name-to-clipboard)

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion ; what's this TODO
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(defun indent-defun ()
  "Indent the current defun."
  (interactive)
  (save-restriction ; what's this, what's diff with save-excursion TODO
    (widen)
    (narrow-to-defun)
    (indent-buffer)))

(global-set-key (kbd "C-M-z") 'indent-defun)

(defun run-google ()
  "goole the selected region if any, display query prompt otherwise"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=outf-8&q="
    (url-hexify-string (if mark-active
			   (buffer-substring (region-beginning) (region-end))
			 (read-string "Google: "))))))

(global-set-key (kbd "C-c g") 'run-google)

;; http://emacsredux.com/blog/2013/03/29/terminal-at-your-fingertips/
;; https://www.masteringemacs.org/article/running-shells-in-emacs-overview

;; http://emacsredux.com/blog/archives/    TODO restart at MAR 29 Terminal...
  

;; TODO read-shell-command vs read-string				     


;; from stevey's 10 ways to improve ...
;; alternative to alt-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "C-'") 'switch-to-previous-buffer)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key [(shift return)] 'smart-open-line)

;; disable UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(defalias 'qrr 'query-replace-regexp)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . , temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" , temporary-file-directory t)))

;; disables to create inter-lock file
(setq create-lockfiles nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(load-theme 'solarized-dark t)

;; key-chord
(require 'key-chord)
(key-chord-mode 1)

;; (key-chord-define-global "oo" 'switch-to-previous-buffer)

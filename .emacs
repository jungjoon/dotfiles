; from emacsredux.com
; (set-default-font "Terminus-16")
; (set-default-font "Iosevka 12")
(set-default-font "Inconsolata-14")
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
                     ((and (not arg) (eq system-type 'cygwin)) "cygstart")
                     ((and (not arg) (eq system-type '(gnu gnu/linux))) "xdg-open")
                     (t (read-shell-command "Open current file with: "))) ; TODO check evaluation order
                    " "
                    (shell-quote-argument buffer-file-name)))))

(global-set-key (kbd "C-c o") 'prelude-open-with)

(defun open-buffer-dir ()
  "run explorer on the directory of the current buffer"
  (interactive)
  (when buffer-file-name
    (shell-command (concat "explorer /select," (file-name-nondirectory (buffer-file-name))))))

(global-set-key (kbd "C-c d") 'open-buffer-dir)


(require 'thingatpt)
(require 'browse-url)

(defun lunch-by-go ()
  (interactive)
  (let ((needle (if (use-region-p)
                    (format "%s" (buffer-substring-no-properties (region-beginning) (region-end)))
                  (or (thing-at-point 'url)
                      (thing-at-point 'symbol)
                      (thing-at-point 'word)))))
    (shell-command (format "go \"%s\"" needle))
    (message needle)))


(global-set-key (kbd "C-c q") 'lunch-by-go)


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

(defun visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (ansi-term (getenv "SHELL")))
    (switch-to-buffer-other-window "*ansi-term*")))

(global-set-key (kbd "C-c t") 'visit-term-buffer)

(defun kill-other-buffers () ; TODO study
  "kill all buffers but the current one"
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))
;; TODO study second in ER, functional implmentation that uses dash package on emacsredux

(global-set-key (kbd "C-x K") 'kill-other-buffers)

(defun kill-buffer-other-window ()
  (interactive)
  (kill-buffer (window-buffer (next-window))))
;; TODO bind this and make it include close window (like "C-x 1"")

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-S-o") (lambda ()
                              (interactive)
                              (other-window -1)))
(global-set-key (kbd "C-1") 'delete-other-windows)


;; (global-set-key (kbd "C-x O") (lambda ()
;;                              (interactive)
;;                              (other-window -1)))

;; TODO consider below via C-S-b/f/p/n
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)

;;  playing with font sizes
;; TODO adjust font size in all frame github.com/purcell/emacs.d/init-fonts.el

(global-hl-line-mode +1)

;; TODO does this conflict with electric-pair-mode?
;; (require 'paren)
;; (setq show-paren-style 'parenthesis)
;; (show-paren-mode +1)

(defun move-line-up ()
  "move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift up)] 'move-line-up)
(global-set-key [(control shift down)] 'move-line-down)

(defun delete-file-and-buffer ()
  "kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "deleted file %s" filename)
          (kill-buffer))))))

(global-set-key (kbd "C-c D") 'delete-file-and-buffer)

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode +1)

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f") 'recentf-ido-find-file)


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

(global-set-key (kbd "C-<tab>") 'switch-to-previous-buffer)
;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)

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

;; key-chord
;(require 'key-chord)
; (key-chord-mode 1)

;(key-chord-define-global "oo" 'switch-to-previous-buffer)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;(load-theme 'solarized-dark t)
(load-theme 'zenburn t)

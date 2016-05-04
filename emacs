(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; Set the command (Apple) key as Meta
(setq mac-command-modifier 'meta)
(setq x-select-enable-clipboard t)
(setq mac-option-modifier nil)

;; Turn tabs off by default.
(setq-default intend-tabs-mode nil)

;; Set tab width to 4 by default.
(setq-default tab-width 4)

;; Use Lisp mode for .asd files.
(setq auto-mode-alist
      (cons '("\\.asd$" . lisp-mode)
            auto-mode-alist))

;; Use Python mode for .py files.
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode)
            auto-mode-alist))

(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))

;; Load Python mode.
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; Set up initialization parameters for python mode:
(setq python-mode-hook
      '(lambda () (progn
                    (set-variable 'py-indent-offset 4)
                    (set-variable 'py-smart-indentation nil)
                    (set-variable 'indent-tabs-mode nil) )))

;; Define untabify-buffer.
(defun untabify-buffer()
  (interactive)
  "Untabify the current buffer.  Return nil.

  Must return nil, if added to write-file-hooks."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (delete-region (match-beginning 0) (match-end 0)))
    (goto-char (point-min))
    (if (search-forward "\t" nil t)
        (untabify (1- (point)) (point-max))))
  nil)

;; Untabify buffers on write file.
(defun do-on-write-file()
  (untabify-buffer))

;; Add the hooks.
(add-hook 'write-file-hooks 'do-on-write-file)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;; Fix backspace for remote sessions
(global-set-key "\C-h" 'backward-delete-char)

;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq slime-contribs '(slime-fancy))


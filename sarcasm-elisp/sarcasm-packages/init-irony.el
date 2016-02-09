(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(defun sarcasm-irony-mode-hook ()
  (define-key irony-mode-map (kbd "C-c C-b") 'irony-cdb-menu)
  (define-key irony-mode-map (kbd "C-c =") 'irony-get-type))

(add-hook 'irony-mode-hook 'sarcasm-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0))
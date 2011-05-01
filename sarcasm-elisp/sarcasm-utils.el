;; Utility functions -- Guillaume Papin
;; usage:
;; (require 'sarcasm-utils)

(defun align-region-or-current ()
  "If a region is active align the region, otherwise align at
point."
  (interactive)
  (if mark-active
      (align (region-beginning) (region-end))
    (align-current))
  )

(defun c-man (NAME)
  "Find the C manual page corresponding to the function NAME.
Search for man(2) and man(3) by default."
  (if (file-exists-p (concat "/usr/share/man/man2/" NAME ".2.gz"))
      (man (concat NAME "(2)"))
    (if (file-exists-p (concat "/usr/share/man/man3/" NAME ".3.gz"))
	(man (concat NAME "(3)"))
      (man NAME)))
  )

(defun c-man-at-point ()
  "Find a C man page with the current word if present, otherwise
require input from user."
  (interactive)
  (when (not (setq cur-word (current-word)))
    (setq cur-word (read-from-minibuffer "Man Page: ")))
  (if (string= "" cur-word)
      (message "No man args given")
    (c-man cur-word))
  )

;; Miscellaneous functions for compilation
(defun flymake-or-compile-next-error ()
  "If Flymake mode is enable then go to the next Flymake error,
otherwise assume it's compile next error."
  (interactive)
  (if flymake-mode
      (flymake-goto-next-error)
    (next-error))
  )

(defun flymake-or-compile-prev-error ()
  "If Flymake mode is enable then go to the previous Flymake error,
otherwise assume it's compile previous error."
  (interactive)
  (if flymake-mode
      (flymake-goto-prev-error)
    (previous-error))
  )

;; Source: http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/75dd91fd45742d54?pli=1
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(provide 'sarcasm-utils)
(use-package magit
  :ensure t
  :bind (("C-c x m" . magit-status)
         :map magit-mode-map
         (">" . magit-push)
         ("<" . magit-pull))
  :init (setq magit-diff-arguments '("--no-ext-diff" "-M")
              magit-diff-section-arguments '("--no-ext-diff" "-M"
                                             "--diff-algorithm=patience")
              magit-diff-refine-hunk t))

;; This package is very useful to write commit messages.
;; Enabling `global-git-commit-mode' incurs a noticeable cost on startup,
;; since the purpose of this configuration is to commit from the command line
;; the best is to set core.editor to something like this:
;;     git config --global core.editor "emacs -nw --eval '(global-git-commit-mode)'"
(use-package git-commit
  :ensure t
  :defer t)

;; This sets up the load path so that we can override it

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)
(setq package-enable-at-startup nil)
(org-babel-load-file "~/.emacs.d/gfanton.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:separator-sign " ")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(php-extras php-mode impatient-mode color-identifiers-mode tiny pretty-symbols hl-line+ volatile-highlights powerline solarized-theme spacemacs-theme material-theme monokai-theme color-theme helm-emmet helm-gtags helm-google helm spray e2wm-direx e2wm projectile dired+ string-inflection neotree lorem-ipsum git-gutter magit-filenotify magit linum-relative flycheck key-chord skeletor company-edbi edbi visual-regexp-steroids pcre2el visual-regexp multiple-cursors eimp emmet-mode yasnippet company-web company pos-tip color-moccur bookmark+ imenus ido-ubiquitous ace-window ace-jump-mode undo-tree buffer-move ggtags ctags comment-dwim-2 rebox2 achievements auto-compile dash use-package)))
 '(vr/engine (quote pcre2el)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

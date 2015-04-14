
;; Personal information
;; initialize personal information

(setq user-full-name "Guilhem Fanton"
user-mail-address "guilhem.fanton@gmail.com")

;; Encodage
;;    Set =utf-8= as preferred coding system.

(set-language-environment "UTF-8")

;; Add package sources

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-refresh-contents))

;; init packages

(add-to-list 'load-path "~/elisp")
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)
(use-package dash
  :ensure t)
(use-package auto-compile
  :ensure t
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;; MAC OSX

(when (memq window-system '(mac ns))
  (setq mac-option-modifier nil
        mac-command-modifier 'meta
        x-select-enable-clipboard t)
  (exec-path-from-shell-initialize))

;; private

(load "~/.emacs.private" t)

;; load custom el files

;;(add-to-list 'load-path "~/elisp")

;; Windows

(when window-system
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1))

;; Color Theme

;; Monokai Color Theme

(use-package color-theme
        :ensure t
        :init (use-package monokai-theme :ensure t)
        :config (load-theme 'monokai t))

;; font

;; Use the Inconsolata font if it’s installed on the system.

(when (member "Inconsolata" (font-family-list))
  (set-face-attribute 'default nil :font "Inconsolata-14"))

;; undo-tree

(use-package undo-tree
  :defer t
  :ensure t
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

;; winner-mode

(use-package winner
  :ensure t
  :defer t
  :config (winner-mode 1))

;; Ido

;; install ido

(use-package ido
  :config
  (progn
  (ido-mode 1)
  (ido-everywhere 1)
  (setq ido-default-buffer-method 'selected-window)
  (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
  (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
  (defun ido-sort-mtime ()
    (setq ido-temp-list
          (sort ido-temp-list
                (lambda (a b)
                  (let ((ta (nth 5 (file-attributes (concat ido-current-directory a))))
                        (tb (nth 5 (file-attributes (concat ido-current-directory b)))))
                    (if (= (nth 0 ta) (nth 0 tb))
                        (> (nth 1 ta) (nth 1 tb))
                      (> (nth 0 ta) (nth 0 tb)))))))
    (ido-to-end  ;; move . files to end (again)
     (delq nil (mapcar
                (lambda (x) (if (string-equal (substring x 0 1) ".") x))
                ido-temp-list))))))

;; ido ubiquitous

(use-package ido-ubiquitous
        :ensure t
        :init
        (setq org-completion-use-ido t)
        (setq magit-completing-read-function 'magit-ido-completing-read)
        :config
        (ido-ubiquitous-mode 1))

;; History

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Copy and Past

(when (memq window-system '(mac ns))
        (setq x-select-enable-clipboard t)
        (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))

;; Whitespace

;; No whitespace at the end of the line

(defun del-end-whitespace ()
  "Deletes all blank lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines)
      (let ((trailnewlines (abs (skip-chars-backward "\n\t"))))
      (if (> trailnewlines 1)
          (progn
                (delete-char trailnewlines)))))))

;; auto-complete

(use-package company
  :ensure t 
  :config
  (add-hook 'prog-mode-hook 'company-mode))

;; tabbar

;; tabbar mode

(use-package tabbar
        :ensure t
        :config

(set-face-attribute
 'tabbar-default nil
 :background "gray20"
 :foreground "gray20"
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 1 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "#A41F99"
 :box '(:line-width 1 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 1 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :background "grey20"
 :height 0.1)

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs
(custom-set-variables
 '(tabbar-separator (quote (0.5))))
;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format " [%s] " (tabbar-tab-tabset tab))
                  (format " %s " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))
(tabbar-mode t)
)

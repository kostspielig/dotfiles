;;
;; Emacs config file - Maria Carrasco
;;


(server-start)
(remove-hook 'kill-buffer-query-functions
	     'server-kill-buffer-query-function)

(defun author-name  () "Maria Carrasco")
(defun author-email () "kostspielig@gmail.com")

(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(add-to-list 'load-path (expand-file-name "~/.guix-profile/share/emacs/site-lisp"))
(require 'guix-autoloads nil t)

(fset 'xterm-color-unfontify-region 'font-lock-default-unfontify-region)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(require 'init-generic)
(require 'init-mail)
(require 'init-devel)
(require 'init-keys)

(desktop-save-mode 1)
(add-hook 'find-file-hook 'desktop-auto-save-set-timer)
(add-hook 'after-save-hook 'desktop-auto-save-set-timer)
(put 'upcase-region 'disabled nil)

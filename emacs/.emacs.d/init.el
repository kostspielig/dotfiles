;;
;; GNU Emacs configuration file
;; ----------------------------
;;
;;   Author: Juan Pedro Bolivar Puente
;;

(server-start)
(remove-hook 'kill-buffer-query-functions
	     'server-kill-buffer-query-function)

(defun author-name  () "Maria Carrasco")
(defun author-email () "kostspielig@gmail.com")

(add-to-list 'load-path (expand-file-name "~/.emacs.d/jpb"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install"))
(add-to-list 'load-path (expand-file-name "~/.guix-profile/share/emacs/site-lisp"))
(require 'guix-autoloads nil t)

;;(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/lisp/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(require 'jpb-generic)
(require 'jpb-mail)
(require 'jpb-devel)
(require 'jpb-cpp11)
(require 'jpb-keys)

(desktop-save-mode 1)
(add-hook 'find-file-hook 'desktop-auto-save-set-timer)
(add-hook 'after-save-hook 'desktop-auto-save-set-timer)

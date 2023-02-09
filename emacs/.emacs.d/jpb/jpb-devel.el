;;
;; GNU Emacs configuration file
;; ----------------------------
;;
;;   Author: Juan Pedro Bolívar Puente
;;

(defun jpb-fill-mode ()
  (setq fill-column 80)
  (fci-mode))

(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; GIT
;;
;; (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)

;;
;; Yasnippet
;;

;;(require 'yasnippet)
;;(yas-global-mode 1)

;;
;; Python
;;
(add-hook 'python-mode-hook 'flycheck-mode)


;; flycheck
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

;;
;; Compilation
;;

(require 'compile)
(setq compilation-window-height 12)

(defun compile-here ()
  "Set the compilation directory to the current one"
  (interactive)
  (setq compile-command
	(concat "cd " (file-name-directory (buffer-file-name)) "; make")))

(defun compile-this ()
  "Set the compile command to make this file if there is no makefile around"
  (interactive)
  (unless (or (file-exists-p "makefile")
	      (file-exists-p "Makefile"))
    (set (make-local-variable 'compile-command)
	 (concat "make -k "
		 (file-name-sans-extension (buffer-file-name))))))

(defun compile-at (str)
  "Set the compile command to build a selected directory"
  (interactive "DCompilation directory: ")
  (setq gud-gdb-command-name
        (concat "cd " str "; gdb -i=mi"))
  (setq compile-command
	(concat "cd " str "; make")))

(defun compile-leave ()
  (interactive)
  (setq compilation-finish-function nil))

(defun compile-close ()
  (interactive)
  (setq compilation-finish-function
	(lambda (buf str)
	  (if (string-match "exited abnormally" str)
	      (message "Compilation errors, press C-x ` to visit")
	    (run-at-time 0.5 nil 'delete-windows-on buf)
	    (message "NO COMPILATION ERRORS :-)")))))

;;
;; Debug
;;

(defun gdb-file (fname)
  "Set the compile command to build a selected directory"
  (interactive "fExecutable: ")
  (gdb (concat "gdb -i=mi " fname)))

;; Force gdb-mi to not dedicate any windows
(defadvice gdb-display-buffer
    (after undedicate-gdb-display-buffer)
  (set-window-dedicated-p ad-return-value nil))
(ad-activate 'gdb-display-buffer)

(defadvice gdb-set-window-buffer
    (after undedicate-gdb-set-window-buffer
           (name &optional ignore-dedi window))
  (set-window-dedicated-p window nil))
(ad-activate 'gdb-set-window-buffer)

;;
;; Formatings
;;

; style I want to use in c++ mode
(c-add-style "jpb"
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
                                   (innamespace . 0)
				   (statement-case-open . +)))))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-style "jpb")))

(add-hook 'php-mode-hook
          (lambda ()
            (c-set-style "bsd")
            (setq c-basic-offset 4)
            (c-set-offset 'innamespace 0)
            (setq indent-tabs-mode nil)))

(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

(add-hook 'c-mode-common-hook #'auto-fill-mode)

(defun jpb-enable-cpp-headers ()
  (interactive)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)))

(defun jpb-disable-cpp-headers ()
  (interactive)
  (setq auto-mode-alist (remove '("\\.h\\'" . c++-mode) auto-mode-alist)))

;;
;; QML
;;

(add-to-list 'auto-mode-alist '("\\.qml\\'" . js-mode))

;;
;; Gtags
;;

(defun gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun gtags-update ()
  "Make GTAGS incremental update"
  (interactive)
  (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
    (when (gtags-root-dir)
      (gtags-update)))

;; Not needed, ggtags takes care of this now...
;;   (add-hook 'after-save-hook #'gtags-update-hook)

(defun compile-gtags (str)
  "compile etags for the current project"
  (interactive "DSources directory: ")
  (compile (concat "cd " (expand-file-name str) "; gtags")))

;;
;; Rainbow
;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'c-mode-common-hook 'rainbow-delimiters-mode)

;;
;; Update copyright
;;

(add-hook 'before-save-hook 'copyright-update)

(add-to-list 'compilation-error-regexp-alist '("^In file \\(.*?\\):\\([0-9]+\\)$" 1 2))
(add-to-list 'compilation-error-regexp-alist '("^    #[0-9]+ 0x[[:xdigit:]]+ in .* \\(.*?\\):\\([0-9]+\\)$" 1 2))

;;
;; Web mode
;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . web-mode))

(setq web-mode-content-types-alist
      '(("javascript"    . "\\.es6\\'")))

;;(add-to-list 'load-path "~/.nvm/versions/node/v16.8.0/bin")
;;(add-hook 'web-mode-hook (lambda () (tern-mode t)))

;;(with-eval-after-load 'company
;;  (add-to-list 'company-backends 'company-tern))

;; disable jshint since we prefer eslint checking
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint))))

;; use eslint with web-mode for jsx files
(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'web-mode))

;;
;; Rust
;;
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)



;;
;; Go
;;
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-go))
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode 0)))
(add-hook 'go-mode-hook 'go-eldoc-setup)
(setq company-go-gocode-command "~/go/bin/gocode")
(setq go-eldoc-gocode "~/go/bin/gocode")
(setq godef-command "~/go/bin/gocode")


;;
;; Scala
;;

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
  ;; (optional) Automatically start metals for Scala files.
  :hook (scala-mode . eglot-ensure))

;;
;; Typescript
;;

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescript-mode))

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-e") 'ts-send-last-sexp)
            (local-set-key (kbd "C-M-x") 'ts-send-last-sexp-and-go)
            (local-set-key (kbd "C-c b") 'ts-send-buffer)
            (local-set-key (kbd "C-c C-b") 'ts-send-buffer-and-go)
            (local-set-key (kbd "C-c l") 'ts-load-file-and-go)))


(provide 'jpb-devel)

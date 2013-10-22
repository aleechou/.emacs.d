(add-to-list 'load-path user-emacs-directory)

;; session
(require 'init-sessions)

;; tomorrow theme
(add-to-list 'load-path "~/.emacs.d/el-get/color-theme/")
(require 'color-theme)
(load "~/.emacs.d/el-get/color-theme-tomorrow/GNU Emacs/color-theme-tomorrow.el")
(eval-after-load "color-theme"
  '(progn
      (color-theme-tomorrow-night)))


;; 显示行号
(global-linum-mode 1)


;; browse kill ring
(add-to-list 'load-path "~/.emacs.d/el-get/browse-kill-ring/")
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)


;; el-get 
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)



;; coffee mode
(define-key coffee-mode-map (kbd "C-M-x") 'coffee-compile-file)

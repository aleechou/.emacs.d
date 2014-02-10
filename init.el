
(add-to-list 'load-path user-emacs-directory)

;; 编辑远程文件
(require 'tramp)

;; 
(set-clipboard-coding-system 'ctext)


;; evil
(add-to-list 'load-path "~/.emacs.d/evil") 
(require 'evil) 
(evil-mode 1) ; 

(setq evil-default-state 'emacs) 
(define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state) 

;; expand-region
(add-to-list 'load-path "~/.emacs.d/el-get/expand-region/")
(require 'expand-region)
(global-set-key (kbd "M-=") 'er/expand-region)

;; session
(require 'init-sessions)

;; tomorrow theme
(add-to-list 'load-path "~/.emacs.d/el-get/color-theme/")
(require 'color-theme)
(load "~/.emacs.d/el-get/color-theme-tomorrow/GNU Emacs/color-theme-tomorrow.el")
(eval-after-load "color-theme"
  '(progn
      (color-theme-tomorrow-night)))

;; 高亮光标所在行
(require 'hl-line)
(global-hl-line-mode 1)

;; 选区替换
(delete-selection-mode 1)

;; enable showparenmode
(setq show-paren-delay 0)
;(setq show-paren-style 'parenthesis)
;(setq show-paren-style 'expression)
(setq show-paren-style 'mixed)
(show-paren-mode t)


;; yank pop forwards
(defun yank-pop-forwards (arg)
      (interactive "p")
      (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards)
(global-set-key "\M-V" 'yank-pop-forwards)
;; only press one time M-y
(defadvice yank-pop (around yank (arg))
   "If last action was not a yank, run `yank' instead."
   (if (not (eq last-command 'yank))
       (yank)
     ad-do-it))
 (ad-activate 'yank-pop)


;; copy region or whole line
(defun kill-ring-save-or-whole-line ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line"))))
(global-set-key "\M-w" 'kill-ring-save-or-whole-line)

;; kill region or whole line
(defun kill-region-or-whole-line ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line"))))
(global-set-key "\C-w" 'kill-region-or-whole-line)

;; bind m-c m-v
(global-set-key "\M-c" 'kill-ring-save-or-whole-line)
(global-set-key "\M-v" 'yank-pop)


;; 防止鼠标滚动太快
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2)((control)))
mouse-wheel-progressive-speed nil
scroll-step 2)


;; ibuffer
(setq ibuffer-filter-group-name-face 'font-lock-doc-face)
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; 显示行号
(global-linum-mode 1)


;; % 跳到匹配的括号(仅圆括号)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;; undo tree
(add-to-list 'load-path "~/.emacs.d/el-get/undo-tree/")
(require 'undo-tree)
(global-undo-tree-mode)

;; 做个记号
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))
(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

;; M-s 保存buffer
(global-set-key (kbd "M-s") 'save-buffer)

;;关闭自动保存模式
(setq auto-save-mode nil)
;;不生成 #filename# 临时文件
(setq auto-save-default nil)
;; xxx~
(setq make-backup-files nil)

;; browse kill ring
(add-to-list 'load-path "~/.emacs.d/el-get/browse-kill-ring/")
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
;; (browse-kill-ring-default-keybindings)


;; 隐藏菜单
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")


;; 自动插入
(add-to-list 'load-path "~/.emacs.d/el-get/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/el-get/yasnippet/snippets"))
(yas-global-mode 1)


;; 没有提示音
(setq ring-bell-function 'ignore)


;; last change pos
(defvar feng-last-change-pos nil)
(defun feng-buffer-change-hook (beg end len)
  (when (and (> end beg) (buffer-file-name))
    (setq feng-last-change-pos (cons (buffer-file-name) end))))
(defun feng-goto-last-change ()
  (interactive)
  (if feng-last-change-pos
      (let ((file (car feng-last-change-pos)))
        (unless (eq (buffer-file-name) file)
          (let* ((buffer (find-file-noselect file))
                 (win (get-buffer-window buffer)))
            (if win
                (select-window win)
              (find-file file))))
        (goto-char (cdr feng-last-change-pos))
        (message "Last Edit Location"))
    (message "No Change")))


;; auto-complete
(add-to-list 'load-path "~/.emacs.d/el-get/popup")
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete")
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)


;; el-get 
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)



;; coffee mode
(add-to-list 'load-path "~/.emacs.d/el-get/coffee-mode")
(require 'coffee-mode)
(define-key coffee-mode-map (kbd "C-M-x") 'coffee-compile-file)


;; lua mode
(add-to-list 'load-path "~/.emacs.d/el-get/lua-mode")
(require 'lua-mode)


;; 为 eshell 设置 $PATH
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))


;; 调整竖分窗口的大小
(global-set-key "\C-V" 'shrink-window)
(global-set-key "\C-^" 'enlarge-window)
(global-set-key (kbd "C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-}") 'enlarge-window-horizontally)

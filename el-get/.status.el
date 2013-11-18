((browse-kill-ring status "installed" recipe
		   (:name browse-kill-ring :description "Interactively insert items from kill-ring" :type emacswiki :features browse-kill-ring))
 (coffee-mode status "installed" recipe
	      (:name coffee-mode :website "http://ozmm.org/posts/coffee_mode.html" :description "Emacs Major Mode for CoffeeScript" :type github :pkgname "defunkt/coffee-mode" :features coffee-mode :post-init
		     (progn
		       (add-to-list 'auto-mode-alist
				    '("\\.coffee$" . coffee-mode))
		       (add-to-list 'auto-mode-alist
				    '("Cakefile" . coffee-mode))
		       (setq coffee-js-mode 'javascript-mode))))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-tomorrow status "installed" recipe
		       (:name color-theme-tomorrow :description "Emacs highlighting using Chris Charles's Tomorrow color scheme" :type github :pkgname "ccharles/Tomorrow-Theme" :depends color-theme :prepare
			      (progn
				(autoload 'color-theme-tomorrow "GNU Emacs/color-theme-tomorrow" "color-theme: tomorrow" t)
				(autoload 'color-theme-tomorrow-night "GNU Emacs/color-theme-tomorrow" "color-theme: tomorrow-night" t)
				(autoload 'color-theme-tomorrow-night-eighties "GNU Emacs/color-theme-tomorrow" "color-theme: tomorrow-night-eighties" t)
				(autoload 'color-theme-tomorrow-night-blue "GNU Emacs/color-theme-tomorrow" "color-theme: tomorrow-night-blue" t)
				(autoload 'color-theme-tomorrow-night-bright "GNU Emacs/color-theme-tomorrow" "color-theme: tomorrow-night-bright" t))))
 (css-mode status "installed" recipe
	   (:name css-mode :description "Minor mode for CSS" :features css-mode :type elpa))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (expand-region status "required" recipe nil)
 (js2-mode status "installed" recipe
	   (:name js2-mode :website "https://github.com/mooz/js2-mode#readme" :description "An improved JavaScript editing mode" :type github :pkgname "mooz/js2-mode" :prepare
		  (autoload 'js2-mode "js2-mode" nil t)))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin 24 :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 '(("ELPA" . "http://tromey.com/elpa/")
			   ("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (session status "installed" recipe
	  (:name session :description "When you start Emacs, package Session restores various variables (e.g., input histories) from your last session. It also provides a menu containing recently changed/visited files and restores the places (e.g., point) of such a file when you revisit it." :type http-tar :options
		 ("xzf")
		 :load-path
		 ("lisp")
		 :url "http://downloads.sourceforge.net/project/emacs-session/session/2.2a/session-2.2a.tar.gz" :autoloads nil))
 (undo-tree status "installed" recipe
	    (:name undo-tree :description "Treat undo history as a tree" :type git :url "http://www.dr-qubit.org/git/undo-tree.git" :prepare
		   (progn
		     (autoload 'undo-tree-mode "undo-tree.el" "Undo tree mode; see undo-tree.el for details" t)
		     (autoload 'global-undo-tree-mode "undo-tree.el" "Global undo tree mode" t)))))

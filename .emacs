;;(package-initialize)

;; Not necessary in Emacs 27
;;(server-start)

;; Remove annoying warning in Emacs 27
;;(setq byte-compile warnings '(cl-functions))

;; Try to fix 'AUCTex can't find TeX distribution thing
(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)

;; For custom themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(add-to-list 'load-path "~/GIT/")
;; org-present: https://github.com/rlister/org-present
;; (add-to-list 'load-path "~/GIT/org-present")
;; (autoload 'org-present "org-present" nil t)

;; (eval-after-load "org-present"
;;   '(progn
;;      (add-hook 'org-present-mode-hook
;;                (lambda ()
;;                  (org-present-big)
;;                  (org-display-inline-images)
;;                  (org-present-hide-cursor)
;;                  (org-present-read-only)))
;;      (add-hook 'org-present-mode-quit-hook
;;                (lambda ()
;;                  (org-present-small)
;;                  (org-remove-inline-images)
;;                  (org-present-show-cursor)
;;                  (org-present-read-write)))))

(pdf-tools-install)
;;(add-hook 'prog-mode-hook 'linum-on)
(setq pdf-view-midnight-colors '("#f6f3e8" . "#242424"))

(global-set-key (kbd "C-x C-b") 'ibuffer)

(desktop-save-mode 1)
;; Need to have to to ensure title-bar can be read with desktop-save-mode enabled
;;(add-to-list 'frameset-filter-alist '(ns-transparent-titlebar . :never))
(add-to-list 'frameset-filter-alist '(ns-appearance . :never))

(setq load-prefer-newer t)

;; https://zhongweiy.github.io/blog/2016/02/03/solve-error-emacs-not-compiled-with-dbus-support/
;; Terminal notifier 
;; requires 'brew install terminal-notifier'
;; stolen from erc-notifier

(defvar terminal-notifier-command (executable-find "terminal-notifier") "/usr/local/bin/terminal-notifier")

; (terminal-notifier-notify "Emacs notification" "Something amusing happened")

(defun terminal-notifier-notify (title message)
  "Show a message with 
terminal-notifier-command
."
  (start-process "terminal-notifier"
                 "terminal-notifier"
                 terminal-notifier-command
                 "-title" title
                 "-message" message
                 "-sender" "org.gnu.Emacs"))

(defun timed-notification (time msg)
  (interactive "sNotification when (e.g: 2 minutes, 60 seconds, 3 days): \nsMessage: ")
  (run-at-time time nil (lambda (msg) (terminal-notifier-notify "Emacs" msg)) msg))

;; auto-revert TeX pdfs
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(add-hook 'TeX-mode-hook #'olivetti-mode)
(add-hook 'TeX-mode-hook #'latex-extra-mode)

;; auto-revert
(add-hook 'PDFview-mode-hook #'auto-revert-mode)

;; smartparens
(require 'smartparens-config)

(add-hook 'TeX-mode-hook #'smartparens-mode)
(add-hook 'org-mode-hook #'smartparens-mode)
(add-hook 'python-mode #'smartparens-mode)
(add-hook 'ess-mode #'smartparens-mode)
(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(add-hook 'Shell-script #'smartparens-mode)

;;;;Org mode configuration

;; org-mac-iCal
;; https://github.com/ndw/org-mac-iCal
;; (load-file "~/GIT/org-mac-iCal/org-mac-iCal.el")
;; (add-to-list 'org-modules 'org-mac-iCal)
;; (setq org-agenda-include-diary t)

;; (setq org-agenda-custom-commands
;;       '(("I" "Import diary from iCal" agenda ""
;;          ((org-agenda-mode-hook
;;            (lambda ()
;;              (org-mac-iCal)))))))

;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO" "IN PROGRESS" "WAITING" "FEEDBACK" "|" "DONE" "DELEGATED" "CANCELED")))
(setq org-todo-keyword-faces
      '(;;("TODO" . (:foreground "#FA8072" :weight bold))
	("IN PROGRESS" . "#E35DBF")
	("WAITING" . "#e6e600")
	("FEEDBACK" . "#cccc00")
	("DELEGATED" . "#4dffff")
	("CANCELED" . "#008080")))
(setq org-indent-indentation-per-level 1)
(setq org-clock-sound "~/dotfiles/ding.wav")

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; (add-hook 'org-mode-hook 'org-superstar-mode)

;; (use-package org-superstar
;;   :hook (org-mode . org-superstar-mode))

(setq org-show-notification-handler
      (lambda (msg) (timed-notification nil msg)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '((output-dvi "PDF Tools")
     (output-pdf "PDF Tools")
     (output-html "open")))
 '(ado-stata-flavor "StataBE")
 '(ado-stata-home "/Applications/Stata/")
 '(ado-submit-default "include")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(bibtex-completion-format-citation-functions
   '((org-mode . bibtex-completion-format-citation-org-link-to-PDF)
     (latex-mode . bibtex-completion-format-citation-cite)
     (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
     (python-mode . bibtex-completion-format-citation-sphinxcontrib-bibtex)
     (rst-mode . bibtex-completion-format-citation-sphinxcontrib-bibtex)
     (default . bibtex-completion-format-citation-default)))
 '(blink-cursor-mode nil)
 '(cua-auto-tabify-rectangles nil)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("5c1ee7ccff80c475715b2fc60ba8c4edbebdc25b229fab8fc6ce7238b809a026" "a0415d8fc6aeec455376f0cbcc1bee5f8c408295d1c2b9a1336db6947b89dd98" "3b69ddebc3b1386c63e70afa0eca90d1a775c52ad144d16df932400f3afe1c30" "728f4c6074723658cf6497cf09b4918a6a93ff5a09332b715e8983dfba4e2e40" "969623ec31d614ba347cf0d47641d9d2829b57d9593a7b47c0887a5ea8202688" "3b050147ba211a3711c5421d8c98078b75e983261873548e36fe477d83443b56" "9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" "3860a842e0bf585df9e5785e06d600a86e8b605e5cc0b74320dfe667bcbe816c" default))
 '(display-fill-column-indicator-column 80)
 '(doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode latex-mode))
 '(doom-modeline-enable-word-count t)
 '(elfeed-feeds '("https://www.reddit.com/r/emacs/"))
 '(elpy-rpc-python-command "python3")
 '(global-linum-mode nil)
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(line-number-mode nil)
 '(markdown-command "/usr/local/bin/pandoc")
 '(menu-bar-mode t)
 '(ns-auto-hide-menu-bar nil)
 '(olivetti-body-width nil)
 '(olivetti-style 'fancy)
 '(org-agenda-custom-commands
   '(("n" "Agenda and all TODOs"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)))
 '(org-agenda-files
   '("~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/TODO.org" "/Users/patrickgauding/Documents/research/admin/TODO-summer-2022.org" "/Users/patrickgauding/Documents/research/dissertation/TODO/final-formatting.org" "/Users/patrickgauding/Documents/research/dissertation/TODO/diffusion-TODO.org" "/Users/patrickgauding/Documents/research/dissertation/TODO/PO-TODO.org" "/Users/patrickgauding/Documents/research/dissertation/TODO/admin-TODO.org"))
 '(org-babel-load-languages '((emacs-lisp . t) (R . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-file-apps
   '((auto-mode . emacs)
     (directory . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . emacs)))
 '(org-mac-iCal-calendar-names '("iCloud" "KU Mail"))
 '(org-mac-iCal-import-exchange t)
 '(org-support-shift-select t)
 '(package-selected-packages
   '(puni quarto-mode dirvish org-mime mu4e-marker-icons mu4e-views esup org-superstar org-msg lorem-ipsum modus-themes pandoc-mode diredful command-log-mode org-bullets buffer-move imenu-list all-the-icons-dired elfeed hyperbole lsp-ui latex-extra move-text fancy-battery smartparens vertico marginalia helm-bibtex org-noter org-modern doom-modeline mood-line flyspell-correct vline all-the-icons-completion unfill treemacs pdf-tools writeroom-mode olivetti jupyter origami which-key org-caldav flycheck-stan flycheck lsp-mode folding lua-mode ox-odt org-tree-slide org-roam-bibtex org-roam org-ref deft linum-relative tablist company-jedi jedi elpy iedit python-mode exec-path-from-shell org-pomodoro company-auctex auctex company ess binder vterm use-package magit neotree org-cua-dwim org-beautify-theme mbsync offlineimap engine-mode anaconda-mode synosaurus god-mode gnu-elpa-keyring-update poly-R poly-markdown polymode julia-shell julia-repl julia-mode markdown-mode ein stan-snippets stan-mode ace-window grandshell-theme))
 '(python-guess-indent nil)
 '(python-indent 4)
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(python-shell-completion-native-disabled-interpreters '("ipython"))
 '(scroll-bar-mode nil)
 '(send-mail-function 'mailclient-send-it)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(button ((t nil))))

(add-hook 'after-init-hook (lambda () (load-theme 'wombat t)))
(setq ring-bell-function 'ignore)

(global-set-key (kbd "M-p") 'ace-window)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit)

(setq column-number-mode t)

;; for .srt files
(use-package subed
  ;; Tell emacs where to find subed
  :load-path "~/.emacs.d/elisp/"
  :config
  ;; Disable automatic movement of point by default
  (add-hook 'subed-mode-hook 'subed-disable-sync-point-to-player)
  ;; Remember cursor position between sessions
  (add-hook 'subed-mode-hook 'save-place-local-mode)
  ;; Break lines automatically while typing
  (add-hook 'subed-mode-hook 'turn-on-auto-fill)
   ;; Break lines at 40 characters
  (add-hook 'subed-mode-hook (lambda () (setq-local fill-column 40))))

;; (use-package pdf-tools
;;   :config
;;   (linum-mode -1))

;; Paul Johnson
;; 2015-10-01
;;
;; This version? 2015-10-01?
;; I ran into some trouble swapping various versions of ESS in
;; my user directory, so I started tearing this apart. Cutting out
;; stuff I don't remember.
;;
;; My init file alters user interaction with R via ESS. Most
;; importantly
;; 1. *R* should start in its own frame
;; 2. S-[Return] is hot key to send line to *R*. This replaces
;;    now default C-[Return].  I need this to protect CUA
;;    mode rectangle selection
;; 3. General Emacs settings discourage "frame splitting" that
;;    the usual Emacs users seem to like.
;; 4. Slight simplification of the menu under File. I don't see
;;    need for separate "create" and "open" choices. So I put them
;;    together
;; 5. See next paragraph about the MELPA package manager
;;
;; See my companion lecture
;; "Emacs Has No Learning Curve"
;; http://pj.freefaculty.org/guides/Rcourse
;;
;; 2015-03-02
;; Following allows use of Emacs24 package manager.
;; To use, run emacs, then do
;; M-x list-packages
;; To see everything available at that moment on melpa.
;; After that, seriously consider installing ess-smart-underscore.
;; M-x package-refresh-contents
(when (>= emacs-major-version 24)
  (require 'package)
  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
    ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
    (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
  )
;; (package-initialize)
;;   (package-initialize)
;;   (add-to-list 'package-archives
;; 	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; )

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/" t))
;; (add-to-list 'package-archives
;; 	     '("melpa" . "http://melpa.org/packages/") t))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))


(require 'stan-mode)

;; Some python things I use, you may not need
;; Update 20220116 - deprecating to try to get to co-op with Python3
;; (setq python-shell-interpreter "ipython3")
;; (setq py-python-command "python3")

;; (autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python3" . python-mode))

;; https://www.youtube.com/watch?v=jPXIP46BnNA
(use-package python-mode
  :ensure nil
  :custom
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "-i --simple-prompt"))

;; (package-initialize)
(elpy-enable) 
;; https://github.com/jorgenschaefer/elpy/issues/1757
(setq elpy-rpc-pythonpath (file-name-directory (locate-library "elpy")))
;; Deprecated
;;(elpy-use-ipython)

;; use flycheck not flymake with elpy
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;; (require py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'ess-site)
;; soft require: no error if package not found
(require 'ess-smart-underscore nil 'noerror)

(add-to-list 'auto-mode-alist '("\\..md" . poly-markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))



;; Org-mode with R doesn't work without this
;; http://orgmode.org/worg/org-contrib/babel/how-to-use-Org-Babel-for-R.html


(setq default-tab-width 4)

;; Section II. Keyboard and mouse customization
;; Mouse and cursor in the usual Mac/Windows way
(delete-selection-mode t)
;; http://stackoverflow.com/questions/13036155/how-to-to-combine-emacs-primary-clipboard-copy-and-paste-behavior-on-ms-windows
(setq select-active-regions t)
;; Trying to make mouse middle-click only paste from primary
;; X11 selection, not clipboard and kill ring:
;;(global-set-key [mouse-2] 'mouse-yank-primary)
;; highlight does not alter Kill ring:
(setq mouse-drag-copy-region nil)
;; windows style binding C-x, C-v, C-c, C-z:
(cua-mode t)
;; Don't tabify after rectangle commands:
(setq cua-auto-tabify-rectangles nil)

;; Section III. Programming conveniences:
;; light-up matching parens:
(show-paren-mode t)
;; turn on syntax highlighting:
(global-font-lock-mode t)
;; Auto fill is TRUE in text modes:
(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))


;; Section IV. ESS Emacs Statistics

(setq inferior-ess-r-program "R")
;;(setq inferior-R-program-name "/Applications/R.app"

;; start R in current working directory, don't let R ask user:
(setq ess-ask-for-ess-directory nil)

;; Change shortcut "run this line" to use Shift-Return
;; Suggested by Vitalie Spinu 2013-09-30 to co-exist with Windows Emacs
(eval-after-load "ess-mode"
 '(progn
   (define-key ess-mode-map [(control return)] nil)
   (define-key ess-mode-map [(shift return)] 'ess-eval-region-or-line-and-step))
)

;; Quarto
(require 'quarto-mode)
(use-package quarto-mode
  :mode (("\\.Rmd" . poly-quarto-mode))
  )

;; Help in frames? Consider
;; 1) create a new frame for each help instance
;; (setq ess-help-own-frame t)
;; or 2) If you want all help buffers to go into one frame do:
;; (setq ess-help-own-frame 'one)

;; I want the *R* process in its own frame
;; (setq inferior-ess-own-frame t)
;; (setq inferior-ess-same-window nil)

;; Section V. Frames oriented Emacs
;; Discourage Emacs from horizontal splitting:
;; http://www.gnu.org/software/emacs/elisp/html_node/Choosing-Window.html
;;(setq split-window-preferred-function nil)

;; (setq pop-up-windows nil)

;; Make files opened from the menu bar appear in their own
;; frames. Adapted from Emacs menu-bar.el
(defun menu-find-existing ()
  "Edit the existing file FILENAME."
  (interactive)
  (let* ((mustmatch (not (and (fboundp 'x-uses-old-gtk-dialog)
                              (x-uses-old-gtk-dialog))))
         (filename (car (find-file-read-args "Find file: " mustmatch))))
    (if mustmatch
        (find-file-other-frame filename)
      (find-file filename))))
(define-key menu-bar-file-menu [new-file]
  '(menu-item "Open/Create" find-file-other-frame
	      :enable (menu-bar-non-minibuffer-window-p)
	      :help "Create a new file"))
(define-key menu-bar-file-menu [open-file]
  '(menu-item ,(purecopy "Open File...") menu-find-existing
              :enable (menu-bar-non-minibuffer-window-p)
              :help ,(purecopy "Read an existing file into an Emacs buffer")))


;; Open directory list in new frame.
(define-key menu-bar-file-menu [dired]
  '(menu-item "Open Directory..." dired-other-frame
	      :help "Read a directory; operate on its files (Dired)"
	      :enable (not (window-minibuffer-p (frame-selected-window menu-updating-frame)))))




;; Section VI: Miscellaneous convenience
;; Remove Emacs "splash screen" http://fuhm.livejournal.com/
(defadvice command-line-normalize-file-name
  (before kill-stupid-startup-screen activate)
  (setq inhibit-startup-screen t))
(setq inhibit-splash-screen t)

;; Show file name in title bar
;; http://www.thetechrepo.com/main-articles/549
(setq frame-title-format "%b - Emacs")

;; Make Emacs scroll smoothly with down arrow key.
;; faq 5.45 http://www.gnu.org/s/emacs/emacs-faq.html#Modifying-pull_002ddown-menus
(setq scroll-conservatively most-positive-fixnum)

;; adjust the size of the frames, uncomment this, adjust values
(setq default-frame-alist '((width . 90) (height . 65)))
;; Transparent titlebar on macOS.
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))


;; Remember password when connected to remote sites via Tramp
;; http://stackoverflow.com/questions/840279/passwords-in-emacs-tramp-mode-editing
;; Emacs "tramp" service (ssh connection) constantly
;; asks for the log in password without this
(setq password-cache-expiry nil)


;; Emacs shells work better
;; http://snarfed.org/why_i_run_shells_inside_emacs
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)


;; Trying to set up a Zettelkasen type system
;; https://rgoswami.me/posts/org-note-workflow/

(use-package org-roam
  :ensure t
  :hook (org-load . org-roam-mode)
  :commands (org-roam-buffer-toggle-display
             org-roam-find-file
             org-roam-graph
             org-roam-insert
             org-roam-switch-to-buffer
             org-roam-dailies-date
             org-roam-dailies-today
             org-roam-dailies-tomorrow
             org-roam-dailies-yesterday)
  :init
  (setq org-roam-v2-ack t)
  :custom
  (setq
   org_notes (concat (getenv "HOME") "/org-roam")
   zot_bib (concat (getenv "HOME") "/Documents/research/bib/gauding-full.bib")
   org-directory org_notes
   deft-directory org_notes
   org-roam-directory org_notes
   org-roam-verbose nil
   org-roam-buffer-no-delete-other-windows t
   org-roam-completion-system 'default
   org-roam-completion-everywhere t
   )
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))
  ;; ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; ;; (but not `find-file', to limit the scope of this behavior).
  ;; (add-hook 'find-file-hook
  ;;   (defun +org-roam-open-buffer-maybe-h ()
  ;;     (and +org-roam-open-buffer-on-find-file
  ;;          (memq 'org-roam-buffer--update-maybe post-command-hook)
  ;;          (not (window-parameter nil 'window-side)) ; don't proc for popups
  ;;          (not (eq 'visible (org-roam-buffer--visibility)))
  ;;          (with-current-buffer (window-buffer)
  ;;            (org-roam-buffer--get-create)))))

  ;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
  ;; makes it easier to distinguish among other org buffers.
  ;; (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))

(use-package deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        ;; de-couples filename and note title:
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename t
        ;; disable auto-save
        deft-auto-save-interval -1.0
        ;; converts the filter string into a readable file-name using kebab-case:
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))
  :config
  (add-to-list 'deft-extensions "tex")
  )

(setq
 bibtex-completion-notes-path (concat (getenv "HOME") "/org-roam")
 bibtex-completion-bibliography (concat (getenv "HOME") "/Documents/research/bib/gauding-full.bib")
;; bibtex-completion-library-path "~/Zotero/"
 bibtex-completion-pdf-field "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${=key=}: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ;;  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":NOTER_DOCUMENT: ${file}"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journal}\n"
  ":VOLUME: ${volume}\n"
  ":ISSUE: ${number}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )

(use-package org-ref
    :config
    (setq
         org-ref-completion-library 'org-ref-ivy-cite
         org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
         org-ref-default-bibliography (list  (concat (getenv "HOME") "/Documents/research/bib/gauding-full.bib"))
         org-ref-bibliography-notes  (concat (getenv "HOME") "/org-roam/bibnotes.org")
         org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
         org-ref-notes-directory (concat (getenv "HOME") "/org-roam")
         org-ref-notes-function 'orb-edit-notes
    ))

;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)


(use-package company
  :after org-roam
  :config
;;  (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))
  (push 'company-capf company-backends))

(use-package org-roam-bibtex
  :after (org-roam)
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (setq org-roam-bibtex-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
  (setq orb-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

- tags ::
- keywords :: ${keywords}

\n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

           :unnarrowed t))))

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'horizontal-split
   ;; Please stop opening frames
   org-noter-always-create-frame t
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org_notes (concat (getenv "HOME") "/org-roam")
   org-noter-notes-search-path (list org_notes)
   )
  )
  

;; Actually start using templates
;; :after org-capture
;;  Firefox and Chrome
(setq org-capture-templates
      '(("P" "Protocol" entry ; key, name, type
        (file+headline +org-capture-notes-file "Inbox") ; target
        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
        :prepend t ; properties
        :kill-buffer t)
      '("L" "Protocol Link" entry
        (file+headline +org-capture-notes-file "Inbox")
        "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n"
        :prepend t
        :kill-buffer t)))

;; ;; Attempt to get org-capture to not temporarily destroy windows
;; (defun my-org-capture-place-template-dont-delete-windows (oldfun args)
;;   (cl-letf (((symbol-function 'delete-other-windows) 'ignore))
;;     (apply oldfun args)))

;; (with-eval-after-load "org-capture"
;;   (advice-add 'org-capture-place-template :around 'my-org-capture-place-template-dont-delete-windows))

;; A setting to resolve not connecting to MELPA
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

;; Vertico - see: https://systemcrafters.cc/emacs-tips/streamline-completions-with-vertico/
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; Try to fix orgmode ODT
;; https://github.com/kjambunathan/org-mode-ox-odt
(add-to-list 'package-archives
	     '("ox-odt" . "https://kjambunathan.github.io/elpa/") t)

;; Inelegant solution to remove org-links
;; https://dev.to/mostalive/how-to-replace-an-org-mode-link-by-its-description-c70
(defun org-replace-link-by-link-description ()
  "Remove the link part of an org-mode link at point and keep
    only the description"
  (interactive)
  (let ((elem (org-element-context)))
    (if (eq (car elem) 'link)
        (let* ((content-begin (org-element-property :contents-begin elem))
               (content-end  (org-element-property :contents-end elem))
               (link-begin (org-element-property :begin elem))
               (link-end (org-element-property :end elem)))
          (if (and content-begin content-end)
              (let ((content (buffer-substring-no-properties content-begin content-end)))
                (delete-region link-begin (- link-end 1))
                (insert content)))))))

;; https://github.com/gromnitsky/read-aloud.el
(load-file "~/GIT/read-aloud.el/read-aloud.el")
(setq read-aloud-engine "say")

;; Attempting to set up lsp-mode
;; https://www.youtube.com/watch?v=E-NAM9U5JYE
;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :config
;;   (lsp-register-custom-settings
;;    '(("pyls.plugins.pyls_mypy.enabled" t t)
;;      ("pyls.plugins.pyls_mypy.live_mode" nil t)
;;      ("pyls.plugins.pyls_black.enabled" t t)
;;      ("pyls.plugins.pyls_isort.enabled" t t)
;;      ("pyls.plugins.flake8.enabled" t t)))
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (python-mode . lsp)
;; 	 (ess-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)

;; ;; optionally
;; (use-package lsp-ui
;;   :commands lsp-ui-mode
;;   :config (setq lsp-ui-sideline-show-hover t
;;                 lsp-ui-sideline-delay 0.5
;;                 lsp-ui-doc-delay 5
;;                 lsp-ui-sideline-ignore-duplicates t
;;                 lsp-ui-doc-position 'bottom
;;                 lsp-ui-doc-alignment 'frame
;;                 lsp-ui-doc-header nil
;;                 lsp-ui-doc-include-signature t
;;                 lsp-ui-doc-use-childframe t))

;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; ;; optionally if you want to use debugger
;; (use-package dap-mode)
;; ;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; ;; optional if you want which-key integration
;; (use-package which-key
;;     :config
;;     (which-key-mode))

;; all-the-icons
(when (display-graphic-p)
  (require 'all-the-icons))
(all-the-icons-completion-mode)

;; https://emacs.stackexchange.com/questions/32740/checkboxes-change-bullet-points-to-letters
(setq org-list-allow-alphabetical t)

;; https://www.louabill.org/Stata/ado-mode_install.html
(require 'ado-mode)

;; eshell prompt
(setq eshell-prompt-function
(lambda ()
(concat
(propertize "┌─[" 'face `(:foreground "green"))
(propertize (user-login-name) 'face `(:foreground "red"))
(propertize "@" 'face `(:foreground "green"))
(propertize (system-name) 'face `(:foreground "blue"))
(propertize "]──[" 'face `(:foreground "green"))
(propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground "yellow"))
(propertize "]──[" 'face `(:foreground "green"))
(propertize (concat (eshell/pwd)) 'face `(:foreground "white"))
(propertize "]\n" 'face `(:foreground "green"))
(propertize "└─>" 'face `(:foreground "green"))
(propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground "green"))
)))

;; https://tex.stackexchange.com/questions/364361/how-to-set-syntax-highlighting-for-citep-as-same-as-cite-in-auctex
(setq TeX-parse-self t)

(unless (image-type-available-p 'xpm)
  (setq LaTeX-enable-toolbar nil))

(setq font-latex-match-reference-keywords
  '(
    ("citeauthor" "[{")
    ("Citeauthor" "[{")
    ("cians" "[{")
    ("citep" "[{)")
    ("citepar" "[{")
    ("citet" "[{")))

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
;; (require 'doom-modeline-mode)

;; Set ispell location
(setq ispell-program-name "/usr/local/bin/ispell")

;; Fix flyspell mouse-2 trackpad issue
(eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;; ;; auto-revert TeX pdfs
;; (add-hook 'TeX-after-compilation-finished-functions
;;           #'TeX-revert-document-buffer)

;; (add-hook 'LaTeX-mode-hook 'olivetti-mode)
;; (add-hook 'LaTeX-mode-hook 'latex-extra-mode)

;; ;; auto-revert
;; (add-hook 'PDFview-mode-hook #'auto-revert-mode)

;; ;; smartparens
;; (require 'smartparens-config)

;; (add-hook 'LaTeX-mode-hook 'smartparens-mode)
;; (add-hook 'org-mode-hook 'smartparens-mode)
;; (add-hook 'python-mode 'smartparens-mode)
;; (add-hook 'ess-mode 'smartparens-mode)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;; (add-hook 'Shell-script 'smartparens-mode)

;; display-battery
;;(require 'display-battery-mode)

;; move-text
(require 'move-text)

;; bind org-agenda for convenience
(global-set-key (kbd "C-c a") 'org-agenda)

;; bind avy-goto-char-timer to M-j
(global-set-key (kbd "M-j") 'avy-goto-char-timer)

;; elfeed
(global-set-key (kbd "C-x w") 'elfeed)

;; all-the-icons-dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Macros
(fset 'new-beamer-slide
   (kmacro-lambda-form [?\\ ?b ?e ?g ?i ?n ?\{ ?f ?r ?a ?m ?e ?\}
   ?\{ right return return ?\\ ?e ?n ?d ?\{ ?f ?r ?a ?m ?e tab up
   up right right right right] 0 "%d"))

;; mu4e
;; initial set-up from https://macowners.club/posts/email-emacs-mu4e-macos/
(use-package mu4e
  :load-path "/usr/local/Cellar/mu/1.8.14/share/emacs/site-lisp/mu/mu4e/")

(setq mail-user-agent 'mu4e-user-agent)

;; for sending
(require 'smtpmail)

;; we installed this with homebrew
(setq mu4e-mu-binary (executable-find "mu"))

;; this is the directory we created before:
(setq mu4e-maildir "~/.maildir")

;; this command is called to sync imap servers:
(setq mu4e-get-mail-command (concat (executable-find "mbsync") " -a"))
;; how often to call it in seconds:
(setq mu4e-update-interval 300)

;; save attachment to desktop by default
;; or another choice of yours:
(setq mu4e-attachment-dir "~/Downloads")

;; rename files when moving - needed for mbsync:
(setq mu4e-change-filenames-when-moving t)

;; list of your email adresses:
(setq mu4e-user-mail-address-list '("pgauding09@gmail.com"
                                    "patrick.gauding@gmail.com"
				    "pjgaudin@sewanee.edu"))

;; check your ~/.maildir to see how the subdirectories are called
;; for the generic imap account:
;; e.g `ls ~/.maildir/example'
(setq  mu4e-maildir-shortcuts
       '(("/gmail-personal/INBOX" . ?g)
         ("/gmail-personal/[Gmail]/Sent Mail" . ?G)
	 ("/gmail-professional/INBOX" . ?p)
         ("/gmail-professional/[Gmail]/Sent Mail" . ?P)
	 ("/sewanee/INBOX" . ?s)
         ("/sewanee/[Gmail]/Sent Mail" . ?S)
	 ))
(add-to-list 'mu4e-bookmarks
	     '( :name "All Inboxes"
		:query "maildir:/gmail-personal/INBOX or maildir:/gmail-professional/INBOX or maildir:/sewanee/INBOX"
		:key ?i))
(add-to-list 'mu4e-bookmarks
             '( :name "Inbox - Personal"
		:query "maildir:/gmail-personal/INBOX"
		:key ?g))
(add-to-list 'mu4e-bookmarks
             '( :name "Inbox - Professional"
		:query "maildir:/gmail-professional/INBOX"
		:key ?p))
(add-to-list 'mu4e-bookmarks
             '( :name "Inbox - Sewanee"
		:query "maildir:/sewanee/INBOX"
		:key ?s))
(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "09-Personal"
          :enter-func
          (lambda () (mu4e-message "Enter pgauding09@gmail.com context"))
          :leave-func
          (lambda () (mu4e-message "Leave pgauding09@gmail.com context"))
          :match-func
          (lambda (msg)
            (when msg
              (mu4e-message-contact-field-matches msg
                                                  :to "pgauding09@gmail.com")))
          :vars '((user-mail-address . "pgauding09@gmail.com")
                  (user-full-name . "Patrick")
                  (mu4e-drafts-folder . "/gmail-personal/Drafts")
                  (mu4e-refile-folder . "/gmail-personal/Archive")
                  (mu4e-sent-folder . "/gmail-personal/Sent")
                  (mu4e-trash-folder . "/gmail-personal/Trash")
		  (mu4e-compose-signature .
					  (concat
					   "Patrick\n"))))

	,(make-mu4e-context
         :name "Professional"
         :enter-func
         (lambda () (mu4e-message "Enter patrick.gauding@gmail.com context"))
         :leave-func
         (lambda () (mu4e-message "Leave patrick.gauding@gmail.com context"))
         :match-func
         (lambda (msg)
           (when msg
             (mu4e-message-contact-field-matches msg
                                                 :to "patrick.gauding@gmail.com")))
         :vars '((user-mail-address . "patrick.gauding@gmail.com")
                 (user-full-name . "Patrick J. Gauding")
                 (mu4e-drafts-folder . "/gmail-professional/Drafts")
                 (mu4e-refile-folder . "/gmail-professional/Archive")
                 (mu4e-sent-folder . "/gmail-professional/Sent")
                 (mu4e-trash-folder . "/gmail-professional/Trash")
		 (mu4e-compose-signature .
					  (concat
					   "Patrick J. Gauding\n"
					   "216.870.9450\n"
					   "patrick.gauding@gmail.com"))))

	,(make-mu4e-context
         :name "Sewanee"
         :enter-func
         (lambda () (mu4e-message "Enter pjgaudin@sewanee.edu context"))
         :leave-func
         (lambda () (mu4e-message "Leave pjgaudin@sewanee.edu context"))
         :match-func
         (lambda (msg)
           (when msg
             (mu4e-message-contact-field-matches msg
                                                 :to "pjgaudin@sewanee.edu")))
         :vars '((user-mail-address . "pjgaudin@sewanee.edu")
                 (user-full-name . "Patrick J. Gauding")
                 (mu4e-drafts-folder . "/sewanee/Drafts")
                 (mu4e-refile-folder . "/sewanee/Archive")
                 (mu4e-sent-folder . "/sewanee/Sent")
                 (mu4e-trash-folder . "/sewanee/Trash")
		 (mu4e-compose-signature .
					 (concat
					  "Patrick J. Gauding, PhD\n"
					  "Visiting Assistant Professor\n"
					  "Department of Politics\n"
					  "University of the South\n"
					  "Carnegie Hall Rm. 318\n"
					  "735 University Ave.\n"
					  "Sewanee, TN 37383\n"
					  "patrick.gauding@sewanee.edu"))))
	))

(setq mu4e-context-policy 'pick-first) ;; start with the first (default) context;
(setq mu4e-compose-context-policy 'ask) ;; ask for context if no context matches;

;; gpg encryptiom & decryption:
;; this can be left alone
(require 'epa-file)
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)
(auth-source-forget-all-cached)

;; don't keep message compose buffers around after sending:
(setq message-kill-buffer-on-exit t)

;; send function:
(setq send-mail-function 'sendmail-send-it
      message-send-mail-function 'sendmail-send-it)

;; send program:
;; this is exeranal. remember we installed it before.
(setq sendmail-program (executable-find "msmtp"))

;; select the right sender email from the context.
(setq message-sendmail-envelope-from 'header)

;; chose from account before sending
;; this is a custom function that works for me.
;; well I stole it somewhere long ago.
;; I suggest using it to make matters easy
;; of course adjust the email adresses and account descriptions
;; (defun timu/set-msmtp-account ()
;;   (if (message-mail-p)
;;       (save-excursion
;;         (let*
;;             ((from (save-restriction
;;                      (message-narrow-to-headers)
;;                      (message-fetch-field "from")))
;;              (account
;;               (cond
;;                ((string-match "pgauding09@gmail.com" from) "09-Personal")
;;                ((string-match "patrick.gauding@gmail.com" from) "Professional")
;;                ((string-match "pjgaudin@sewanee.edu" from) "Sewanee")
;; 	       )))
;;           (setq message-sendmail-extra-arguments (list '"-a" account))))))

;; (add-hook 'message-send-mail-hook 'timu/set-msmtp-account)

;; (defun my-mu4e-set-account ()
;;   "Set the account for composing a message."
;;   (if mu4e-compose-parent-message
;;       (let ((mail (cdr (car (mu4e-message-field mu4e-compose-parent-message :to)))))
;;     (if (member mail mu4e-user-mail-address-list)
;;         (setq user-mail-address mail)
;;       (setq user-mail-address "patrick.gauding@gmail.com")))
;;     (helm :sources
;;       `((name . "Select account: ")
;;         (candidates . mu4e-user-mail-address-list)
;;         (action . (lambda (candidate) (setq user-mail-address candidate)))))))

;; (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; mu4e cc & bcc
;; this is custom as well
(add-hook 'mu4e-compose-mode-hook
          (defun timu/add-cc-and-bcc ()
            "My Function to automatically add Cc & Bcc: headers.
    This is in the mu4e compose mode."
            (save-excursion (message-add-header "Cc:\n"))
            (save-excursion (message-add-header "Bcc:\n"))))

;; mu4e address completion
(add-hook 'mu4e-compose-mode-hook 'company-mode)

;; store link to message if in header view, not to header query:
(setq org-mu4e-link-query-in-headers-mode nil)
;; don't have to confirm when quitting:
(setq mu4e-confirm-quit nil)
;; number of visible headers in horizontal split view:
(setq mu4e-headers-visible-lines 20)
;; don't show threading by default:
(setq mu4e-headers-show-threads nil)
;; hide annoying "mu4e Retrieving mail..." msg in mini buffer:
(setq mu4e-hide-index-messages t)
;; customize the reply-quote-string:
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M :\n")
;; M-x find-function RET message-citation-line-format for docs:
(setq message-citation-line-function 'message-insert-formatted-citation-line)
;; by default do not show related emails:
(setq mu4e-headers-include-related nil)
;; by default do not show threads:
(setq mu4e-headers-show-threads nil)

;; annoying ls-dired thing
;; https://stackoverflow.com/questions/4076360/error-in-dired-sorting-on-os-x
(when (equal system-type 'darwin)
  (setq insert-directory-program "/usr/local/opt/coreutils/libexec/gnubin/ls"))

;; Outlook display issue
(setq  message-citation-line-format "On %Y-%m-%d at %R %Z, %f wrote...")

;; https://www.djcbsoftware.nl/code/mu/mu4e/Compose-hooks.html
;; 1) messages to me@foo.example.com should be replied with From:me@foo.example.com
;; 2) messages to me@bar.example.com should be replied with From:me@bar.example.com
;; 3) all other mail should use From:me@cuux.example.com
;; (add-hook 'mu4e-compose-pre-hook
;;   (defun my-set-from-address ()
;;     "Set the From address based on the To address of the original."
;;     (let ((msg mu4e-compose-parent-message)) ;; msg is shorter...
;;       (when msg
;;         (setq user-mail-address
;;           (cond
;;             ((mu4e-message-contact-field-matches msg :to "patrick.gauding@gmail.com")
;;               "patrick.gauding@gmail.com")
;;             ((mu4e-message-contact-field-matches msg :to "pjgaudin@sewanee.edu")
;;              "pjgaudin@sewanee.edu")
;;             (t "pgauding09@gmail.com")))))))

;; https://www.djcbsoftware.nl/code/mu/mu4e/Other-settings.html
(setq mu4e-compose-dont-reply-to-self t)

;; attempt to show images when viewing messages
(setq mu4e-view-show-images t)

;; Make sure that emails don't look weird for non-plain text folks
;; (setq mu4e-compose-format-flowed t)

(use-package mu4e-column-faces
  :after mu4e
  :config (mu4e-column-faces-mode))

;; Experimental stuff

(defun ar/org-insert-link-dwim ()
  "Like `org-insert-link' but with personal dwim preferences."
  (interactive)
  (let* ((point-in-link (org-in-regexp org-link-any-re 1))
         (clipboard-url (when (string-match-p "^http" (current-kill 0))
                          (current-kill 0)))
         (region-content (when (region-active-p)
                           (buffer-substring-no-properties (region-beginning)
                                                           (region-end)))))
    (cond ((and region-content clipboard-url (not point-in-link))
           (delete-region (region-beginning) (region-end))
           (insert (org-make-link-string clipboard-url region-content)))
          ((and clipboard-url (not point-in-link))
           (insert (org-make-link-string
                    clipboard-url
                    (read-string "title: "
                                 (with-current-buffer (url-retrieve-synchronously clipboard-url)
                                   (dom-text (car
                                              (dom-by-tag (libxml-parse-html-region
                                                           (point-min)
                                                           (point-max))
                                                          'title))))))))
          (t
           (call-interactively 'org-insert-link)))))

(use-package procress
;;  :straight (:host github :repo "haji-ali/procress")
  :commands tex-procress-mode
  :init
  (add-hook 'LaTeX-mode-hook 'tex-procress-mode)
  :config
  (procress-load-default-svg-images))

(setq org-odt-preferred-output-format "doc")


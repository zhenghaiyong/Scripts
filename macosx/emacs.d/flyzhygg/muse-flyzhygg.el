;;; muse-init.el --- Initialize Emacs Muse
;;; muse-flyzhygg.el --- Emacs Muse for FlyZhyGG's homepage

;; This file is part of Michael Olson's Emacs settings.
;; Modified by Zheng Haiyong    zhenghaiyong@gmail.com

;; The code in this file may be used, distributed, and modified
;; without restriction.

;; I use initsplit.el to separate customize settings on a per-project
;; basis.

;; In order to see the scripts that I use to publish my website to a
;; remote webserver, check out
;; http://mwolson.org/projects/SiteScripts.html.

;;; Setup

;; Add to load path
;flyzhygg;(add-to-list 'load-path "/home/mwolson/proj/emacs/muse/git-muse/lisp")
;flyzhygg;(add-to-list 'load-path "/home/mwolson/proj/emacs/muse/git-muse/contrib" t)
;flyzhygg;(add-to-list 'load-path "/home/mwolson/proj/emacs/muse/git-muse/experimental")
;(add-to-list 'load-path "~/elisp/packages/muse-3.20/")
;(add-to-list 'load-path "~/elisp/packages/muse-3.20/contrib" t)
;(add-to-list 'load-path "~/elisp/packages/muse-3.20/experimental")

;; Initialize
(require 'outline)       ; I like outline-style faces
(require 'muse)          ; load generic module
(require 'muse-colors)   ; load coloring/font-lock module
(require 'muse-mode)     ; load authoring mode
(require 'muse-blosxom)  ; load blosxom module
(require 'muse-docbook)  ; load DocBook publishing style
(require 'muse-html)     ; load (X)HTML publishing style
(require 'muse-ikiwiki)  ; load Ikiwiki support
(require 'htmlize-hack)  ; work around htmlize bug with Emacs 23
(require 'muse-mathjax)  ; MathJax
(require 'muse-latex)    ; load LaTeX/PDF publishing styles
(require 'muse-latex2png) ; publish <latex> tags
(require 'muse-project)  ; load support for projects
(require 'muse-texinfo)  ; load Info publishing style
(require 'muse-wiki)     ; load Wiki support
(require 'muse-xml)      ; load XML support
;;(require 'muse-message)  ; load message support (experimental)

;; Setup projects

;; Here is an example of making a customized version of your favorite
;; publisher.  All this does is run `my-muse-blosoxm-finalize' on the
;; published file immediately after saving it.
(muse-derive-style "my-blosxom" "blosxom-xhtml"
                   :final 'my-muse-blosxom-finalize)

;; This turns relative links into absolute links
(muse-derive-style "my-pdf" "pdf"
                   :before 'my-muse-pdf-prepare-buffer)

;; This uses a different header and footer than normal
(muse-derive-style "my-xhtml" "xhtml"
                   :header "~/website/homepage/muse/header.html"
                   :footer "~/website/homepage/muse/footer.html")

;; Define a draft style which provides extra space between sections

(defvar muse-latex-draft-markup-strings
  '((chapter      . "\\bigskip\n\\bigskip\n\\chapter{")
    (section      . "\\bigskip\n\\bigskip\n\\section{")
    (subsection   . "\\bigskip\n\\bigskip\n\\subsection{")
    (subsubsection . "\\bigskip\n\\bigskip\n\\subsubsection{"))
  "Strings used for marking up Latex draft text.")

(muse-derive-style "latex-draft" "latex"
                   :strings 'muse-latex-draft-markup-strings)
(muse-derive-style "pdf-draft" "latex-draft"
                   :final   'muse-latex-pdf-generate
                   :browser 'muse-latex-pdf-browse-file
                   :link-suffix 'muse-latex-pdf-extension
                   :osuffix 'muse-latex-pdf-extension)

;; Define a style with unnumbered titles

(defvar muse-latex-uh-markup-strings
   '((chapter      . "\\chapter*{")
     (section      . "\\section*{")
     (subsection   . "\\subsection*{")
     (subsubsection . "\\subsubsection*{"))
  "Strings used for marking up Latex text with unnumbered headings.")

(muse-derive-style "latex-uh" "latex"
                   :strings 'muse-latex-uh-markup-strings)
(muse-derive-style "pdf-uh" "latex-uh"
                   :final   'muse-latex-pdf-generate
                   :browser 'muse-latex-pdf-browse-file
                   :link-suffix 'muse-latex-pdf-extension
                   :osuffix 'muse-latex-pdf-extension)

;; Here is my master project listing.

;flyzhygg;(setq muse-project-alist
;flyzhygg;      `(
;flyzhygg;        ("Website" ("~/proj/wiki/web/" "~/proj/wiki/web/testdir/"
;flyzhygg;                    :force-publish ("WikiIndex")
;flyzhygg;                    :default "WelcomePage")
;flyzhygg;         (:base "my-xhtml"
;flyzhygg;                :base-url "http://mwolson.org/web/"
;flyzhygg;                :include "/web/[^/]+"
;flyzhygg;                :path "~/personal-site/site/web")
;flyzhygg;         (:base "my-xhtml"
;flyzhygg;                :base-url "http://mwolson.org/web/"
;flyzhygg;                :include "/testdir/[^/]+"
;flyzhygg;                :path "~/personal-site/site/web/testdir")
;flyzhygg;         (:base "my-pdf"
;flyzhygg;                :base-url "http://mwolson.org/web/"
;flyzhygg;                :path "~/personal-site/site/web"
;flyzhygg;                :include "/\\(CurriculumVitae\\|BriefResume\\)[^/]*$"))
;flyzhygg;
;flyzhygg;        ("Projects" ("~/proj/wiki/projects/"
;flyzhygg;                     :force-publish ("WikiIndex" "MuseQuickStart")
;flyzhygg;                     :default "WelcomePage")
;flyzhygg;         (:base "my-xhtml"
;flyzhygg;                :base-url "http://mwolson.org/projects/"
;flyzhygg;                :path "~/personal-site/site/projects"))
;flyzhygg;
;flyzhygg;        ("Blog" (,@(muse-project-alist-dirs "~/proj/blog")
;flyzhygg;                 :default "index"
;flyzhygg;                 :publish-project #'ignore)
;flyzhygg;         ;; Publish this directory and its subdirectories.  Arguments
;flyzhygg;         ;; are as follows.  The above `muse-project-alist-dirs' part
;flyzhygg;         ;; is also needed.
;flyzhygg;         ;;   1. Source directory
;flyzhygg;         ;;   2. Output directory
;flyzhygg;         ;;   3. Publishing style
;flyzhygg;         ;;   remainder: Other things to put in every generated style
;flyzhygg;         ,@(muse-project-alist-styles
;flyzhygg;            "~/proj/blog"
;flyzhygg;            "~/personal-site/site/blog"
;flyzhygg;            "ikiwiki"
;flyzhygg;            :base-url "http://grepfind.mwolson.org/blog/"))
;flyzhygg;
;flyzhygg;        ("MyNotes" ("~/proj/wiki/notes/"
;flyzhygg;                    :force-publish ("index")
;flyzhygg;                    :default "index")
;flyzhygg;         (:base "xhtml"
;flyzhygg;                :base-url "http://mwolson.org/notes/"
;flyzhygg;                :path "~/personal-site/site/notes")
;flyzhygg;         (:base "my-pdf"
;flyzhygg;                :base-url "http://mwolson.org/notes/"
;flyzhygg;                :path "~/personal-site/site/notes"))
;flyzhygg;
;flyzhygg;        ("_Private" ("~/Documents")
;flyzhygg;         ,@(muse-project-alist-styles "~/Documents"
;flyzhygg;                                      "~/Documents"
;flyzhygg;                                      "pdf"))
;flyzhygg;
;flyzhygg;        ("_Classes" (,@(muse-project-alist-dirs "~/proj/wiki/classes")
;flyzhygg;                    :default "index")
;flyzhygg;         ,@(muse-project-alist-styles "~/proj/wiki/classes"
;flyzhygg;                                      "~/personal-site/site/classes"
;flyzhygg;                                      "xhtml"))
;flyzhygg;
;flyzhygg;        ("MA366" ("~/proj/classes/ma366")
;flyzhygg;         (:base "pdf-uh"
;flyzhygg;                :path "~/proj/classes/ma366"))
;flyzhygg;
;flyzhygg;        ("ENGL238" ("~/proj/classes/engl238")
;flyzhygg;         (:base "pdf-uh"
;flyzhygg;                :path "~/proj/classes/engl238"))
;flyzhygg;
;flyzhygg;        ("CS426" ("~/proj/classes/cs426")
;flyzhygg;         (:base "pdf-uh"
;flyzhygg;                :path "~/proj/classes/cs426"))
;flyzhygg;
;flyzhygg;        ("_Plans" ("~/proj/wiki/plans/"
;flyzhygg;                  :default "TaskPool"
;flyzhygg;                  :major-mode planner-mode
;flyzhygg;                  :visit-link planner-visit-link)
;flyzhygg;         (:base "planner-xhtml"
;flyzhygg;                :path "~/proj/notmine/planner-out"))
;flyzhygg;        ))

(setq muse-project-alist
      `(
        ("ACDS" ("~/website/homepage/source/research/acds/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/research/acds/"
                :path "~/website/homepage/publish/research/acds"))

        ("Research" ("~/website/homepage/source/research/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/research/"
                :path "~/website/homepage/publish/research"))

        ("CV2015Spring" ("~/website/homepage/source/courses/cv/2015spring/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/cv/2015spring/"
                :path "~/website/homepage/publish/courses/cv/2015spring"))

        ("EC2015Spring" ("~/website/homepage/source/courses/ec/2015spring/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/ec/2015spring/"
                :path "~/website/homepage/publish/courses/ec/2015spring"))

        ("CB2014Fall" ("~/website/homepage/source/courses/cb/2014fall/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/cb/2014fall/"
                :path "~/website/homepage/publish/courses/cb/2014fall"))

        ("CEC2014Fall" ("~/website/homepage/source/courses/cec/2014fall/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/cec/2014fall/"
                :path "~/website/homepage/publish/courses/cec/2014fall"))

        ("DSD20132" ("~/website/homepage/source/courses/dsd/20132/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/dsd/20132/"
                :path "~/website/homepage/publish/courses/dsd/20132"))

        ("CEC20131" ("~/website/homepage/source/courses/cec/20131/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/cec/20131/"
                :path "~/website/homepage/publish/courses/cec/20131"))

        ("DSD20122" ("~/website/homepage/source/courses/dsd/20122/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/dsd/20122/"
                :path "~/website/homepage/publish/courses/dsd/20122"))

        ("CEC20121" ("~/website/homepage/source/courses/cec/20121/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/cec/20121/"
                :path "~/website/homepage/publish/courses/cec/20121"))

        ("Courses" ("~/website/homepage/source/courses/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/courses/"
                :path "~/website/homepage/publish/courses"))

        ("Projects" ("~/website/homepage/source/projects/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/projects/"
                :path "~/website/homepage/publish/projects"))

        ("Blog" (,@(muse-project-alist-dirs "~/website/homepage/source/blog")
                 :default "index"
                 :publish-project #'ignore)
         ;; Publish this directory and its subdirectories.  Arguments
         ;; are as follows.  The above `muse-project-alist-dirs' part
         ;; is also needed.
         ;;   1. Source directory
         ;;   2. Output directory
         ;;   3. Publishing style
         ;;   remainder: Other things to put in every generated style
         ,@(muse-project-alist-styles
            "~/website/homepage/source/blog"
            "~/website/homepage/publish/blog"
            "ikiwiki"
            :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/blog/"))

        ("FlyZhyGG" ("~/website/homepage/source/flyzhygg/"
                     :force-publish ("index-homepage")
                     :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/flyzhygg/"
                :path "~/website/homepage/publish/flyzhygg"))

        ("Home" ("~/website/homepage/source/home"
                    :force-publish ("index-homepage")
                    :default "index")
         (:base "my-xhtml"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/"
                :include "/[^/]+"
                :path "~/website/homepage/publish")
         (:base "my-pdf"
                :base-url "http://vision.ouc.edu.cn/~zhenghaiyong/"
                :path "~/website/homepage/publish"
                :include "/\\(CurriculumVitae\\|BriefResume\\)[^/]*$"))
        ))

;; Wiki settings
(setq muse-wiki-interwiki-alist
      '(("PlugWiki" . "http://wiki.purduelug.org/")
        ("EmacsWiki" . "http://www.emacswiki.org/cgi-bin/wiki/")
        ("ArchWiki" . "http://gnuarch.org/gnuarchwiki/")
        ("HCoopWiki" . "http://wiki.hcoop.net/")
        ;; abbreviations
        ("ZHY" . "http://vision.ouc.edu.cn/~zhenghaiyong/")
        ("MWOLSON" . "http://www.mwolson.org/")
        ("CERIAS" . "http://www.cerias.purdue.edu/")
        ("PlannerMode" . "http://www.emacswiki.org/cgi-bin/wiki/PlannerMode")
        ("RememberMode" . "http://www.emacswiki.org/cgi-bin/wiki/RememberMode")
        ("GP2X" . "http://www.gp2x.co.uk/")
        ("UbuntuLinux" . "http://ubuntulinux.org/")
        ("HCoop" . "http://hcoop.net/")
        ("PLUG" . "http://purduelug.org/")
        ("PAC" . "http://web.ics.purdue.edu/~pac/")))

;;; Functions

;; Turn relative links into absolute ones
(defun my-muse-pdf-make-links-absolute (str &rest ignored)
  "Make relative links absolute."
  (when str
    (save-match-data
      (if (string-match "\\`[/.]+" str)
          (replace-match "http://vision.ouc.edu.cn/~zhenghaiyong/" nil t str)
        str))))

;; Make sure my interproject links become absolute when published in
;; PDFs
(defun my-muse-pdf-prepare-buffer ()
  (set (make-local-variable 'muse-publish-url-transforms)
       (cons 'my-muse-pdf-make-links-absolute muse-publish-url-transforms)))

;; Switch to the given project and prompt for a file
(defun my-muse-project-find-file (project)
  (interactive)
  (let ((muse-current-project (muse-project project)))
    (call-interactively 'muse-project-find-file)))

(defun my-muse-blosxom-finalize (file output-path target)
;;  (my-muse-prepare-entry-for-xanga output-path)
;; For now, do nothing.
  )

;; Make the current file display correctly in Xanga
;; I call this using C-c p x now.
(defun my-muse-prepare-entry-for-xanga (file)
  "Mangle FILE so that Xanga doesn't bug out, saving to X clipboard.

If FILE is not specified, use the published version of the current file."
  (interactive
   (list
    (expand-file-name (concat (muse-page-name) muse-blosxom-extension)
                      (muse-style-element
                       :path (car (muse-project-applicable-styles
                                   buffer-file-name
                                   (cddr (muse-project-of-file))))))))
  (save-match-data
    (muse-with-temp-buffer
      (muse-insert-file-contents file)
      ;; surround first line in <h3></h3>
      (goto-char (point-min))
      (insert "<h3>")
      (end-of-line)
      (insert "</h3>")
      ;; treat example regions properly
      (let (beg end)
        (while (re-search-forward "<pre[^>]*>" nil t)
          (setq beg (match-end 0))
          (setq end (if (re-search-forward "</pre>" nil 1)
                        (match-beginning 0)
                      (point)))
          (save-restriction
            (narrow-to-region beg end)
            ;; change initial spaces to &nbsp;
            (goto-char (point-min))
            (while (re-search-forward "^ +" nil t)
              (replace-match (apply 'concat (make-list
                                             (length (match-string 0))
                                             "&nbsp;"))))
            ;; change newline to <br />
            (goto-char (point-min))
            (while (re-search-forward "\n" nil t)
              (replace-match "<br />")))))
      ;; get rid of 2 spaces together and merge lines
      (goto-char (point-min))
      (while (re-search-forward (concat "[" muse-regexp-blank "\n]+") nil t)
        (replace-match " "))
      ;; remove trailing space
      (goto-char (point-min))
      (while (re-search-forward " *</p> *" nil t)
        (replace-match "</p>"))
      ;; make relative links work
      (goto-char (point-min))
      (while (re-search-forward "href=\"[/.]+" nil t)
        (replace-match "href=\"http://vision.ouc.edu.cn/~zhenghaiyong/" nil t))
      ;; copy entry to clipboard
      (clipboard-kill-ring-save (point-min) (point-max))
      (message "Copied blog entry to clipboard"))))

;; Turn a word or phrase into a clickable Wikipedia link
(defun my-muse-dictize (beg end)
  (interactive "r")
  (let* ((text (buffer-substring-no-properties beg end))
         (link (concat "dict:" (replace-regexp-in-string " " "_" text t t))))
    (delete-region beg end)
    (insert "[[" link "][" text "]]")))

(defun my-muse-surround-math (&optional beg end)
  "If a region is higlighted, surround it with <math>...</math>.
If no region is highlighted, insert <math></math> and leave the point
between the two tags."
  (interactive (list (ignore-errors (mark)) (point)))
  (if (and beg end)
      (save-restriction
        (narrow-to-region beg end)
        (goto-char (point-min))
        (insert "<math>")
        (goto-char (point-max))
        (insert "</math>"))
    (insert "<math>")
    (save-excursion (insert "</math>"))))

(defun my-muse-cdotize-region (beg end)
  (interactive "r")
  (save-restriction
    (narrow-to-region beg end)
    (goto-char (point-min))
    (while (re-search-forward " *\\* *" nil t)
      (replace-match " \\\\cdot "))))

;; 叶文彬 ywb
;; flyzhygg
(defun ywb-muse-generate-index (&optional project-list)
  "Generate the index of all wikifile except the file in the \"website\" project"
  (unless project-list
    (setq project-list (list (car (muse-project)))))
  (let ((project-files)
        (title))
    (muse-with-temp-buffer
      (dolist (project project-list)
        (setq project-files (muse-project-file-alist project))
        (progn
          (insert "* " project "\n"))
        (dolist (file project-files)
          (unless (or (equal (car file) "WelcomePage")
                      (equal (car file) "WikiIndex")
                      (equal (car file) "index-homepage"))
            (insert " - [[" project "#" (car file) "]["
                    (save-excursion
                      (set-buffer (generate-new-buffer "*index*"))
                      (insert-file-contents (cdr file))
                      (goto-char (point-min))
                      (setq title
                            (if (re-search-forward "^#title" nil t)
                                (buffer-substring (point) (line-end-position))
                              (car file)))
                      (kill-buffer (current-buffer))
                      title)
                    "]]\n")))
        (insert "\n"))
      (buffer-string))))

;;; Key customizations

(global-set-key "\C-cpl" 'muse-blosxom-new-entry)
(global-set-key "\C-cpL" #'(lambda () (interactive)
                             (my-muse-project-find-file "Blog")))
(global-set-key "\C-cpi" #'(lambda () (interactive)
                             (my-muse-project-find-file "_Private")))
(global-set-key "\C-cpm" #'(lambda () (interactive)
                             (my-muse-project-find-file "MA453")))
(global-set-key "\C-cpn" #'(lambda () (interactive)
                             (my-muse-project-find-file "MyNotes")))
(global-set-key "\C-cpp" #'(lambda () (interactive)
                             (my-muse-project-find-file "_Plans")))
(global-set-key "\C-cpr" #'(lambda () (interactive)
                             (my-muse-project-find-file "Projects")))
(global-set-key "\C-cps" #'(lambda () (interactive)
                             (my-muse-project-find-file "_Classes")))
(global-set-key "\C-cpw" #'(lambda () (interactive)
                             (my-muse-project-find-file "Website")))
(global-set-key "\C-cpC" #'my-muse-cdotize-region)
(global-set-key "\C-cpM" #'my-muse-surround-math)
(global-set-key "\C-cpW" #'my-muse-dictize)
(global-set-key "\C-cpx" #'my-muse-prepare-entry-for-xanga)

;;; Custom variables

(custom-set-variables
 '(muse-blosxom-base-directory "~/website/homepage/source/blog/")
 '(muse-colors-autogen-headings (quote outline))
 '(muse-colors-inline-image-method (quote muse-colors-use-publishing-directory))
 '(muse-completing-read-function (quote ido-completing-read))
 '(muse-html-charset-default "utf-8")
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-footer "~/website/homepage/muse/generic-footer.html")
 '(muse-html-header "~/website/homepage/muse/generic-header.html")
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"/common.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"screen\" href=\"/screen.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"print\" href=\"/print.css\" />")
 '(muse-latex-header "~/website/homepage/muse/header.tex")
 '(muse-latex-pdf-browser "evince %s &")
 '(muse-mode-hook (quote (flyspell-mode footnote-mode)))
 '(muse-publish-comments-p t)
 '(muse-publish-date-format "%b. %e, %Y")
 '(muse-publish-desc-transforms (quote (muse-wiki-publish-pretty-title muse-wiki-publish-pretty-interwiki muse-publish-strip-URL)))
 '(muse-wiki-publish-small-title-words (quote ("the" "and" "at" "on" "of" "for" "in" "an" "a" "page")))
 '(muse-xhtml-footer "~/website/homepage/muse/generic-footer.html")
 '(muse-xhtml-header "~/website/homepage/muse/generic-header.html")
 '(muse-xhtml-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"/common.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"screen\" href=\"/screen.css\" />
<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"print\" href=\"/print.css\" />"))
(custom-set-faces
 '(muse-bad-link ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold)))))

;;; muse-init.el ends here
;;; muse-flyzhygg.el ends here

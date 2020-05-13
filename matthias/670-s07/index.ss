(module index mzscheme
  (require
    (file "basics.ss")
    (file "aux.scm")
    (lib "teaching.ss" "web")
    (lib "list.ss")
    (lib "web-page.ss" "web")
    (lib "xml-qq.ss" "web"))
  

  ;; --- PAGES ---

  (write-index-page "Software Design and Development" #f
    (xml "index.xml"))

  (write-normal-page "communications.html" "Communications" #f
    (xml "communications.xml"))

  (write-normal-page "general.html" "General" #f (xml "general.xml"))
 
  (write-normal-page "readings.html" "Texts" #f (xml "readings.xml"))
  
  (write-normal-page "syllabus.html" "Syllabus" #f (xml "syllabus.xml"))

  (write-blog)

  (write-normal-page "log.html" "Journal" "resize.jpg" (xml "log.xml"))

  (all-pages-produced?)
  )

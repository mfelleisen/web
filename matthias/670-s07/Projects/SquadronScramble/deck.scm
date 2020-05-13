(module deck mzscheme 
  (require 
   (lib "deflate.ss")
   (lib "list.ss")
   (lib "tar.ss")
   (lib "xml.ss" "xml"))
  
  ;; Symbol Xexpr -> (union String false)
  (define (aircraft-attr att acrft)
    (define r (assq att (cadr acrft)))
    (if r (cadr r) #f))
  
  (define (aircraft->image a)
    (define img (aircraft-attr 'image a))
    (if img (string-append (aircraft-attr 'name a) img) img))
  
  ;; --- is every jpeg included in the deck and does every image specified in the deck exist as a file?
  (define deck (filter pair? (xml->xexpr (document-element (with-input-from-file "index.xml" read-xml)))))
  
  (define images (cons "victory.jpg"
		   (cons "keepem.jpg"
		     (cons "question.jpg"
		       (filter string? (map aircraft->image deck))))))

  (define files (map path->string (directory-list)))
  
  (define jpegs (filter (lambda (x) (regexp-match "\\.jpg" x)) files))
  
  (define image-not-jpeg (filter (lambda (i) (not (member i jpegs))) images))
  
  (define jpeg-not-image (filter (lambda (j) (not (member j images))) jpegs))
  
  (unless (null? image-not-jpeg)
    (error 'deck "image not found: ~s\n" image-not-jpeg))
  
  (unless (null? jpeg-not-image)
    (error 'deck "jpeg not included: ~s\n" jpeg-not-image))
  
  ;; --- 
  ;; create HTML index file for inclusion in rules

  (define (deck->div d)
    `(div
      (p "The airplane images in this table, plus an index file in XML, are
          available as a tar bundle:" 
         (a ([href "SquadronScramble/aircrafts.tar.gz"]) "aircrafts.tar.gz"))
      (table ((align "center"))
             `(tr (td "Name of Aircraft") (td "Type") (td "Nation") (td "Image"))
             ,@(map aircraft->tr deck))
      (p "* According to a Web search, these two airplanes existed only in
          the imagination of Pearl Harbor observers and survivors.")))
  
  (define (aircraft->tr a)
    (define img (aircraft->image a))
    `(tr (td ,(aircraft-attr 'name a))
         (td ,(aircraft-attr 'category a))
         (td ,(aircraft-attr 'nation a))
         ,@(if img 
               `((td (img ([src ,(string-append "SquadronScramble/" img)]
                           [width "50"]))))
               '((td ([height "50"][align "center"][valign "mid"]) "*")))))
  
  (define xexpr (deck->div deck))
  (define xml   (xexpr->xml xexpr))
  (with-output-to-file "deck.xml"
    (lambda () (display-xml/content xml))
    'truncate)
  
  (define TAR:FILE  "aircrafts.tar")
  (define GZ:FILE  (string-append TAR:FILE ".gz"))
  (when (file-exists? TAR:FILE) (delete-file TAR:FILE))
  (when (file-exists? GZ:FILE) (delete-file GZ:FILE))
  (apply tar TAR:FILE "index.xml" images)
  (gzip TAR:FILE)

  )

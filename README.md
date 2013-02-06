veritrans-rails-sample-cart
===========================

Example implementation of Veritrans VTLink integration checkout using Ruby on Rails

Langkah-langkah code integrasi:

- Tambahkan gem "veritrans" di "/Gemfile"

- Buat routing yang di butuhkan untuk checkout menggunakan Veritrans Payment Gateway

   #.....ROUTES Example:
   a. root :to => 'product#index' #................................checkout form

   b. match 'confirm' => 'veritrans#confirm', :via => :post #...confirmation (autosubmit to veritrans server)
   c. match 'postvtw' => 'veritrans#postvtw', :via => :post #...server to server notification
   d. match 'finish'  => 'veritrans#finish',  :via => :post #...server to server redirection
   e. match 'unfinish'=> 'veritrans#unfinish',:via => :get  #...link-back to merchant web
   f. match 'error'   => 'veritrans#error',   :via => :post #...server to server redirection
   #.....ROUTES

Untuk membuat struktur database sample store dan generate sample data

- 'rake db:setup'  

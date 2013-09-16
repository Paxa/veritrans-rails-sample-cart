veritrans-rails-sample-cart
===========================

Example implementation of Veritrans VTLink integration checkout using Ruby on Rails

Langkah-langkah code integrasi:

- Tambahkan gem "veritrans" di "/Gemfile"

- Buat routing yang di butuhkan untuk checkout menggunakan Veritrans Payment Gateway

```ruby
#.....ROUTES Example:
root :to => 'product#index' #................................checkout form

match 'confirm' => 'veritrans#confirm', :via => :post #...confirmation (autosubmit to veritrans server)
match 'postvtw' => 'veritrans#postvtw', :via => :post #...server to server notification
match 'finish'  => 'veritrans#finish',  :via => :post #...server to server redirection
match 'unfinish'=> 'veritrans#unfinish',:via => :get  #...link-back to merchant web
match 'error'   => 'veritrans#error',   :via => :post #...server to server redirection
```
Untuk membuat struktur database sample store dan generate sample data

- 'rake db:setup'  

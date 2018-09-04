#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'
require 'pry'


# on met ici l'URL dans une constante
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

# On déclare un tableau array vide, on en aura besoin pour stocker le hash obtenu plus tard
CRYPTO_NAME = []
CRYPTO_PRICE = []
TABLE = []

def trader_de_l_obscur

  begin # Begin error checking
  
  h = Hash.new

  page = Nokogiri::HTML(open(PAGE_URL))

  # On utilise la ".css method" sur la classe .currency-name-container  
  crypto_currencies = page.css(".currency-name-container") # on récupère les noms des crytomonnaies pour les mettre dans le hash
  crypto_values = page.css(".price") # on récupère les taux des crytomonnaies pour les mettre dans le hash
  
  crypto_currencies.each do |crypto_currency|
    CRYPTO_NAME << crypto_currency.text
  end

  crypto_values.each do |crypto_value|
    CRYPTO_PRICE << crypto_value.text
  end

  for i in (0..CRYPTO_NAME.length-1)
    h[CRYPTO_NAME[i]] = CRYPTO_NAME[i] + ';' + CRYPTO_PRICE[i]
    TABLE << h
    h = {}
  end

  #binding.pry
  CSV.open("trader_de_l_obscur.csv", "wb") do |csv| #on construit le tableur CSV
    TABLE.each do |hash|
      csv << hash.values
    end
  end




  puts "============================================================================================="
  puts "The bitcoin values has been put in a csv file crypto_currencies.csv"
  rescue => e
    puts "Exception Class: #{ e.class.name }"
    puts "Exception Message: #{ e.message }"
    puts "Exception Backtrace: #{ e.backtrace }"
  end

end

def trader_forever
  loop {
    trader_de_l_obscur
    sleep(3600)
  }
end

trader_forever
#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

#on va numéroter toutes les valeurs afin de faire corespondre taux et noms des cryptomonnaies
def get_all_values
		page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		coins_list = []
	  	page.xpath('//a[@class="currency-name-container"]').each do |coins|
	  		coins_list << coins
	  	end
	return coins_list.length
end

#on récupère le nom des différentes cryptomonnaies 
def get_currencies(x)
		page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		name_list = []
		page.xpath('//a[@class="currency-name-container"]').each do |name|
			name_list << name.text
		end
	return name_list[0..x]
end

#on récupère le taux des différentes cryptomonnaies
def get_coins_price(x)
		page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		price_list = []
		page.xpath('//a[@class="price"]').each do |price|
			price_list << price.text
		end
		return price_list[0..x]
end

loop {
		#on fait correspondre la numérotations des taux et des noms des cryptomonnaies
		compte = get_all_values
		h = get_currencies(compte).zip(get_coins_price(compte)).to_h

		#on exporte les datas dans un fichier texte qui sera mis à jour toute les heures
		

		fname = "trader_de_l_obscur.txt"
		somefile = File.open(fname,"w")
		somefile.puts h
		somefile.close
		puts "fichier mis à jour, il sera écrasé et mis à jour dans une heure"
		sleep(3600)
}
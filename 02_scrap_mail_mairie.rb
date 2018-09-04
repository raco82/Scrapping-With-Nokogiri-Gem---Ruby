#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'


#on créé la boucle pour récupérer les adresses mail

def get_val_d_oise_town_halls_emails(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
	scrap.each do |node| return "Mail:" + node.text
	end
end

#on génère les URL pour les villes

def get_val_d_oise_town_halls_urls(url)
	h = {}
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//table/tr[2]/td/table/tr/td/p/a')
	scrap.each do |node|
		city = node.text.split.each do |text| text.capitalize!
		end
		city = "Ville: " + city * "-"
		url = 'http://annuaire-des-mairies.com' + node['href'].slice!(1..-1)
		#on lance la boucle pour récupérer les adresses mail
		mail = get_val_d_oise_town_halls_emails(url)
		#on stock les datas "villes" et "adresses mail"
		h.store(city,mail)
	end

	#on utilise les datas stockées pour sortir un document texte lisible et facile à réutiliser si besoin
	fname = "route_de_la_mairie.txt"
	somefile = File.open(fname,"w")
	somefile.puts h
	somefile.close
end

get_val_d_oise_town_halls_urls("http://annuaire-des-mairies.com/val-d-oise.html")
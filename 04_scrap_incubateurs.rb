#! /usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_webpage(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//div[2]/div/p[2]/a/@href')
	scrap.each do |node| return "Site:" + node.text
	end
end

def get_the_cp(url)
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//div/strong')
	scrap.each do |node| return node.text
	end
end

def get_all_the_webpages(url)
	h = {}
	page = Nokogiri::HTML(open(url))
	scrap = page.xpath('//td[2]/p/span/a')
	scrap.each do |node|
		nom = node.text.split.each do |text| text.capitalize!
		end
		nom = "Nom: " + nom * "-"
		url = 'http://mon-incubateur.com/' + node['href'].slice!(1..-1)
    site = get_the_webpage(url)
    cp = get_the_cp(url)

    puts "#{nom} #{site} #{cp}"
    end
end

get_all_the_webpages("http://mon-incubateur.com/site_incubateur/incubateurs")
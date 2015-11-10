# -*- coding: utf-8 -*-
import scrapy
import re
import ast
from nycrex.items import listingItem

import logging
from scrapy.utils.log import configure_logging

configure_logging(install_root_handler=False)
logging.basicConfig(
    filename='nycrex.log',
    format='%(asctime)s: %(name)s: %(levelname)s: %(message)s',
    level=logging.INFO
)
logging.getLogger('sqlalchemy.engine').setLevel(logging.DEBUG)

class StreeteasySpider(scrapy.Spider):
	name = "streeteasy"
	allowed_domains = ["streeteasy.com"]
	start_urls = [
        'http://streeteasy.com/for-rent/manhattan',
        'http://streeteasy.com/for-rent/brooklyn',
        'http://streeteasy.com/for-rent/queens',
        'http://streeteasy.com/for-rent/bronx',
        'http://streeteasy.com/for-rent/staten-island'
		]

	def parse(self, response):
		for sel in response.xpath('//div[@class="details-title"]'):

			url = 'http://streeteasy.com%s' %sel.xpath('a/@href').extract()[0]
			yield scrapy.Request(url, callback=self.parseListing)

		for href in response.xpath('//div[@class="pagination center_aligned bottom_pagination big_space"]/a[@class="next_page"]/@href'):
			url = response.urljoin(href.extract())
			yield scrapy.Request(url, callback=self.parse)


	def parseListing(self, response):

		# Parse <script> dataLayer object
		data = response.xpath('//script/text()[contains(., "dataLayer")]')[0]
		data = data.extract().strip()

		# Extract dictionary element
		data = re.findall("{(.*?)}",data)

		# Convert list to string for parsing
		data = str(data)

		# Replace list brackets with dict brackets
		data = data.replace("[","{")
		data = data.replace("]","}")

		# Remove u' at start of string
		data = data.replace("u\'","")

		# Remove ' at end of string
		data = data.replace("'}", "}")

		# Convert true / false objects to strings
		data = data.replace("\":true", "\":\"true\"")
		data = data.replace("\":false", "\":\"false\"")

		# Fix escape character on double quotes
		data = data.replace("\\\"","\"")
	
		# Convert parsed string to dictionary object
		data = ast.literal_eval(data)

		listing = listingItem()

		listing['url'] = response.url

		listing['title'] = str(response.xpath('//title/text()').extract()[0].split("|")[0].strip())

		listing['geo'] = str(response.xpath('//meta[@name="geo.position"]/@content').extract()[0])

		listing['desc'] = response.xpath('//meta[@name="description"]/@content').extract()[0]

		listing['addr'] = str(response.xpath('//meta[@name="geo.placename"]/@content').extract()[0])

		if 'listID' in data:
			listing['lID'] = data['listID']
		else:
			listing['lID'] = 0

		if 'listDate' in data:
			listing['listDate'] = data['listDate']
		else:
			listing['listDate'] = ""

		if 'listDaysMarket' in data:
			listing['daysMkt'] = data['listDaysMarket']
		else:
			listing['daysMkt'] = 0

		if 'listAvailDate' in data:
			listing['availDate'] = data['listAvailDate']
		else:
			listing['availDate'] = ""

		if 'listPrice' in data:
			listing['price'] = data['listPrice']
		else:
			sel = response.xpath('//div[@class="container-fluid row"]')
			listing['price'] = sel.xpath('.//div[@class="price "]/text()').extract()[0]
			listing['price'] = listing['price'].strip()
			listing['price'] = listing['price'].replace(",","")
			listing['price'] = listing['price'].replace("$","")

		if 'listNoFee' in data:
			if data['listNoFee'] == "true":
				listing['noFee'] = True
			else:
				listing['noFee'] = False
		else:
			listing['noFee'] = False

		if 'listGeoLat' in data:
			listing['lat'] = data['listGeoLat']
			if listing['lat'] == '':
				listing['lat'] = listing['geo'].split("; ")[0]
		else:
			listing['lat'] = listing['geo'].split("; ")[0]
		if listing['lat'] == '':
			listing['lat'] = 0

		if 'listGeoLon' in data:
			listing['lon'] = data['listGeoLon']
			if listing['lon'] == '':
				listing['lon'] = listing['geo'].split("; ")[1]
		else:
			listing['lon'] = listing['geo'].split("; ")[1]
		if listing['lon'] == '':
			listing['lon'] = 0


		if 'listZip' in data:
			listing['zip'] = data['listZip']
			if listing['zip'] == '':
				listing['zip'] = re.findall('NY [0-9][0-9][0-9][0-9][0-9]',listing['addr'])[0].split(" ")[1]
		else:
			listing['zip'] = re.findall('NY [0-9][0-9][0-9][0-9][0-9]',listing['addr'])[0].split(" ")[1]
		if listing['zip'] == '':
			listing['zip'] = 0

		if 'listAgent' in data:
			listing['agent'] = data['listAgent']
		else:
			listing['agent'] = ""

		if 'listBrokerage' in data:
			listing['brkr'] = data['listBrokerage'].upper()
			listing['brkr'] = listing['brkr'].replace("_"," ")
		else:
			listing['brkr'] = ""

		if 'listBed' in data:
			listing['bed'] = data['listBed']
		else:
			listing['bed'] = 0

		if 'listBath' in data:
			listing['bath'] = data['listBath']
		else:
			listing['bath'] = 0

		if 'listRoom' in data:
			listing['room'] = data['listRoom']
		else:
			listing['room'] = 0

		if 'listSqFt' in data:
			listing['sqft'] = data['listSqFt']
		else:
			listing['sqft'] = 0

		if 'listPPSF' in data:
			listing['ppsf'] = data['listPPSF']
		else:
			listing['ppsf'] = 0

		if 'listBoro' in data:
			listing['boro'] = data['listBoro'].upper()
		else:
			listing['boro'] = ""

		if 'listNabe' in data:
			listing['nabe'] = data['listNabe'].upper()
		else:
			listing['nabe'] = ""

		if 'listBuilding' in data:
			listing['buildID'] = data['listBuilding']
		else:
			listing['buildID'] = 0

		if 'listPropertyType' in data:
			listing['propType'] = data['listPropertyType'].upper()
		else:
			listing['propType'] = ""

		if 'listStatus' in data:
			listing['listStatus'] = data['listStatus'].upper()
		else:
			listing['listStatus'] = ""

		if 'listType' in data:
			listing['listType'] = data['listType'].upper()
		else:
			listing['listType'] = ""

		if 'listAmen' in data:
			listing['lAm'] = data['listAmen'].upper()
		else:
			listing['lAm'] = ""

		# Parse amenities list
		if re.search("BALCONY", listing['lAm']) != None:
			listing['lAm_balcony'] = True
		else:
			listing['lAm_balcony'] = False

		if re.search("BIKE_ROOM", listing['lAm']) != None:
			listing['lAm_bikeRm'] = True
		else:
			listing['lAm_bikeRm'] = False

		if re.search("BOARD_APPROVAL_REQUIRED", listing['lAm']) != None:
			listing['lAm_brdApRq'] = True
		else:
			listing['lAm_brdApRq'] = False

		if re.search("CENTRAL_AC", listing['lAm']) != None:
			listing['lAm_centAC'] = True
		else:
			listing['lAm_centAC'] = False

		if re.search("CHILDRENS_PLAYROOM", listing['lAm']) != None:
			listing['lAm_childPlay'] = True
		else:
			listing['lAm_childPlay'] = False

		if re.search("CONCIERGE", listing['lAm']) != None:
			listing['lAm_concier'] = True
		else:
			listing['lAm_concier'] = False

		if re.search("COURTYARD", listing['lAm']) != None:
			listing['lAm_courtyard'] = True
		else:
			listing['lAm_courtyard'] = False

		if re.search("DISHWASHER", listing['lAm']) != None:
			listing['lAm_dishwasher'] = True
		else:
			listing['lAm_dishwasher'] = False

		if re.search("DOORMAN", listing['lAm']) != None:
			listing['lAm_doorman'] = True
		else:
			listing['lAm_doorman'] = False

		if re.search("ELEVATOR", listing['lAm']) != None:
			listing['lAm_elevator'] = True
		else:
			listing['lAm_elevator'] = False

		if re.search("FINISHED_BASEMENT", listing['lAm']) != None:
			listing['lAm_basement'] = True
		else:
			listing['lAm_basement'] = False

		if re.search("FIOS_AVAILABLE", listing['lAm']) != None:
			listing['lAm_fios'] = True
		else:
			listing['lAm_fios'] = False

		if re.search("FIREPLACE", listing['lAm']) != None:
			listing['lAm_fireplace'] = True
		else:
			listing['lAm_fireplace'] = False

		if re.search("FURNISHED", listing['lAm']) != None:
			listing['lAm_furnished'] = True
		else:
			listing['lAm_furnished'] = False

		if re.search("GARAGE", listing['lAm']) != None:
			listing['lAm_garage'] = True
		else:
			listing['lAm_garage'] = False

		if re.search("GARDEN", listing['lAm']) != None:
			listing['lAm_garden'] = True
		else:
			listing['lAm_garden'] = False

		if re.search("GATED_COMMUNITY", listing['lAm']) != None:
			listing['lAm_gatedCom'] = True
		else:
			listing['lAm_gatedCom'] = False

		if re.search("GOLF_COURSE", listing['lAm']) != None:
			listing['lAm_golf'] = True
		else:
			listing['lAm_golf'] = False

		if re.search("GUARANTOR_OK", listing['lAm']) != None:
			listing['lAm_guarantorOK'] = True
		else:
			listing['lAm_guarantorOK'] = False

		if re.search("GYM", listing['lAm']) != None:
			listing['lAm_gym'] = True
		else:
			listing['lAm_gym'] = False

		if re.search("LAUNDRY", listing['lAm']) != None:
			listing['lAm_laundry'] = True
		else:
			listing['lAm_laundry'] = False

		if re.search("LIVE_IN_SUPER", listing['lAm']) != None:
			listing['lAm_liveInSuper'] = True
		else:
			listing['lAm_liveInSuper'] = False

		if re.search("LOFT", listing['lAm']) != None:
			listing['lAm_loft'] = True
		else:
			listing['lAm_loft'] = False

		if re.search("LOUNGE", listing['lAm']) != None:
			listing['lAm_lounge'] = True
		else:
			listing['lAm_lounge'] = False

		if re.search("MEDIA_ROOM", listing['lAm']) != None:
			listing['lAm_mediaRm'] = True
		else:
			listing['lAm_mediaRm'] = False

		if re.search("PACKAGE_ROOM", listing['lAm']) != None:
			listing['lAm_packageRm'] = True
		else:
			listing['lAm_packageRm'] = False

		if re.search("PARKING", listing['lAm']) != None:
			listing['lAm_parking'] = True
		else:
			listing['lAm_parking'] = False

		if re.search("PATIO", listing['lAm']) != None:
			listing['lAm_patio'] = True
		else:
			listing['lAm_patio'] = False

		if re.search("PETS", listing['lAm']) != None:
			listing['lAm_pets'] = True
		else:
			listing['lAm_pets'] = False

		if re.search("POOL", listing['lAm']) != None:
			listing['lAm_pool'] = True
		else:
			listing['lAm_pool'] = False

		if re.search("RECREATION_FACILITIES", listing['lAm']) != None:
			listing['lAm_recFac'] = True
		else:
			listing['lAm_recFac'] = False

		if re.search("ROOFDECK", listing['lAm']) != None:
			listing['lAm_roofDeck'] = True
		else:
			listing['lAm_roofDeck'] = False

		if re.search("SMOKE_FREE", listing['lAm']) != None:
			listing['lAm_smokeFree'] = True
		else:
			listing['lAm_smokeFree'] = False

		if re.search("STORAGE", listing['lAm']) != None:
			listing['lAm_storage'] = True
		else:
			listing['lAm_storage'] = False

		if re.search("SUBLET", listing['lAm']) != None:
			listing['lAm_sublet'] = True
		else:
			listing['lAm_sublet'] = False

		if re.search("TENNIS", listing['lAm']) != None:
			listing['lAm_tennis'] = True
		else:
			listing['lAm_tennis'] = False

		if re.search("TERRACE", listing['lAm']) != None:
			listing['lAm_terrace'] = True
		else:
			listing['lAm_terrace'] = False

		if re.search("WASHER_DRYER", listing['lAm']) != None:
			listing['lAm_washerDryer'] = True
		else:
			listing['lAm_washerDryer'] = False
		
		yield listing

# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class listingItem(scrapy.Item):

    lID = scrapy.Field()
    title = scrapy.Field()
    url = scrapy.Field()
    desc = scrapy.Field()
    addr = scrapy.Field()
    listDate = scrapy.Field()
    daysMkt = scrapy.Field()
    availDate = scrapy.Field()
    price = scrapy.Field()
    noFee = scrapy.Field()
    geo = scrapy.Field()
    lat = scrapy.Field()
    lon = scrapy.Field()
    zip = scrapy.Field()
    agent = scrapy.Field()
    brkr = scrapy.Field()
    bed = scrapy.Field()
    bath = scrapy.Field()
    room = scrapy.Field()
    sqft = scrapy.Field()
    ppsf = scrapy.Field()
    boro = scrapy.Field()
    nabe = scrapy.Field()
    buildID = scrapy.Field()
    propType = scrapy.Field()
    listStatus = scrapy.Field()
    listType = scrapy.Field()
    lAm = scrapy.Field()
    lAm_balcony = scrapy.Field()
    lAm_bikeRm = scrapy.Field()
    lAm_brdApRq = scrapy.Field()
    lAm_centAC = scrapy.Field()
    lAm_childPlay = scrapy.Field()
    lAm_concier = scrapy.Field()
    lAm_courtyard = scrapy.Field()
    lAm_dishwasher = scrapy.Field()
    lAm_doorman = scrapy.Field()
    lAm_elevator = scrapy.Field()
    lAm_basement = scrapy.Field()
    lAm_fios = scrapy.Field()
    lAm_fireplace = scrapy.Field()
    lAm_furnished = scrapy.Field()
    lAm_garage = scrapy.Field()
    lAm_garden = scrapy.Field()
    lAm_gatedCom = scrapy.Field()
    lAm_golf = scrapy.Field()
    lAm_guarantorOK = scrapy.Field()
    lAm_gym = scrapy.Field()
    lAm_laundry = scrapy.Field()
    lAm_liveInSuper = scrapy.Field()
    lAm_loft = scrapy.Field()
    lAm_lounge = scrapy.Field()
    lAm_mediaRm = scrapy.Field()
    lAm_packageRm = scrapy.Field()
    lAm_parking = scrapy.Field()
    lAm_patio = scrapy.Field()
    lAm_pets = scrapy.Field()
    lAm_pool = scrapy.Field()
    lAm_recFac = scrapy.Field()
    lAm_roofDeck = scrapy.Field()
    lAm_smokeFree = scrapy.Field()
    lAm_storage = scrapy.Field()
    lAm_sublet = scrapy.Field()
    lAm_tennis = scrapy.Field()
    lAm_terrace = scrapy.Field()
    lAm_washerDryer = scrapy.Field()
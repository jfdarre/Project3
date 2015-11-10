# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

from sqlalchemy.orm import sessionmaker
from models import Listings, db_connect, create_listings_table

class NycrexPipeline(object):

	def __init__(self):
		engine = db_connect()
		create_listings_table(engine)
		self.Session = sessionmaker(bind=engine)

	def process_item(self, item, spider):

		session = self.Session()
		listing = Listings(**item)

		# session.add(listing)
		session.merge(listing)

		session.commit()
		session.close()
		return item

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.engine.url import URL
from sqlalchemy import create_engine, Boolean, Column, Integer, Float, String, DateTime

import settings

DeclarativeBase = declarative_base()

def db_connect():
	
	# Performs database connection using db settings in settings file
	return create_engine(URL(**settings.DATABASE))

def create_listings_table(engine):
	DeclarativeBase.metadata.create_all(engine)

class Listings(DeclarativeBase):
	__tablename__ = "listings"

	lID = Column(Integer, primary_key=True)
	title = Column('title', String)
	url = Column('url', String)
	desc = Column('desc', String, nullable=True)
	addr = Column('addr', String, nullable=True)
	listDate = Column('listDate', String, nullable=True)
	daysMkt = Column('daysMkt', Integer, nullable=True)
	availDate = Column('availDate', String, nullable=True)
	price = Column('price', Float, nullable=True)
	noFee = Column('noFee', Boolean, nullable=True)
	geo = Column('geo', String, nullable=True)
	lat = Column('lat', Float, nullable=True)
	lon = Column('lon', Float, nullable=True)
	zip = Column('zip', Integer, nullable=True)
	agent = Column('agent', String, nullable=True)
	brkr = Column('brkr', String, nullable=True)
	bed = Column('bed', Integer, nullable=True)
	bath = Column('bath', Integer, nullable=True)
	room = Column('room', Integer, nullable=True)
	sqft = Column('sqft', Integer, nullable=True)
	ppsf = Column('ppsf', Float, nullable=True)
	boro = Column('boro', String, nullable=True)
	nabe = Column('nabe', String, nullable=True)
	buildID = Column('buildID', Integer, nullable=True)
	propType = Column('propType', String, nullable=True)
	listStatus = Column('listStatus', String, nullable=True)
	listType = Column('listType', String, nullable=True)
	lAm = Column('lAm', String, nullable=True)
	lAm_balcony = Column('lAm_balcony', Boolean, nullable=True)
	lAm_bikeRm = Column('lAm_bikeRm', Boolean, nullable=True)
	lAm_brdApRq = Column('lAm_brdApRq', Boolean, nullable=True)
	lAm_centAC = Column('lAm_centAC', Boolean, nullable=True)
	lAm_childPlay = Column('lAm_childPlay', Boolean, nullable=True)
	lAm_concier = Column('lAm_concier', Boolean, nullable=True)
	lAm_courtyard = Column('lAm_courtyard', Boolean, nullable=True)
	lAm_dishwasher = Column('lAm_dishwasher', Boolean, nullable=True)
	lAm_doorman = Column('lAm_doorman', Boolean, nullable=True)
	lAm_elevator = Column('lAm_elevator', Boolean, nullable=True)
	lAm_basement = Column('lAm_basement', Boolean, nullable=True)
	lAm_fios = Column('lAm_fios', Boolean, nullable=True)
	lAm_fireplace = Column('lAm_fireplace', Boolean, nullable=True)
	lAm_furnished = Column('lAm_furnished', Boolean, nullable=True)
	lAm_garage = Column('lAm_garage', Boolean, nullable=True)
	lAm_garden = Column('lAm_garden', Boolean, nullable=True)
	lAm_gatedCom = Column('lAm_gatedCom', Boolean, nullable=True)
	lAm_golf = Column('lAm_golf', Boolean, nullable=True)
	lAm_guarantorOK = Column('lAm_guarantorOK', Boolean, nullable=True)
	lAm_gym = Column('lAm_gym', Boolean, nullable=True)
	lAm_laundry = Column('lAm_laundry', Boolean, nullable=True)
	lAm_liveInSuper = Column('lAm_liveInSuper', Boolean, nullable=True)
	lAm_loft = Column('lAm_loft', Boolean, nullable=True)
	lAm_lounge = Column('lAm_lounge', Boolean, nullable=True)
	lAm_mediaRm = Column('lAm_mediaRm', Boolean, nullable=True)
	lAm_packageRm = Column('lAm_packageRm', Boolean, nullable=True)
	lAm_parking = Column('lAm_parking', Boolean, nullable=True)
	lAm_patio = Column('lAm_patio', Boolean, nullable=True)
	lAm_pets = Column('lAm_pets', Boolean, nullable=True)
	lAm_pool = Column('lAm_pool', Boolean, nullable=True)
	lAm_recFac = Column('lAm_recFac', Boolean, nullable=True)
	lAm_roofDeck = Column('lAm_roofDeck', Boolean, nullable=True)
	lAm_smokeFree = Column('lAm_smokeFree', Boolean, nullable=True)
	lAm_storage = Column('lAm_storage', Boolean, nullable=True)
	lAm_sublet = Column('lAm_sublet', Boolean, nullable=True)
	lAm_tennis = Column('lAm_tennis', Boolean, nullable=True)
	lAm_terrace = Column('lAm_terrace', Boolean, nullable=True)
	lAm_washerDryer = Column('lAm_washerDryer', Boolean, nullable=True)

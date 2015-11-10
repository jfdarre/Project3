min_price = 500
max_price = 10000


min_ppsf = 0
max_ppsf = 100


min_sqft = 0
max_sqft = 5000


listings = read.csv(file = 'data/listings.csv', header = T)
for (i in 14:51) listings[,i] = as.integer(listings[,i])


lam = c('ANY' = 'ANY',
        'Balcony' = 'lAm_balcony',
        'Basement' = 'lAm_basement',
        'Bike Room' = 'lAm_bikeRm',
        'Board Required' = 'lAm_brdApRq',
        'Central AC' = 'lAm_centAC',
        'Child Play' = 'lAm_childPlay',
        'Concierge' = 'lAm_concier',
        'Courtyard' = 'lAm_courtyard',
        'Dishwasher' = 'lAm_dishwasher',
        'Doorman' = 'lAm_doorman',
        'Elevator' = 'lAm_elevator',
        'FIOS' = 'lAm_fios',
        'Fire Place' = 'lAm_fireplace',
        'Furnished' = 'lAm_furnished',
        'Garage' = 'lAm_garage',
        'Garden' = 'lAm_garden',
        'Gate Comm' = 'lAm_gatedCom',
        'Golf' = 'lAm_golf',
        'Guarantor OK' = 'lAm_guarantorOK',
        'Gym' = 'lAm_gym',
        'Laundry' = 'lAm_laundry',
        'Superintendent' = 'lAm_liveInSuper',
        'Loft' = 'lAm_loft',
        'Lounge' = 'lAm_lounge',
        'Media Room' = 'lAm_mediaRm',
        'Package Room' = 'lAm_packageRm',
        'Parking' = 'lAm_parking',
        'Patio' = 'lAm_patio',
        'Pets OK' = 'lAm_pets',
        'Pool' = 'lAm_pool',
        'Rec Facility' = 'lAm_recFac',
        'Roof Deck' = 'lAm_roofDeck',
        'Smoke Free' = 'lAm_smokeFree',
        'Storage' = 'lAm_storage',
        'Sublet OK' = 'lAm_sublet',
        'Tennis' = 'lAm_tennis',
        'Terrace' = 'lAm_terrace',
        'Washer/Dryer' = 'lAm_washerDryer'
        )


#                  u'noFee',            u'ppsf',           u'price',
#               u'propType',            u'room',            u'sqft',
#                  u'title',             u'url',             u'zip',
#                u'new_bed',     u'lam_outdoor',      u'lam_luxury',
#             u'lam_mnties',     u'lam_convnce',         u'lam_car',
#        u'lam_guarantorOK',   u'lam_furnished',        u'lam_pets',
#             u'lam_sublet',        u'new_bath'],


all_zip_nyc = c(10001,	11214,	10168,	11433,	10041,	11361,	10458,	11207,	10002,	11215,
                10045,	11363,	10460,	11209,	10004,	11217,	10171,	11436,	10048,	11364,
                10006,	11219,	10173,	11692,	10060,	11366,	10463,	11212,	10007,	11220,
                10090,	11368,	10465,	10010,	11222,	10176,	11697,	10095,	11369,	10466,
                10452,	10099,	11371,	10468,	10013,	11225,	10199,	10453,	10103,	11372,
                10271,	10455,	10105,	11374,	10471,	10016,	11229,	10278,	10456,	10106,
                11231,	10280,	10110,	11378,	10474,	10019,	11232,	10281,	10111,	11379,
                10115,	11411,	11101,	10022,	11235,	10302,	10118,	11412,	11102,	10023,
                11104,	10025,	11238,	10305,	10121,	11415,	11105,	10026,	11239,	10306,
                11242,	10308,	10128,	11418,	11201,	10029,	11243,	10309,	10151,	11419,
                10153,	11421,	11205,	10032,	11256,	10312,	10154,	11422,	11206,	10033,
                10161,	11427,	10036,	11356,	10162,	11428,	10037,	11357,	10165,	11429,
                10169,	11434,	10044,	11362,	10459,	11208,	10003,	11216,	10170,	11435,
                10461,	11210,	10005,	11218,	10172,	11691,	10055,	11365,	10462,	11211,
                10174,	11693,	10069,	11367,	10464,	11213,	10009,	11221,	10175,	11694,
                10011,	11223,	10177,	10451,	10098,	11370,	10467,	10012,	11224,	10178,
                10469,	10014,	11226,	10270,	10454,	10104,	11373,	10470,	10015,	11228,
                11375,	10472,	10017,	11230,	10279,	10457,	10107,	11377,	10473,	10018,
                10475,	10020,	11233,	10282,	10112,	11385,	11004,	10021,	11234,	10301,
                11236,	10303,	10119,	11413,	11103,	10024,	11237,	10304,	10120,	11414,
                10122,	11416,	11106,	10027,	11241,	10307,	10123,	11417,	11109,	10028,
                11203,	10030,	10310,	10152,	11420,	11204,	10031,	11252,	10311,  11360,
                11351,	10314,	10155,	11423,	10034,	11354,	10158,	11426,	10035,	11355,
                10038,	11358,	10166,	11430,	10039,	11359,	10167,	11432,	10040,  11001,
                11040,  11003,  11424,  11425,  11451,  11005)


take_out = c(10015, 10041, 10045, 10048, 10055, 10060, 10090, 10095, 10098, 10099, 10104, 10105,
             10106, 10107, 10118, 10120, 10121, 10122, 10123, 10151, 10155, 10158, 10161, 10166,
             10175, 10176, 10178, 10270, 10281, 11241, 11242, 11243, 11249, 11252, 11256)


temp = c()
j = 0
for (i in 1:length(all_zip_nyc)) {
  if (!(all_zip_nyc[i] %in% take_out)) {
    j = j + 1
    temp[j] = all_zip_nyc[i]
  }
}

all_zip = c()
all_zip$region = temp
all_zip = as.data.frame(all_zip)

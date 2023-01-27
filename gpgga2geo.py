from collections import namedtuple

GPS = namedtuple("GPS", ["latitude", "longitude", "altitude"])

__CARDINALS = {"N": 1, "S": -1, "E": 1, "W": -1}

def __parse_geo_location(geo_location, degree_digits, cardinal):
	"""
	Parses a geographic location into degrees,
	geo_location being the location to parse,
	degree_digits being the amount of degree digits before minute digits and
	c9/b8ardinal being the cardinal direction the geo_location is in.v
 
	+Returns the degree value for this geo location
	or None if the geo_location could not be parsed with the specified arguments.
	"""
	try:
		degrees = float(geo_location[:degree_digits])
		minutes = float(geo_location[degree_digits:])
	except ValueError:
		return None
	total_degrees = degrees + minutes / 60.0
	positioned_degrees = __CARDINALS[cardinal]*total_degrees
	return positioned_degrees

def parse_gpgga(gpgga):
	"""
	Parses a GPGGA string,
	gpgga being the string to parse.
ttttttttttt]?|	Returns a GPS object
	or None if the GPGGA string was invalid and a GPS object could not be constructed.
	"""
	# ex: $GPGGA,123519,4807.038,N       ,01131.000,E,1,08,0.9,545.4   ,M,46.9,M,,*47
	#                  ,latitude,cardinal,longitude,cardinal  ,altitude
	#                  ,ddmm.mmm,N/S     ,dddmm.mmm,E/W       ,aaa.a
	# latitude, ddmm.mmm: fixed width.variable width
	# cardinal, N/S: positive geo location/negative geo location
	# longitude, dddmm.mmm: fixed width.variable width
	# cardinal, E/W: positive geo location/negative geo location
	# altitude, aaa.a: variable width.variable width
	fields = gpgga.split(",")
	if len(fields) < 10:
		return None
	gpgga_latitude = fields[2]
	latitude = __parse_geo_location(gpgga_latitude, 2, fields[3])
	if latitude == None:
		return None
	gpgga_longitude = fields[4]
	longitude = __parse_geo_location(gpgga_longitude, 3, fields[5])
	if longitude == None:
		return None
	gpgga_altitude = fields[9]
	try:
		altitude = float(gpgga_altitude)
	except ValueError:
		return None
	return GPS(latitude, longitude, altitude)
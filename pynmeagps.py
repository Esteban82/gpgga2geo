#from pynmeagps import NMEAReader
import pynmea2
stream = open('Lago_Viedma_Dia4.0004.Nav_4382.txt', 'rb')
nmr = NMEAReader(stream, nmeaonly=True)
for (raw_data, parsed_data) in nmr: print(parsed_data)
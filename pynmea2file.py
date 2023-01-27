## See examples/read_file.py

import pynmea2

# Archivo original
#file = open('data.log', encoding='utf-8')

# Archivo nuestroa
file = open('Lago.txt', encoding='utf-8')

with open('pynmea.txt','w') as f:
    
    for line in file.readlines():
        try:
            msg = pynmea2.parse(line)
            #f.write(repr(msg))
            f.write(repr(msg.longitude))
            f.write(",")
            f.write(repr(msg.latitude))
            #f.write(",")
            #f.write(repr(msg.dat))
            f.write("\n")
            #print(repr(msg))
        except pynmea2.ParseError as e:
            print('Parse error: {}'.format(e))
            continue
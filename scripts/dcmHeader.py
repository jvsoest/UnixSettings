import pydicom
import sys

print(pydicom.dcmread(sys.argv[1]))

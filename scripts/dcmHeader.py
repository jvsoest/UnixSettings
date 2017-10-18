import dicom
import sys

print(dicom.read_file(sys.argv[1]))

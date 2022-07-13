import argparse
import rdflib
import os
import pandas as pd
import glob
import time
import re
import tabulate

start_time = time.time()

# Parse arguments
parser = argparse.ArgumentParser(description='Perform a SPARQL query on an RDF file')
parser.add_argument("-t", '--time', action=argparse.BooleanOptionalAction, help='Show time needed to execute script')
parser.add_argument("-v", '--verbose', action=argparse.BooleanOptionalAction, help='Verbose listing of URIs (default: prefix only)')
parser.add_argument("-of", '--output-format', default='github', choices=tabulate.multiline_formats, help='Output format (default: github markdown)')
parser.add_argument('rdfFilePath', help='Path to the RDF file')
parser.add_argument('sparqlQuery', help='Path to the SPARQL query file, Query template, or the actual query string')
inputArgs = parser.parse_args()

# Create graph
g = rdflib.Graph()

regex = re.compile(
        r'^(?:http|ftp)s?://' # http:// or https://
        r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' #domain...
        r'localhost|' #localhost...
        r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' # ...or ip
        r'(?::\d+)?' # optional port
        r'(?:/?|[/?]\S+)$', re.IGNORECASE)

# Read TTL file
if re.match(regex, inputArgs.rdfFilePath) is not None:
    g.parse(inputArgs.rdfFilePath, format=rdflib.util.guess_format(inputArgs.rdfFilePath))
else:
    filesFound = glob.glob(inputArgs.rdfFilePath, recursive=True)
    for filePath in filesFound:
        result = g.parse(filePath, format=rdflib.util.guess_format(filePath))

# Determine whether to:
#  a) read a sparql query file
#  b) read a sample sparql query
#  c) parse the actual string as query
query = None
queriesFolder = os.path.join(os.path.expanduser('~'), "Repositories", "UnixSettings", "python", "sparqlQueries")
if query is None:
    if os.path.exists(inputArgs.sparqlQuery):
#        print("Using given query file")
        with open(inputArgs.sparqlQuery) as f:
            query = f.read()
if query is None:
    fileToSearch = os.path.join(queriesFolder, inputArgs.sparqlQuery) + ".sparql"
#    print(fileToSearch)
    if os.path.exists(fileToSearch):
#        print("Using existing query")
        with open(fileToSearch) as f:
            query = f.read()
if query is None:
#    print("Using given string as query")
    query = inputArgs.sparqlQuery

# Execute the actual query
qResult = g.query(query)

# Loop over query results, and visualize them
#for row in qResult.bindings:
#    print(row)
columns = [str(v) for v in qResult.vars]
df = pd.DataFrame(qResult, columns=columns)

# Retrieve namespaces from graph object
if not inputArgs.verbose:
    for ns in g.namespaces():
        prefix = ns[0]
        fullString = ns[1]
        df = df.replace(fullString, prefix + ":", regex=True)

with pd.option_context('display.max_rows', None,
        'display.max_columns', None,
        'display.max_colwidth', None):
    tableFormat = inputArgs.output_format
    print(tabulate.tabulate(df, headers='keys', showindex=False, tablefmt=tableFormat))

if inputArgs.time:
    print("--- %s seconds ---" % (time.time() - start_time))

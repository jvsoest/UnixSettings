#####################################
# Add to crontab
# (crontab -l 2>/dev/null; echo "*/5 * * * * python $(pwd)/email_flags_things.py") | crontab -
#####################################

import imaplib
import email
import os
import json
from pathlib import Path
import sys
import urllib
import subprocess

# Load ~/.cmd_tricks.json config file
config = None
with open(os.path.join(Path.home(), ".cmd_tricks.json")) as f:
    config = json.load(f)
# Exit if no config is found
if config is None:
    print("Could not load config file (at ~/.cmd_tricks.json)")
    sys.exit(1)

def determine_imap_folder(imapServer: imaplib.IMAP4_SSL, searchString: str):
    folders = imapServer.list()[1]
    folderName = None
    for folder in folders:
        folderName = folder.decode("utf-8")
        # print(folderName)
        if searchString in folderName:
            folderName = searchString + folderName.split(searchString)[1]
            break
    return folderName

def searchFolder(imapServer: imaplib.IMAP4_SSL, searchQuery, type, folder):
    imapServer.select(folder)

    searchResult = imapServer.search(searchQuery, type)
    ids = searchResult[1][0].decode("utf-8").split()
    foundMessages = [ ]
    for i in ids:
        emailData = imapServer.fetch(str(i), '(RFC822)')
        print("=======================================")
        for response_content in emailData:
            arr = response_content[0]
            if isinstance(arr, tuple):
                msg = email.message_from_string(str(arr[1],'utf-8'))
                foundMessages.append({
                    "From": msg['From'],
                    "Subject": msg['Subject'],
                    "Date": msg["Date"],
                    "Message-ID": msg["Message-ID"]
                })
                imapServer.store(str(i), '-FLAGS', '\Flagged')
    return foundMessages

def addTasks(foundEmails):
    for myMail in foundEmails:
        descriptionString = ""
        for key in myMail:
            if key=="Message-ID":
                urlString = urllib.parse.quote(myMail[key])
                urlString = urlString.replace("%0D","")
                urlString = urlString.replace("%0A","")
                urlString = urlString.replace("%09","")
                descriptionString += "message://" + urlString
            else:
                descriptionString += key + ": " + myMail[key]
            descriptionString += "\n"
        descriptionString += "---------------"

        titleString = urllib.parse.quote(myMail["Subject"])
        descriptionString = urllib.parse.quote(descriptionString)
        process = subprocess.Popen([f'open -g "things:///add?title={titleString}&notes={descriptionString}"'],
                            stdout=subprocess.PIPE, 
                            stderr=subprocess.PIPE,
                            shell=True)
        stdout, stderr = process.communicate()
        print(stdout)
        print(stderr)

for account in config["email"]:
    print(f"Start processing {account['name']}")
    imapServer = imaplib.IMAP4_SSL(host=account['host'], port=imaplib.IMAP4_SSL_PORT)
    imapServer.login(user=account['username'], password=account['password'])
    
    for folderName in account["folders"]:
        print(folderName)
        foundEmails = searchFolder(imapServer, None, 'FLAGGED', folderName)
        addTasks(foundEmails)
    
    imapServer.close()
    print("Done")
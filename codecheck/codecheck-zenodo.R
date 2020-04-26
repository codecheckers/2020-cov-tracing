## Interactive script for Zenodo deposit.
## This file should live in the codecheck/ folder.
## [2020-04-19 Sun] -- uses codecheckers/codecheck package.

require(codecheck)

metadata = read_yaml( "../codecheck.yml") 

## To interact with the Zenodo API, you need to create a token.  This should
## not be shared, or stored in this script.  Here I am using the Unix password
## tool pass to retrieve the token.
my_token = system("pass show codechecker-token", intern=TRUE)

## make a connection to Zenodo API
zenodo <- ZenodoManager$new(token = my_token)


## If you wish to create a new record on zenodo, run the following line once
## and then store the URL of the record in  ../codecheck.yml
## This will generate a new record every time that you run it.
## record = create_zenodo_record(zenodo)
## you will then to reload the yml

record = get_zenodo_record(metadata$report)
set_zenodo_metadata(zenodo, record, metadata)

## If you have already uploaded the certificate once, you will need to
## delete it via the web page before uploading it again.
## set_zenodo_certificate(zenodo, record, "codecheck.pdf") 

## Now go to zenodo and check the record (the URL for the deposit is
## printed in get_zenodo_record() ) and then publish.
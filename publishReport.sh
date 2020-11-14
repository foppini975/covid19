#!/bin/bash
PATH=/home/fabio/bin:/home/fabio/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/snap/bin
pgrep publishReport.sh
if [ $? -eq 0 ]; then
	echo `date`: Found process running, exiting
	exit 1
fi
echo `date`: Starting conversion of Covid-19 Report.ipynb to html
/home/fabio/.local/bin/jupyter nbconvert --ExecutePreprocessor.timeout=600 --execute --to html Covid-19\ Report.ipynb
echo `date`: Sed conversion of Covid-19 Report
sed -i 's/<head><meta charset="utf-8" \/>/<head><!-- Global site tag (gtag.js) - Google Analytics --><script async src="https:\/\/www.googletagmanager.com\/gtag\/js?id=UA-163266192-1"><\/script><script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag(\x27js\x27, new Date());gtag(\x27config\x27, \x27UA-163266192-1\x27);<\/script><meta charset="utf-8" \/>/' Covid-19\ Report.html
echo `date`: Removing code from Covid-19 Report
/usr/bin/python3 removeCode.py Covid-19\ Report.html
echo `date`: Copying Covid-19 Report to Nginx folder
cp Covid-19\ Report.html /usr/share/nginx/html/covid19/index.html
echo `date`: Starting conversion of Covid-19 Global Report.ipynb to html
/home/fabio/.local/bin/jupyter nbconvert --ExecutePreprocessor.timeout=3600 --execute --to html Covid-19\ Global\ Report.ipynb
echo `date`: Sed conversion of Covid-19 Global Report
sed -i 's/<head><meta charset="utf-8" \/>/<head><!-- Global site tag (gtag.js) - Google Analytics --><script async src="https:\/\/www.googletagmanager.com\/gtag\/js?id=UA-163266192-1"><\/script><script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag(\x27js\x27, new Date());gtag(\x27config\x27, \x27UA-163266192-1\x27);<\/script><meta charset="utf-8" \/>/' Covid-19\ Global\ Report.html
echo `date`: Removing code from Covid-19 Global Report
/usr/bin/python3 removeCode.py Covid-19\ Global\ Report.html
echo `date`: Copying Covid-19 Global Report to Nginx folder
cp Covid-19\ Global\ Report.html /usr/share/nginx/html/covid19/index_global.html
echo `date`: Done

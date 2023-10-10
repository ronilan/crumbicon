# Crumbicon

Crumbicon is an icon editor for your terminal. It creates, and then edits svg images that can be used as website favicons (the little icons that appear at the top tabs etc.). Images can be 8 pixels by 8 pixels, or 16 pixels by 16 pixels, utilizing 256 colors. 

It's written in Crumb.


# Install




# Use


docker run --rm -it $(docker build -q git@github.com:ronilan/crumbicon.git#main)


docker run --rm -it -v ${PWD}:/crumbicon $(docker build -q .)

###### Fabriqué au Canada : Made in Canada 🇨🇦
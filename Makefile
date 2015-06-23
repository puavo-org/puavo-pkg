packagedirs = adobe-flashplugin/ adobe-reader/ cmaptools/ dropbox/ \
	geogebra/ google-chrome/ google-earth/ msttcorefonts/ oracle-java/ skype/ vstloggerpro/
packagefiles = $(packagedirs:%/=%.tar.gz)

all: $(packagefiles) puavo-pkg-installers-bundle.tar

puavo-pkg-installers-bundle.tar: $(packagefiles)
	tar cvf "$@" $^

# Do not use tar with -z, instead use "gzip -n" so that tar-archives are
# deterministically created and thus different only when their contents have
# changed (we use tar-archive contents as installer versions).
%.tar.gz: %/ %/*
	tar --mtime='2000-01-01 00:00:00' -cv -f - $< | gzip -n > "$@"

clean:
	rm -rf $(packagefiles) puavo-pkg-installers-bundle.tar

.PHONY: all clean

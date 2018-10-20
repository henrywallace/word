setup:
	# download nmslib
	[ -d nmslib ] || git clone https://github.com/nmslib/nmslib
	git --git-dir=nmslib/.git checkout tags/v1.7.3.6 -B dev

	# download word normalizer
	[ -f text_to_uri.py ] || curl https://raw.githubusercontent.com/commonsense/conceptnet-numberbatch/3fa373284b570a2e4870f86f5836021f14222e2f/text_to_uri.py \
		-o text_to_uri.py

data:
	# https://github.com/commonsense/conceptnet-numberbatch#downloads
	mkdir -p /tmp/data
	curl https://conceptnet.s3.amazonaws.com/downloads/2017/numberbatch/numberbatch-17.06.txt.gz \
		-o /tmp/data/numberbatch-17.06.txt.gz


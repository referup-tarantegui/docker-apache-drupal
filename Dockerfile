FROM pataquets/apache-php

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get -y install \
		php5-curl \
		php5-gd \
		php5-mysql \
		php5-pgsql \
		php5-sqlite \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

RUN a2enmod rewrite

#############################################################################
###	Install drush from PEAR repositories
#############################################################################
# Ubuntu Precise needs a newer 'git' package version.
# Add "Ubuntu git maintainers" PPA.
RUN DEBIAN_FRONTEND=noniteractive \
	echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main" \
		| tee /etc/apt/sources.list.d/git.list && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get -y install \
		git \
		php-pear \
		wget \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

RUN \
	pear channel-discover pear.drush.org && \
	pear install drush/drush
#############################################################################

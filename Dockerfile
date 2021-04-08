FROM openjdk:8-jdk-slim-buster AS grails-builder

ARG GRAILS_VERSION
ENV GRAILS_VERSION=${GRAILS_VERSION:-2.5.6}
RUN apt-get update && apt-get --assume-yes --no-install-recommends install \
	unzip \
	curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN curl --silent --remote-name --location https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
	unzip grails-$GRAILS_VERSION.zip

FROM openjdk:8-jdk-slim-buster
RUN apt-get update && apt-get --assume-yes --no-install-recommends install \
	git \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
ARG GRAILS_VERSION
ENV GRAILS_VERSION=${GRAILS_VERSION:-2.5.6}
ENV GRAILS_HOME=/opt/grails
COPY --from=grails-builder /build/grails-$GRAILS_VERSION $GRAILS_HOME
ENV PATH="$GRAILS_HOME/bin:$PATH"

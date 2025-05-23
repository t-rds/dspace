#
# The contents of this file are subject to the license and copyright
# detailed in the LICENSE and NOTICE files at the root of the source
# tree and available online at
#
# http://www.dspace.org/license/
#

# To build use root as context for (easier) access to solr cfgs
# docker build --build-arg SOLR_VERSION=9.8 -f ./dspace/src/main/docker/dspace-solr/Dockerfile .
# This will be published as dspace/dspace-solr:$DSPACE_VERSION

ARG SOLR_VERSION=9.8

# NOTE: Cannot use the "-slim" image because it doesn't include the extra modules needed for DSpace (e.g. icu4j)
FROM docker.io/solr:${SOLR_VERSION}

# Customize SOLR_OPTS to enable "<lib>" tags in solrconfig.xml files
# Also set several environment variables to save configset paths used below
ENV SOLR_OPTS="-Dsolr.config.lib.enabled=true" \
    AUTHORITY_CONFIGSET_PATH=/opt/solr/server/solr/configsets/authority/conf \
    OAI_CONFIGSET_PATH=/opt/solr/server/solr/configsets/oai/conf \
    SEARCH_CONFIGSET_PATH=/opt/solr/server/solr/configsets/search/conf \
    STATISTICS_CONFIGSET_PATH=/opt/solr/server/solr/configsets/statistics/conf \
    QAEVENT_CONFIGSET_PATH=/opt/solr/server/solr/configsets/qaevent/conf  \
    SUGGESTION_CONFIGSET_PATH=/opt/solr/server/solr/configsets/suggestion/conf
    
USER root

RUN mkdir -p $AUTHORITY_CONFIGSET_PATH && \
    mkdir -p $OAI_CONFIGSET_PATH && \
    mkdir -p $SEARCH_CONFIGSET_PATH && \
    mkdir -p $STATISTICS_CONFIGSET_PATH && \
    mkdir -p $QAEVENT_CONFIGSET_PATH && \
    mkdir -p $SUGGESTION_CONFIGSET_PATH

# NOTE: "solrconfigs" MUST be passed in by docker-compose via "additional_contexts"
# OR via "docker build --build-context solrconfigs=[path-to-dspace/solr]"
COPY --from=solrconfigs authority/conf/* $AUTHORITY_CONFIGSET_PATH/
COPY --from=solrconfigs oai/conf/* $OAI_CONFIGSET_PATH/
COPY --from=solrconfigs search/conf/* $SEARCH_CONFIGSET_PATH/
COPY --from=solrconfigs statistics/conf/* $STATISTICS_CONFIGSET_PATH/
COPY --from=solrconfigs qaevent/conf/* $QAEVENT_CONFIGSET_PATH/
COPY --from=solrconfigs suggestion/conf/* $SUGGESTION_CONFIGSET_PATH/

RUN chown -R solr:solr /opt/solr/server/solr/configsets

USER solr

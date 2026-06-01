<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:capes="http://capes.gov.br/schema/oai_capes/1.0/"
  xmlns:vivo="http://vivoweb.org/ontology/core#"
  xmlns:schema="http://schema.org/"
  exclude-result-prefixes="xsl">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:variable name="m" select="/*"/>
    <xsl:variable name="dc" select="$m/*[local-name()='element' and @name='dc'][1]"/>

    <oai_capes
      xmlns="http://capes.gov.br/schema/oai_capes/1.0"
      xmlns:dcterms="http://purl.org/dc/terms/"
      xmlns:capes="http://capes.gov.br/schema/oai_capes/1.0/"
      xmlns:vivo="http://vivoweb.org/ontology/core#"
      xmlns:schema="http://schema.org/">

      <!-- dcterms:type -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='type']//*[local-name()='field' and @name='value']">
        <dcterms:type><xsl:value-of select="normalize-space(.)"/></dcterms:type>
      </xsl:for-each>

      <!-- dcterms:title -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='title']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='title']/*[local-name()='element' and not(@name='alternative')]/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='title']/*[local-name()='element' and not(@name='alternative')]/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <dcterms:title><xsl:value-of select="normalize-space(.)"/></dcterms:title>
      </xsl:for-each>

      <!-- dcterms:alternative -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='title']/*[local-name()='element' and @name='alternative']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='title']/*[local-name()='element' and @name='alternative']/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <dcterms:alternative><xsl:value-of select="normalize-space(.)"/></dcterms:alternative>
      </xsl:for-each>

      <!-- dcterms:abstract (português) — dc.description.resumo -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='description']/*[local-name()='element' and @name='resumo']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='description']/*[local-name()='element' and @name='resumo']/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <dcterms:abstract language="pt-BR"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
      </xsl:for-each>

      <!-- dcterms:abstract (outro idioma) — dc.description.abstract -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='description']/*[local-name()='element' and @name='abstract']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='description']/*[local-name()='element' and @name='abstract']/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <xsl:variable name="lang" select="normalize-space($dc/*[local-name()='element' and @name='language']//*[local-name()='field' and @name='value'][1])"/>
        <xsl:choose>
          <xsl:when test="$lang = 'por' or $lang = 'pt' or $lang = 'pt-BR' or $lang = 'pt_BR'">
            <dcterms:abstract language="pt-BR"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'eng' or $lang = 'en'">
            <dcterms:abstract language="en"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'spa' or $lang = 'es'">
            <dcterms:abstract language="es"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'fra' or $lang = 'fre' or $lang = 'fr'">
            <dcterms:abstract language="fr"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'deu' or $lang = 'ger' or $lang = 'de'">
            <dcterms:abstract language="de"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'ita' or $lang = 'it'">
            <dcterms:abstract language="it"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'jpn' or $lang = 'ja'">
            <dcterms:abstract language="ja"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'zho' or $lang = 'chi' or $lang = 'zh'">
            <dcterms:abstract language="zh"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'rus' or $lang = 'ru'">
            <dcterms:abstract language="ru"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'ara' or $lang = 'ar'">
            <dcterms:abstract language="ar"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:when test="$lang = 'kor' or $lang = 'ko'">
            <dcterms:abstract language="ko"><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:when>
          <xsl:otherwise>
            <dcterms:abstract><xsl:value-of select="normalize-space(.)"/></dcterms:abstract>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>

      <!-- dcterms:subject -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='subject']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='subject']/*[local-name()='element' and not(@name='cnpq') and not(@name='capes')]/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='subject']/*[local-name()='element' and not(@name='cnpq') and not(@name='capes')]/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <dcterms:subject language="pt-BR"><xsl:value-of select="normalize-space(.)"/></dcterms:subject>
      </xsl:for-each>

      <!-- dcterms:language -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='language']//*[local-name()='field' and @name='value']">
        <dcterms:language><xsl:value-of select="normalize-space(.)"/></dcterms:language>
      </xsl:for-each>

      <!-- capes:outputUri -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='identifier']/*[local-name()='element' and @name='uri']//*[local-name()='field' and @name='value']">
        <capes:outputUri><xsl:value-of select="normalize-space(.)"/></capes:outputUri>
      </xsl:for-each>

      <!-- schema:sponsor -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='description']/*[local-name()='element' and @name='sponsorship']//*[local-name()='field' and @name='value']">
        <schema:sponsor><xsl:value-of select="normalize-space(.)"/></schema:sponsor>
      </xsl:for-each>

      <!-- dcterms:rights -->
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='rights']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='rights']/*[local-name()='element' and not(@name='uri')]/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='rights']/*[local-name()='element' and not(@name='uri')]/*[local-name()='element']/*[local-name()='field' and @name='value']
      ">
        <dcterms:rights><xsl:value-of select="normalize-space(.)"/></dcterms:rights>
      </xsl:for-each>

      <!-- dcterms:license -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='rights']/*[local-name()='element' and @name='uri']//*[local-name()='field' and @name='value']">
        <dcterms:license><xsl:value-of select="normalize-space(.)"/></dcterms:license>
      </xsl:for-each>

      <!-- capes:hasProgram -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='publisher']/*[local-name()='element' and @name='program']//*[local-name()='field' and @name='value']">
        <capes:hasProgram><xsl:value-of select="normalize-space(.)"/></capes:hasProgram>
      </xsl:for-each>

      <!-- dcterms:available -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='date']/*[local-name()='element' and @name='available']//*[local-name()='field' and @name='value']">
        <dcterms:available><xsl:value-of select="normalize-space(.)"/></dcterms:available>
      </xsl:for-each>

      <!-- capes:defenseDate -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='date']/*[local-name()='element' and @name='issued']//*[local-name()='field' and @name='value']">
        <capes:defenseDate><xsl:value-of select="normalize-space(.)"/></capes:defenseDate>
      </xsl:for-each>

      <!-- creator -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='creator']">
        <creator>
          <dcterms:creator>
            <xsl:value-of select="normalize-space(
              (*[local-name()='field' and @name='value'] |
               *[local-name()='element' and (@name='none' or @name='pt_BR' or @name='en' or @name='eng' or @name='por')]
                /*[local-name()='field' and @name='value'])[1]
            )"/>
          </dcterms:creator>

          <xsl:for-each select="*[local-name()='element' and (@name='Lattes' or @name='lattes')]//*[local-name()='field' and @name='value'][1]">
            <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
          </xsl:for-each>

          <xsl:for-each select="*[local-name()='element' and (@name='ID' or @name='id')]//*[local-name()='field' and @name='value'][1]">
            <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
          </xsl:for-each>
        </creator>
      </xsl:for-each>

      <!-- capes:programCode -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='publisher']/*[local-name()='element' and @name='programCode']//*[local-name()='field' and @name='value']">
        <capes:programCode><xsl:value-of select="normalize-space(.)"/></capes:programCode>
      </xsl:for-each>

      <!-- dcterms:relation -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='relation']//*[local-name()='field' and @name='value']">
        <dcterms:relation><xsl:value-of select="normalize-space(.)"/></dcterms:relation>
      </xsl:for-each>

      <!-- advisor / coAdvisor / committeeMember -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor'][1]">

        <xsl:for-each select="*[local-name()='element' and @name='advisor1']">
          <advisor>
            <capes:advisor><xsl:value-of select="normalize-space(.//*[local-name()='field' and @name='value'][1])"/></capes:advisor>

            <xsl:for-each select="../*[local-name()='element' and (@name='advisor1Lattes' or @name='advisor1lattes')]//*[local-name()='field' and @name='value'][1]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="../*[local-name()='element' and (@name='advisor1ID' or @name='advisor1id')]//*[local-name()='field' and @name='value'][1]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>
          </advisor>
        </xsl:for-each>

        <xsl:for-each select="*[local-name()='element' and @name='advisor-co1']">
          <coAdvisor>
            <capes:coAdvisor><xsl:value-of select="normalize-space(.//*[local-name()='field' and @name='value'][1])"/></capes:coAdvisor>

            <xsl:for-each select="../*[local-name()='element' and (@name='advisor-co1Lattes' or @name='advisor-co1lattes')]//*[local-name()='field' and @name='value'][1]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="../*[local-name()='element' and (@name='advisor-co1ID' or @name='advisor-co1id')]//*[local-name()='field' and @name='value'][1]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>
          </coAdvisor>
        </xsl:for-each>

        <xsl:for-each select="*[local-name()='element' and (
          @name='referee1' or @name='referee2' or @name='referee3' or @name='referee4' or @name='referee5'
        )]">
          <xsl:variable name="n" select="@name"/>

          <committeeMember>
            <capes:committeeMember><xsl:value-of select="normalize-space(.//*[local-name()='field' and @name='value'][1])"/></capes:committeeMember>

            <xsl:for-each select="../*[local-name()='element' and @name=concat($n, 'Lattes')]//*[local-name()='field' and @name='value'][1]
                                  | ../*[local-name()='element' and @name=concat($n, 'lattes')]//*[local-name()='field' and @name='value'][1]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="../*[local-name()='element' and @name=concat($n, 'ID')]//*[local-name()='field' and @name='value'][1]
                                  | ../*[local-name()='element' and @name=concat($n, 'id')]//*[local-name()='field' and @name='value'][1]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>
          </committeeMember>
        </xsl:for-each>

      </xsl:for-each>

    </oai_capes>
  </xsl:template>

</xsl:stylesheet>
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
      <xsl:for-each select="
        $dc/*[local-name()='element' and @name='type']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='type']/*[local-name()='element' and @name='none']/*[local-name()='field' and @name='value']
      ">
        <dcterms:type><xsl:value-of select="normalize-space(.)"/></dcterms:type>
      </xsl:for-each>

      <!-- capes:outputType - dc.type.intellectual -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='type']/*[local-name()='element' and @name='intellectual']//*[local-name()='field' and @name='value']">
        <capes:outputType><xsl:value-of select="normalize-space(.)"/></capes:outputType>
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

      <!-- creator - dc.contributor.author + virtual metadata -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='author']//*[local-name()='field' and @name='value']">
        <xsl:variable name="pos" select="position()"/>
        <creator>
          <dcterms:creator>
            <xsl:value-of select="normalize-space(.)"/>
          </dcterms:creator>

          <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='authorLattes']//*[local-name()='field' and @name='value'][position() = $pos]">
            <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
          </xsl:for-each>

          <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='authorOrcid']//*[local-name()='field' and @name='value'][position() = $pos]">
            <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
          </xsl:for-each>

          <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='authorRid']//*[local-name()='field' and @name='value'][position() = $pos]">
            <vivo:researcherId><xsl:value-of select="normalize-space(.)"/></vivo:researcherId>
          </xsl:for-each>

          <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='authorScopus']//*[local-name()='field' and @name='value'][position() = $pos]">
            <vivo:scopusId><xsl:value-of select="normalize-space(.)"/></vivo:scopusId>
          </xsl:for-each>
        </creator>
      </xsl:for-each>

      <!-- capes:programCode -->
      <xsl:variable name="docType" select="normalize-space((
        $dc/*[local-name()='element' and @name='type']/*[local-name()='field' and @name='value']
        |
        $dc/*[local-name()='element' and @name='type']/*[local-name()='element' and @name='none']/*[local-name()='field' and @name='value']
      )[1])"/>
      <xsl:if test="$docType = 'master thesis' or $docType = 'doctoral thesis'">
        <xsl:variable name="nomeProg" select="normalize-space($dc/*[local-name()='element' and @name='publisher']/*[local-name()='element' and @name='program']//*[local-name()='field' and @name='value'][1])"/>
        <xsl:variable name="progCode" select="normalize-space($dc/*[local-name()='element' and @name='publisher']/*[local-name()='element' and @name='programCode']//*[local-name()='field' and @name='value'][1])"/>
        <xsl:choose>
          <xsl:when test="$nomeProg = 'Doutorado em Engenharia de Alimentos'">
            <capes:programCode>42010012001D1</capes:programCode>
          </xsl:when>
          <xsl:when test="$nomeProg = 'Mestrado em Atenção Integral à Saúde'">
            <capes:programCode>42037018003M1</capes:programCode>
          </xsl:when>
          <xsl:when test="$nomeProg = 'Mestrado em Ecologia'">
            <capes:programCode>42010012004M0</capes:programCode>
          </xsl:when>
          <xsl:when test="$nomeProg = 'Mestrado em Engenharia de Alimentos'">
            <capes:programCode>42010012001M0</capes:programCode>
          </xsl:when>
          <xsl:when test="$nomeProg = 'Mestrado em Tecnologias Sustentáveis'">
            <capes:programCode>42037018003M1</capes:programCode>
          </xsl:when>
          <xsl:when test="$progCode != ''">
            <xsl:for-each select="$dc/*[local-name()='element' and @name='publisher']/*[local-name()='element' and @name='programCode']//*[local-name()='field' and @name='value']">
              <capes:programCode>
                <xsl:value-of select="normalize-space(.)"/>
              </capes:programCode>
            </xsl:for-each>
          </xsl:when>
        </xsl:choose>
      </xsl:if>

      <!-- dcterms:relation -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='relation']//*[local-name()='field' and @name='value']">
        <dcterms:relation><xsl:value-of select="normalize-space(.)"/></dcterms:relation>
      </xsl:for-each>

      <!-- advisor / coAdvisor / committeeMember - dc.contributor.* + virtual metadata -->
      <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor'][1]">

        <xsl:for-each select="*[local-name()='element' and @name='advisor']//*[local-name()='field' and @name='value']">
          <xsl:variable name="pos" select="position()"/>
          <advisor>
            <capes:advisor><xsl:value-of select="normalize-space(.)"/></capes:advisor>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorLattes']//*[local-name()='field' and @name='value'][position() = $pos]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorOrcid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorRid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:researcherId><xsl:value-of select="normalize-space(.)"/></vivo:researcherId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorScopus']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:scopusId><xsl:value-of select="normalize-space(.)"/></vivo:scopusId>
            </xsl:for-each>
          </advisor>
        </xsl:for-each>

        <xsl:for-each select="*[local-name()='element' and @name='advisorco']//*[local-name()='field' and @name='value']">
          <xsl:variable name="pos" select="position()"/>
          <coAdvisor>
            <capes:coAdvisor><xsl:value-of select="normalize-space(.)"/></capes:coAdvisor>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorcoLattes']//*[local-name()='field' and @name='value'][position() = $pos]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorcoOrcid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorcoRid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:researcherId><xsl:value-of select="normalize-space(.)"/></vivo:researcherId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='advisorcoScopus']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:scopusId><xsl:value-of select="normalize-space(.)"/></vivo:scopusId>
            </xsl:for-each>
          </coAdvisor>
        </xsl:for-each>

        <xsl:for-each select="*[local-name()='element' and @name='referee']//*[local-name()='field' and @name='value']">
          <xsl:variable name="pos" select="position()"/>
          <committeeMember>
            <capes:committeeMember><xsl:value-of select="normalize-space(.)"/></capes:committeeMember>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='refereeLattes']//*[local-name()='field' and @name='value'][position() = $pos]">
              <capes:lattesId><xsl:value-of select="normalize-space(.)"/></capes:lattesId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='refereeOrcid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:orcidId><xsl:value-of select="normalize-space(.)"/></vivo:orcidId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='refereeRid']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:researcherId><xsl:value-of select="normalize-space(.)"/></vivo:researcherId>
            </xsl:for-each>

            <xsl:for-each select="$dc/*[local-name()='element' and @name='contributor']/*[local-name()='element' and @name='refereeScopus']//*[local-name()='field' and @name='value'][position() = $pos]">
              <vivo:scopusId><xsl:value-of select="normalize-space(.)"/></vivo:scopusId>
            </xsl:for-each>
          </committeeMember>
        </xsl:for-each>

      </xsl:for-each>

    </oai_capes>
  </xsl:template>

</xsl:stylesheet>

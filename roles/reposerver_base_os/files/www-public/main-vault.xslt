<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" />

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
  
      <link rel="stylesheet" href="/centos-design/css/centos.css" />
      <link rel="stylesheet" href="/centos-design/css/centos-listindex.css" />
  
      <link href="/centos-design/images/favicon.ico" rel="icon" type="image/ico" />

      <link href="https://fonts.googleapis.com/css?family=Exo+2&amp;display=swap" rel="stylesheet" />
  
      <title>CentOS Mirror</title>
    </head>
  
    <body class="d-flex flex-column h-100">
 
    <header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <a class="navbar-brand" href="https://www.centos.org/">
      <img src="http://mirror.centos.org/centos-design/images/centos-logo-white.png" height="32" alt="CentOS" />
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <a class="nav-link" href="https://www.centos.org/download">Download</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            About
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="https://www.centos.org/about/">About CentOS</a>
            <a class="dropdown-item" href="https://wiki.centos.org/FAQ">Frequently Asked Questions (FAQs)</a>
            <a class="dropdown-item" href="https://wiki.centos.org/SpecialInterestGroup">Special Interest Groups (SIGs)</a>
            <a class="dropdown-item" href="https://www.centos.org/variants/">CentOS Variants</a>
            <a class="dropdown-item" href="https://www.centos.org/about/governance/">Governance</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Community
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="https://wiki.centos.org/Contribute">Contribute</a>
            <a class="dropdown-item" href="https://www.centos.org/forums/">Forums</a>
            <a class="dropdown-item" href="https://wiki.centos.org/GettingHelp/ListInfo">Mailing Lists</a>
            <a class="dropdown-item" href="https://wiki.centos.org/irc">IRC</a>
            <a class="dropdown-item" href="https://www.centos.org/community/calendar/">Calendar &amp; IRC Meeting List</a>
            <a class="dropdown-item" href="http://planet.centos.org/">Planet</a>
            <a class="dropdown-item" href="https://bugs.centos.org/">Submit a Bug</a>
            <a class="dropdown-item" href="https://www.centos.org/community/stories/">Stories</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Documentation
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item" href="https://wiki.centos.org/">Wiki</a>
            <a class="dropdown-item" href="https://docs.centos.org/">Manuals</a>
            <a class="dropdown-item" href="https://www.centos.org/keys">GPG Key Info</a>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://wiki.centos.org/Documentation?action=show&amp;redirect=GettingHelp">Help</a>
        </li>
      </ul>
    </div>
    </nav>
    </header>

    <main>
    <div class="container mt-4 mb-4">
    <br/><br/>
    <div class="alert alert-danger" role="alert">
    This is _NOT_ an updated tree for installing CentOS Linux : It is a snapshot of the older trees that have been removed from the main CentOS servers as new point releases are released. <br/>
    This is provided for reference and to provide access to older archived versions, and we do not put security updates into the trees on this server.<br/>
    Please see this <a href="http://www.centos.org/download">link</a> for active versions of CentOS Linux
    </div>
 
  <table id="indexlist">
   <tr class="indexhead"><th class="indexcolicon"><img src="http://mirror.centos.org/icons/blank.gif" alt="[ICO]"/></th><th class="indexcolname"><a href="?C=N;O=D">Name</a></th><th class="indexcollastmod"><a href="?C=M;O=A">Last modified</a></th><th class="indexcolsize"><a href="?C=S;O=A">Size</a></th></tr>
   <tr class="indexbreakrow"><th colspan="4"><hr/></th></tr>

  <xsl:for-each select="list/*">
  <xsl:variable name="filename" select="."/>
  <xsl:variable name="type" select="name(.)"/>
  <tr>
    <td class="indexcolicon">
      <xsl:choose>
        <xsl:when test="$type = 'directory'">
      <img src="http://mirror.centos.org/icons/folder.gif" alt="[DIR]"/>
        </xsl:when>
        <xsl:otherwise>
      <img src="http://mirror.centos.org/icons/unknown.gif" alt="[   ]"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
    <td class="indexcolname">
      <a href="{$filename}">
        <xsl:value-of select="." />
      </a>
    </td>
    <td class="indexcollastmod"> <xsl:value-of select="@mtime" /> </td>
    <td class="indexcolsize"> <xsl:value-of select="@size" /> </td>
  </tr>
  </xsl:for-each>
  <tr class="indexbreakrow"><th colspan="4"><hr/></th></tr>
  </table>

    </div>
    </main>

    <footer class="footer pt-2 bg-light sticky-bottom">
    <div class="container mt-4">
        <p class="text-muted credit text-center">2019 The CentOS Project | <a href="https://www.centos.org/legal/">Legal</a> | <a href="https://www.centos.org/legal/privacy/">Privacy</a></p>
    </div>
    </footer>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 
    </body>
  </html>

  </xsl:template>
</xsl:stylesheet>

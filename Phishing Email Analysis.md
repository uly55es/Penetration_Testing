# Phishing Email Analysis

# Summary

One stop shop for known and suspected phishing email analysis. All tools and links to tools provide open-source analysis capabilities.

# Table of Contents
- [Email Delivery](#email-delivery)
- [Email Headers](#email-headers)
  + [Fields of Interest](#fields-of-interest)
- [Email Body](#email-body)
- [Defang](#defang)
  + [Defanging Hyperlinks and IP Addresses](#defanging-hyperlinks-and-ip-addresses)
  + [CyberChef-Defang URL](#cyberchef-defang-url)
- [Email Analysis](#email-analysis)
  + [Email Header Analysis](#email-header-analysis)
    * [Messageheader](#messageheader)
    * [Message Header Analysis](#message-header-analysis)
    * [Mail Header Analysis](#mail-header-analysis)
  + [Analyze Sender IP Address](#analyze-sender-ip-address)
    * [IPinfo.io](#ipinfo.io)
    * [URLScan.io](#urlscan.io)
    * [URL2PNG](#url2png)
    * [Wannabrowser](#wannabrowser)
    * [Talos Reputation Center](#talos-reputation-center)
  + [Email Body Analysis](#email-body-analysis)
    * [URL Extractor](#url-extractor)
    * [CyberChef-Extract URLs](#cyberchef-extract-urls)
  + [Email Attachement Analysis](#email-attachment-analysis)
    * [Talos File Reputation](#talos-file-reputation)
    * [VirusTotal](#virustotal)
    * [Reversing Labs](#reversing-labs)
  + [Malware Sandbox](#malware-sandbox)
    * [Any.Run](#any.run)
    * [Hybrid Analysis](#hybrid-analysis)
    * [Joe Sandbox](#joe-sandbox)
  + [PhishTool](#phishtool)

## Email Delivery

Three protocols involved in facilitating outgoing and incoming email messages:

> __SMTP (Simple Mail Transfer Protocol)__ - Utilized to handle the sending of emails
> Port 25, Secure Port 465

> __POP3 (Post Office Protocol)__ - Transferring email between a client and a mail server
> Port 110, Secure Port 995

> __IMAP (Internet Message Access Protocol)__ - Transferring email between a client and a mail server
> Port 143, Secure Port 993

![Email Protocols](https://user-images.githubusercontent.com/89045912/178288806-9df2c87a-90e0-4210-ba4d-bd7614bdb634.png)

***

## Email Headers

To parts to an email:
- the email __header__
- the email __body__

Syntax for email messages is known as [Internet Message Format](https://datatracker.ietf.org/doc/html/rfc5322) (IMF)

[Viewing raw/full email headers](https://mediatemple.net/community/products/grid/204644060/how-do-i-view-email-headers-for-a-message)

### Fields of Interest:
1. __X-Originating-IP__ - the IP address of the email was sent from (known as an [X-header](https://help.returnpath.com/hc/en-us/articles/220567127-What-are-X-headers-))
2. __Smtp.mailform/header.from__ - the domain the email was sent from (these headers are within **Authentication-Results**)
3. **Reply-To** - the email address a reply email will be sent to instead of the **From** email address

[How to analyze email headers](https://mediatemple.net/community/products/all/204643950/understanding-an-email-header)

Once email sender's IP address is found, can search at http://www.arin.net/

***

## Defang

#### [Defanging Hyperlinks and IP addresses](https://www.ibm.com/docs/en/rsoa-and-rp/32.0?topic=SSBRUQ_32.0.0/com.ibm.resilient.doc/install/resilient_install_defangURLs.htm)

#### [CyberChef-Defang URL](https://gchq.github.io/CyberChef/)

***

## Email Analysis

From email header:

- [ ] Sender email address
- [ ] Sender IP address
- [ ] Reverse lookup of the sender IP address
- [ ] Email subject line
- [ ] Recipient email address (may be in the CC/BCC field)
- [ ] Reply-to email address (if any)
- [ ] Date/time

From email body:

- [ ] Any URL links (if a URL shortener service was used, then we'll need to obtain the real URL link)
- [ ] The name of the attachment
- [ ] The hash value of the attachment (hash type MD5 or SHA256, preferably latter)

### Email Header Analysis

#### Messageheader
  > Messageheader analyzes SMTP message headers, which help identify the root cause of delivery delays. You can detect misconfigured servers and mail-routing problems
  + https://toolbox.googleapps.com/apps/messageheader/analyzeheader
  + Usage: Copy and paste the entire email header and run the analysis tool

#### [Message Header Analysis](https://mha.azurewebsites.net/)

#### [Mail Header Analysis](https://mailheader.org/)

### Analyze Sender IP Address

#### [IPinfo.io](https://ipinfo.io/)
  > With IPinfo, you can pinpoint your users' locations, customize their experiences, prevent fraud, ensure compliance, and so much more.

#### [URLScan.io](https://urlscan.io/)
  > urlscan.io is a free service to scan and analyze websites. When a URL is submitted, an automated proces will browse to the URL like a regular user and record the activity that this page navigation creates. This includes the domains and IPs contacted, the resources (Javascript, CSS, etc) requested from these domains, as well as additional information about the page itself. It will take a screenshot of the page, record the DOM content, Javascript global variables, cookies created by the page, and a myriad of other observations. If the site is targeting the users of the more than 400 brands tracked by urlscan.io, it will be highlighted as potentially malicious in the scan results.

#### [URL2PNG](https://www.url2png.com/)

#### [Wannabrowser](https://www.wannabrowser.net/)

#### [Talos Reputation Center](https://talosintelligence.com/reputation)

***

### Email Body Analysis

Links can be manually copied for analysis. Some select tools can also aid in this:

#### [URL Extractor](https://www.convertcsv.com/url-extractor.htm)
  + Copy and paste the raw header into the text box

#### [CyberChef-Extract URLs](https://gchq.github.io/CyberChef/)

> Root domain for extracted URLs must be analyzed

Check reputation of URLs and root domain. Refer back to tools in [Analyze Sender IP Address](#analyze-sender-ip-address)

### Email Attachment Analysis

Download file ___without___ opening. Proceed to hash the file.

```bash
user@machine$ sha256sum malicious\ attachment.dot
gfbhgngnjhkmjklio787km6kj6k7657k malicious\ attachment.dot
```

#### [Talos File Reputation](https://talosintelligence.com/talos_file_reputation)
  > The Cisco Talos Intelligence Group maintains a reputation disposition on billions of files. This reputation system is fed into the AMP, Firepower, ClamAV, and Open-Source Snort product lines. The tool allows you to do casual lookups against the Talos File Reputation system. This system limits you to one lookup at a time, and is limited to only hash matching.

#### [VirusTotal](https://www.virustotal.com/gui/)
  > Analyze suspicious files and URLs to detect types of malware, automatically share them with the security community

#### [Reversing Labs](https://register.reversinglabs.com/file_reputation)

### Malware Sandbox

#### [Any.Run](https://app.any.run/)
  > Analyze a network, file, module, and the registry activity. Interact with the OS directly from a browser. See the feeedback from your actions immediately.

#### [Hybrid Analysis](https://www.hybrid-analysis.com/)
  > A free malware analysis service for the community that detects and analyzes unknown threats using a unique Hybrid Analysis technology.

#### [Joe Sandbox](https://www.joesecurity.org/)
  > Joe Sandbox empowers analysts with a large spectrum of product features. Among them: Live interaction, URL Analysis & AI based Phishing Detection, Yara and Sigma rules support, MITRE ATT&CK matrix, AI based malware detection, Mail Monitor, Threat Hunting & Intelligence, Automated User Behavior, Dynamic VBA/JS/JAR instrumentation, Execution Graphs, Localized Internet Anonymization.

### PhishTool

#### [PhishTool](https://www.phishtool.com/)
  > Combines threat intelligence, OSINT, email metadata and battle tested auto-analysis pathways into one powerful phishing response platform.
  + Free community edition available




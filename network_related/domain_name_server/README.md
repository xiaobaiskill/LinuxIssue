# Domain Name Server(網域名稱系統)
網域名稱系統(Domain Name System)，將域名(Domain Name)和IP位址做對應，映射成一個分散式資料庫。

DNS使用TCP和UDP port，目前對於每一級域長度的限制是63個字元，域名總長度不能超過253個字元。開始時，域名的字元僅限於ASCII字元的一個子集。2008年，ICANN通過一項決議，允許使用其他語言作為網際網路頂級域名的字元。使用基於Punycode碼的IDNA系統，可以將Unicode字串對映為有效的DNS字元集。

# 紀錄類型
> 主條目：域名伺服器紀錄類型列表

DNS系統中，常見的資源紀錄類型有：
- 主機紀錄(A紀錄) : RFC 1035定義，A紀錄適用於名稱解析的重要紀錄，他將特定的主機名對映到對應的主機的IP位址上
- 別名紀錄(CNAME紀錄) : RFC 3596定義，與A紀錄對應，用於將特定的主機名對映到一個主機的IPv6位址
- 服務位置紀錄(SRV紀錄) : RFC 2782定義，用於定義提供特定服務的伺服器位置，如主機(hostname)，埠(port number)等
- NAPTR紀錄： RFC 3403定義，它提供了"regular expression"方式去對映一個域名。NAPTR紀錄非常著名的一個應用是用於ENUM查詢
 
# 技術實現
DNS通過允許一個`名稱伺服器`，把他的一部分名稱服務(眾所周知的zone)`委託`給子伺服器而實現了一種階層的名稱空間，`域名`。此外，DNS還提供了一些額外的資訊，例如系統別名(alias)、聯絡資訊以及哪一個主機正在充當系統組或域的郵件樞紐。note:全球目前有984個`根域名伺服器`(分成13組，分別編號為A至M)，餘下的Internet DNS命名空間被委託給其他的DNS伺服器

# 軟體
DNS系統是由各式各樣的DNS軟體所驅動的，例如：
- BIND(Berkeley Internet Name Domain)
- DJBDNS(Dan J Bernstein's DNS implementation)
- MaraDNS
- Name Server Daemon(Name Server Daemon)
- PowerDNS
- Dnsmasq


# refer
https://zh.wikipedia.org/wiki/%E5%9F%9F%E5%90%8D%E7%B3%BB%E7%BB%9F

# DNS overview
By using DSN, you can coonect to website with specified FQDN like example.com

> Recently, the most focused on the relationship between authoritative and recursive DNS

- In Short Sentences
1. recursive DNS is the first query and authoritative DNS is second when answer can't be found in recursive DNS.
2. authoritative DNS is the place where all the root domain name server and answer could be found.


# Recursive DNS Server
Recursive DNS server does by its name-it recursives, which means that it fefer back to itself.
- Recursive DNS nameservers are responsible for providing the proper IP address of the intended domain name to the requesting host.
- Recursive nameservers are like the phone operator looking up a phone number from multiple phone books on behalf of the requesting party(the users' computer on behalf of an application), some phone books will list just last names, then other phone books exist per last name, and list first names.



# Authoritative DNS Nameservers
Authoritative DNS nameservers are responsible providing answers to recursive DNS nameservers with the IP "mapping" of the intended website.
- The authoritative nameservers' responses to the recursive nameservers contain important information DNS records.
- Essentially authoritative nameservers are like the Yellow Page publishing multiple phone books, one per region. Yet they don't actually create the phone book listings-that's the responsibility of domain name registrars.


# Query Flow
1. End-User enter www.google.com in browser, browser look for computer's local dns history.
2. If there is no history about this dns record, computer would send a dns query to a `Recursive DNS NameServer(OpenDNS)` to located the address of the website for end-user.
3. If the DNS record(IP address to FQDN) is not cached in the Recursive DNS nameserver, it will then query the authoritative DNS hierarchy to get the answer.

- Each part of a domain like `www.google.com` has a specific DNS nameserver(or group of redundant nameservers) that is authoritative.
- At the top of the tree are the root domain nameservers. Every domain has an implied/hidden "." at the end that designates the DNS root nameservers at the top of the hierarchy.
- Root domain nameservers know the IP address of the authoritative nameservers that handle DNS queries for the Top Level Domains(TLD) like ".com", ".edu", ".gov". It first asks the root domain nameservers for the IP address of the TLD server, in this case, ".com"(for google.com)
- Afterwards it asks the authoritative server for ".com", where it can find the "google.com" domain's authoritative server. Then "google.com" is asked where to find "www.google.com". Once the IP address is known for the website, the recursive DNS server responds to your computer with the appropriate IP address.

```
                                                |--- `root DNS server`
                                                |
Client Computer-->OpenDNS(recursive DNS server) --- top level domain `DNS server for ".COM"`
                                                |
                                                |--- www.opendns.com `DNS server`
```

# Why does this matter
This post was written to generally point out the differences between the two nameservers.
> However, authoritative DNS outages happen frequently and can be a big problem. But since you are using OpenDNS, in such a case, you have nothing to worry about. OpenDNS uses `SmartCache`, which fixes the inaccessiblity problem and allows people to visit those sites despite the authoritative server outage.


# What Is Authoritative Name Server
An authoritative name server provides actual answer to your DNS queries such as - mail server IP address or web site IP address(A resource record).

It provides original and definitive answers to DNS queries. It does not provides just cached answer that were obtained from another name server.

Therefore it only returns answers to queries about domain names that are installed in its configuration system.

1. Master server(primary name server) - A master server stores the original master copies of all zone records. A hostmaster only make changes to master server zone records. Each slave server gets updates via special automatic updating mechanism of the DNS protocol. All slave servers maintain an identical copy of the master records.
2. Slave server(secondary name server) - A slave server is exact replica of master server. It is used to share DNS server load and to improve DNS zone availability in case master server fails. It is recommend that you should at least have 2 slave servers and one master server for each domain name.

# How To View Authoritative Name Server Names and IP Address
The multiple name servers make sure that the domain still functional even if one name server becomes inaccessible or inoperable due to security or overloading issues. On the internet each domain name assigned a set of authoritative name servers. You can find out authoritative name servers by typing the following command at shell prompt(works with UNIX/ Linux and Mac OS X):
`host -t ns dnsknowledge.com`
```
Sample Outputs:
dnsknowledge.com name server ns2.nixcraft.net.
dnsknowledge.com name server ns3.nixcraft.net.
dnsknowledge.com name server ns1.nixcraft.net.
```
You can also use nslookup command under MS-Windows or UNIX like operationg systems. Type the command:
`nslookup`
Now set query type to ns at > prompt:
`> set query=ns`
Now enter domain name such as google.com or dnsknowledge.com:
`> google.com`
```
Sample Outputs:
> set query=ns
> google.com
Server:         8.8.8.8
Address:        8.8.8.8#53

Non-authoritative answer:
google.com      nameserver = ns1.google.com.
google.com      nameserver = ns3.google.com.
google.com      nameserver = ns2.google.com.
google.com      nameserver = ns4.google.com.

Authoritative answers can be found from:
> exit
```

# Way to Register Authoritative Name Server
1. First, need to register a domain name with domain name registrar.
2. Each domain name registrar should allow users to set a primary name server(master server) and at least one secondary name server(slave server)



# refer
- https://umbrella.cisco.com/blog/2014/07/16/difference-authoritative-recursive-dns-nameservers/
- https://www.dnsknowledge.com/whatis/authoritative-name-server/
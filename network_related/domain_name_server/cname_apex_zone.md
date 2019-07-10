# Use case of zone apex
The use case of wanting a CNAME at a zone apex is typically one where an organization would like to have their web content hosted and provisioning

In which case, they would most likely be using anycast behind the scenes will instead give you a new target name to which they ask you to alias your web server name in your DNS zone
```
通常會使用zone apex的情境是因為使用者想要讓網頁的內容以及配置被某處給託管

通常背後的情境是，他們後面的管理網域是採用anycast做服務管理
```


# What is the zone apex?
The zone apex is where the SOA and NS(and often MX) records for a DNS zone are placed. They are DNS records whose name are the same as the zone itself

```
mydomainname.org.    3600    IN    SOA    dns1.mydomainname.org.
hostmaster.mydomainname.org. 2018073001 7200 3600 24796800 3600
mydomainname.org.    3600    IN    NS    dns1.mydomainname.org.
mydomainname.org.    3600 IN NS dns2.mydomainname.org.
mydomainname.org.    3600 IN MX 10 mail.mydomainname.org.
```

The DNS record type CNAME(Canonical Name) is used for rewriting one name in a zone to another different name(which could be in the same zone, or somewhere else). It's described in RFC 1034 thus:

For example:
> www.mydomainname.org.    3600    IN    CNAME   www.mydomainname.hostingcompany.com

If a recursive resolver receives a client query for www.mydomainname.org, 
it will look up www.mydomainname.org. receive the CNAME response, 
and understand that it now has to look up www.mydomainname.hostingcompany.com too, 
and return the answer to that query to the client.
```
如果有一個DNS resolver嘗試解析www.mydomainname.org，此時會去尋找www.mydomainname.hostingcompany.com然後返回尋找結果
```

The resolver then adds both answers(for www.mydomainname.org and for www.mydomainname.hostingcompany.com) to its cache, in case another client comes to ask the same question.
```
此時DNS resolver會同時返回www.mydomainname.org以及www.mydomainname.hostingcompany.com的結果
```

Many people(mistakenly) believe that the semantics of a CNAME are that the target domain in the RDATA is an alias for the left-hand side(the owner name). 

In fact, this is the wrong way round - a CNAME says that the owner name `is an alias for the target.`
The original concept was to permit the addition of `also known as` names to a zone in DNS, which would then be redirected to the `official`(or `canonical`)name.

Operationally a CNAME record effectively rewrites all other DNS records for that owner name(on the left-hand side) - `for all record types` - to the target name(the RDATA on the right-hand side)

```
ISC BIND9 will therefore not allow you to add a CNAME at the zone apex because this will create zone and cause DNS resolution failures.

The interpretation of the CNAME record(per the DNS protocol)makes it nonsensical to have a CNAME coexisting with any other reocrds for that same name.
```

Nevertheless, it has always been OK to use CNAME for redirection to a web hosting provider where the website is addressed as `www.mydomainname.org`, but CNAME cannot be used where the website is addressed simply as `mydomainname.org` because the zone's NS and SOA(and MX if being used) will also need to exist at that same name.

# Why can't the rules about having a CNAME at the zone apex(or coexisting with the other records) be relaxed and reinterpreted?

When "www" served as a "service identifier" prefix for the host that actually serves the content, using CNAME for redirection to a hosting provider was OK.

It worked as required, even though the semantics weren't really correct.(Mail didn't need a prefix because it always had a special type(i.e. MX) that served as the service identifier).

In more recent times, along with an increase in web server provisioning, itt has also become popular for organizations to expect to have their website accessible simply by their apex DNS domain name - without the "www" prefix.

We cannot change how the special CNAME record is used without changing all of the DNS server implementations in the world at the same time.

This is because its meaning and interpretation was strictly defined in the DNS protocol;

all current DNS client and server implementations adhere to this specification.

Attempting to "relax" how CNAME is used in authoritative servers without simultaneously changing all DNS resolvers currently in operation would cause name resolution to break(and web and email services to become intermittently unavailable for those organizations implementing "relaxed" authoritative server solutions)

# Alternatives
Having now understood why it is not possible to add a CNAME at the zone apex to "make this work", what other alternatives are there? Some suggestions follow:
1. Webserver redirection - set up a webserver for mydomainname.org that provides a web redirect to `www.mydomainname.org`
   1. Pros: This is a very simple solution, and one which leaves the final provisioning in the hands of the web hosting provider.
   2. Cons: This solution requires that a webserver be running for the sole purpose of providing redirection; it will also visibly rewrite the website name in the URL of the client web browser, pre-pending the "www".
   
2. Add A and AAAA records to your zone that are the addresses that the target of the CNAME suggested by the web hosting provider will ultimately resolve to.
   1. Pros: This is a fairly simple workaround to implement.
   2. Cors: If the provider's hosting solution is dynamic, then those addresses may change, possibly quite frequently. You will hve to monitor and regularly update those records(although this is something that could be scripted)

3. For a simple zone that provides nothing to visitors other than the website, consider asking your parent zone's administrators to add the CNAME for your names to their zone directly instead of deldgating it to you to manage.
   1. Pros: This is a very simple workaround to implement.
   2. Cons: This will not work for an organization that has many more names in its DNS zone. It will also not work if the parent zone's adminiatrators don't accept non-delegated records(in other words, hosting your zone recordsd directly instead of delegating them to you). You also cannot implement this as a solution if the domain is also used for mail.

4.  ALIAS or ANAME DNS(non-standard DNS feature). Some DNS hosting providers and DNS server software providers offer "special" record types such as ALIAS or ANAME for a hosted zone. These records are never returned directly to clients. Instead, when a client queries for a name where an ALIAS or ANAME record would be applicable, it follows the redirection and synthesises the A or AAAA record for the client before responding.
    1.  Pros: This is a simple solution to the problem for administrators.
    2.  Cons: This solution is only available if your DNS hosting provider or DNS server software supports. In addition, the need to perform DNS recursion(prior to synthesizing the query response for the client) increases the query response time, as well as adds the potential for authoritative server problems to be introduced if the necessary recursive resolution encounters delays or problems. Authoritative DNS servers, particularly those that are public-facing, do not normally perform any recursive functions. Some DNS hosting providers only permit AALIAS/ANAME records where the redirection target name is also hosted by themselves.

5.  Use the services of a web-hosting provider that allows you to configure IP addresses directly rather than using name redirection.
    1.  Pros: This is a very simple solution that scales well if your web hosting provider is using ancast provisioning.
    2.  Cons: If your chosen web hosting provider does not offer this option, it will not be available to you without changing to another web hosting provider.

6. Another potential solution currently being discussed would add a new DNS resource record type that browsers would look up, that could exist at the apex. This would be an application-specific hostname for http requests(similar to the way MX works).
   1. Pros: This is completely consistent with the DNS design.
   2. Cons: This is not available yet, and would require a browser client update. During a transition to this solution, you would need this to work alongside A and AAAA records, so recursive resolvers would need to send this new record as additional data.

Note: another failing of any solution in which the authoritative server synthesises, or actively monitors and maintains locally, the resolution of the "alias" server address (options 2 and 4), is that that any location-dependent A/AAAA records will be correct per the authoritative server's location, not the end-user's recursive server(resolver) location.

# WARNING
"Clever" provisioning servers that respond with query-dependent CNAME or MX/NS/SOA records will cause broken DNS resolution.

There are some "engineered" solutions available where the servers authoritative for a zone have been made capable of responding with either a CNAME(when queried for A/AAAA and other record types) or the acutal contents of the zone at the apex if queried for MX, NS or SOA records. THis may appear to be a good operational workaround, but it is not.

It is not a good solution because resolvers(following the DNS protocol correctly) will cache what they have learned.

If a client's local DNS resolver does not have anything in cache yet and the client queries for `www.mydomainname.org MX`, the  "engineered" server will provide the expected MX record to the resolver(which will then cache it and retrun it to the client).
So far so good - this time DNS resolution was successful.

But, if earlier, another client had asked for `www.mydomainname.org A`, the "engineered" of server would have provided the CNAME record, and if this was already in cache, then instead of looking up the MX record for the client at `www.mydomainname.org`, the resolver would instead have followed the cached CNAME redirection and tried to look up `www.mydomainname.hostingcompany.com MX`

This is most likely to fail and will result in mail delivery and other intermittent problems.


# refer
- https://www.isc.org/blogs/cname-at-the-apex-of-a-zone/
- https://aws.amazon.com/tw/route53/faqs/
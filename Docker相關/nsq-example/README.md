# nsq tutorial
another queue-manager tool for distribution

# build an env for nsq
> docker-compose up -d

# code example
http://tleyden.github.io/blog/2014/11/12/an-example-of-using-nsq-from-go/

# testing with .go
1. go run consumer.go
    > This would start a goroutine to listen the `topic`: write_test
2. go run producer.go
    > This would produce a message `test` to topic: write_test

# api support for nsq
http://wiki.jikexueyuan.com/project/nsq-guide/nsqd.html

# refer
- official doc: https://nsq.io/deployment/docker.html
- https://pjf.name/blogs/558.html
- https://zhuanlan.zhihu.com/p/37081073
- https://segmentfault.com/a/1190000009194607

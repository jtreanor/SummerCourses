SummerCourses
=============

##The Project
This is my third year team software project (UCC [CS3505/CS3305](http://thing.ucc.ie/cs3305/)).

The code was written by [ChengXi Bao](https://github.com/happlebao) and I. 

It was my first attempt at a rails app and my first time using Ruby. I had lots of fun making it but I'm sure there are plenty of novice mistakes!

##The Brief
Here is a copy of the [project brief](https://github.com/jtreanor/SummerCourses/wiki/Project-Brief).

##Deployment
This rails app is automatically deployed to Heroku on each push to master. The address is: [summercourses.herokuapp.com](https://summercourses.herokuapp.com/).

Primitive deployment logs are [here](http://cs1.ucc.ie/~jct1/git_call).

##Getting it working

This is using [Braintree](https://www.braintreepayments.com/) for payment. To use this you will need environment variables for the following (see config/initializers/braintree.rb):

* `BRAINTREE_MERCHANT_ID`
* `BRAINTREE_PUBLIC_KEY`
* `BRAINTREE_PRIVATE_KEY`

File uploads are using Amazon S3 with Paperclip. I used Mailgun for email. Configuration for these are in production.rb.

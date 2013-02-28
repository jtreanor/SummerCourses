SummerCourses
=============

##Deployment
This rails app is automatically deployed to Heroku on each push to master. The address is: [summercourses.herokuapp.com](https://summercourses.herokuapp.com/).

###Heroku Run
Due to UCC's wireless' very restrictive proxy, heroku commands such as "heroku run rake db:reset" can't be easily run. To get around this, [summercourses.herokuapp.com/heroku](https://summercourses.herokuapp.com/heroku) allows a command such as "rake db:reset" to be run from the browser.
This will be removed in production.


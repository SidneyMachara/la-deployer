# la-Deployer 

[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/)  

Zero-downtime deployment

This is simply a script to help automate deploying a laravel project on a Ubuntu virtual private sever ( VPS ) like Digital Ocean drpolet.

Best for beginners looking to depoly as fast as possible without doing much, Or anyone looking to to avoid repeating the boring cycle of basic web server configuration.

## Show some :heart: and star the repo to support the project



[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/)

## Note
la-deployer does the following:

* sets up LEMP stack  ( php 7.2 )
* guides you on how to setup your laravel project ( uses githook to reduce downtime )


## How to Use 


1. ssh into your server 
  
2. clone the repo into your server
```
git clone https://github.com/SidneyMachara/la-deployer.git
```

3. navigate into la-deployer
```
cd la-deployer
```

4. update file (default ) with your server ip
```
sudo nano default
```
in the file "default" locate server_name 0.0.0.0 and repalce 0.0.0.0 with your server ip address 


5. give the script permision to do its job
```
sudo chmod +x deployer.sh
```

6. run it and watch the magic happen
```
./deployer.sh
```

7. sit back and look out for easy guided steps on the screan


## 👨 Developed By

```
Sidney David  Machara
```


<a href="https://www.linkedin.com/in/david-machara-955a94147/"><img src="https://user-images.githubusercontent.com/35039342/55471530-94b34280-5627-11e9-8c0e-6fe86a8406d6.png" width="60"></a>



# 👍 How to Contribute

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

# 📃 License

    Copyright (c) 2019 Sidney Machara

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Getting Started




## Show some :heart: and star the repo to support the project


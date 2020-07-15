if sudo ls  /myjaky_OS/root/task3/code | grep "index"
then
       file=$(sudo ls /myjaky_OS/root/task3/code | grep "index")
       extension=${file##*.}
       
       if [[ "$extension" == "html" ]]
       then
           if sudo kubectl get all | grep httpd-deploy
           then
                POD=$(sudo kubectl get pod -l type=http -o jsonpath="{.items[0].metadata.name}")
                sudo kubectl cp /myjaky_OS/root/task3/code/index.html $POD:/usr/local/apache2/htdocs/
           else
                sudo kubectl create -f /myjaky_OS/root/task3/ymlFile/html.yml
                POD=$(sudo kubectl get pod -l type=http -o jsonpath="{.items[0].metadata.name}")
                sleep 30
                sudo kubectl cp /myjaky_OS/root/task3/code/index.html $POD:/usr/local/apache2/htdocs/
           fi
       elif [[ "$extension" == "php" ]]
       then
           if sudo kubectl get all | grep php-deploy
           then
                POD=$(sudo kubectl get pod -l type=php -o jsonpath="{.items[0].metadata.name}")
                sudo kubectl cp /myjaky_OS/root/task3/code/index.php $POD:/var/www/html/
           else
                sudo kubectl create -f /myjaky_OS/root/task3/ymlFile/php.yml
                POD=$(sudo kubectl get pod -l type=php -o jsonpath="{.items[0].metadata.name}")
                sleep 30
                sudo kubectl cp /myjaky_OS/root/task3/code/index.php $POD:/var/www/html/
            fi
       else
        	echo "oops Sorry no server available"
            exit 1
       fi
else
    echo "ooopsss No flie name with index is available"
    exit 1
fi

sudo kubectl get all
file=$(sudo ls /myjaky_OS/root/task3/code | grep "index")
status=${file##*.}
code=""
if [[ "$status" == "html" ]]
then
	code=$(sudo curl -o /dev/null -s -w "%{http_code}" http://192.168.99.100:30000/index.html)
else
	code=$(sudo curl -o /dev/null -s -w "%{http_code}" http://192.168.99.100:31000/index.php)
fi


echo $code
if [[ $code == 200 ]]
then
    echo "Congrats App is working fine "
    exit 0
else
    echo "oopss App is not working "
    exit 1
fi

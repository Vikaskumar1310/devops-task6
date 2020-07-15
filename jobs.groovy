job("task6-job1")
{
	description("this Job will clone repo from GitHub and copy code to my os")
	scm {
		github("Vikaskumar1310/devops-task6","master")
	}
	triggers {
		scm("* * * * *")
	}
	steps{
		shell("""
		sudo mkdir -p /myjaky_OS/root/task6
		sudo cp -v * /myjaky_OS/root/task6
		sudo rm -f * 
                """)
	}
}

job("task6-job2")
{
       description("this job launch the webserver")
       triggers {
              upstream("task6-job1","SUCCESS")
        }
        steps {
               shell("sh /myjaky_OS/root/task6/job2.sh")
        }
}

job("task6-job3")
{
       description("this job test the webpage according to the lang and send the mail to developer if any code fails")
       triggers {
              upstream("task6-job2","SUCCESS")
        }
        steps {
               shell("sh /myjaky_OS/root/task6/job3.sh")
        }
        publishers {
                   mailer('vkk1310@gmail.com',false,false)
        }
}
buildPipelineView("devops-task6"){
        filterBuildQueue()
        filterExecutors()
        title("task6-build-pipeline")
        displayedBuilds(3)
        selectedJob("task6-job1")
        alwaysAllowManualTrigger()
        showPipelineParameters()
        refreshFrequency(30)
}







job('packt') {
  logRotator(3, 5)
  triggers {
        cron('0 4 * * *')
    }
  
  wrappers {
      timestamps()
  }
  
  steps{
    gradle {
      useWrapper(false)
      buildFile '/var/lib/jenkins/Packt/build.gradle'
      tasks 'get'
    }
  }
}

job('booker') {
  logRotator(5, 5)
  
  wrappers {
      timestamps()
  }
  
  steps{
    gradle {
      useWrapper(false)
      buildFile '/var/lib/jenkins/Booker/build.gradle'
      tasks 'run'
    }
  }
  /*publishers {
    downstreamParameterized {
      trigger('reload_docker'){
        condition('ALWAYS')
        triggerWithNoParameters(true)
      }
    }
  }*/
  
}

job('reload_docker') {
  logRotator(5, 5)
  steps{
    shell('docker rm -vf grid || exit 0')
    shell('docker pull elgalu/selenium')
    shell('docker run -d --name=grid -p 4444:24444 -p 5900:25900 -e TZ="US/Pacific" --shm-size=1g elgalu/selenium')
    shell('docker exec grid wait_all_done 30s')
  }
}

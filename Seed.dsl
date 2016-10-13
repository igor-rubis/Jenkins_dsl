job('packt') {
  logRotator(3, 5)
  triggers {
        cron('0 4 * * *')
    }
  
  steps{
    gradle {
      useWrapper(false)
      buildFile '/var/lib/jenkins/Packt/build.gradle'
      tasks 'get'
    }
  }
  
  publishers {
    downstreamParameterized {
      trigger('reload_docker'){
        condition('UNSTABLE_OR_WORSE')
        triggerWithNoParameters(true)
      }
    }
  }
}

job('booker') {
  logRotator(5, 10)
  
  steps{
    gradle {
      useWrapper(false)
      buildFile '/var/lib/jenkins/Booker/build.gradle'
      tasks 'run'
    }
  }
  
  publishers {
    downstreamParameterized {
      trigger('reload_docker'){
        condition('ALWAYS')
        triggerWithNoParameters(true)
      }
    }
  }
}

job('reload_docker') {
  logRotator(5, 5)
  steps{
    shell('docker rm -vf grid')
    shell('docker pull elgalu/selenium')
    shell('''docker run -d --name=grid -p 4444:24444 -p 5900:25900 \
    --shm-size=1g -e VNC_PASSWORD=hola \
    -e MAX_INSTANCES=3 -e MAX_SESSIONS=3 \
    elgalu/selenium''')
    shell('docker exec grid wait_all_done 30s')
  }
}

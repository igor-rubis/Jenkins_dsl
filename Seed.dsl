job('packt') {
  jdk('Oracle_Java_8')
  
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
}

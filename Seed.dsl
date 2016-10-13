job('packt') {
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

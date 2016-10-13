job('packt') {
  logRotator(5, 5)
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

job('booker') {
  logRotator(5, 5)
  
  steps{
    gradle {
      useWrapper(false)
      buildFile '/var/lib/jenkins/Booker/build.gradle'
      tasks 'run'
    }
  }
}

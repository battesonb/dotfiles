case `uname` in
  Darwin)
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home/
  ;;
  Linux)
    export JAVA_HOME=/usr/lib/jvm/java-openjdk/
  ;;
esac

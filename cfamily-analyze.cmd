
sonar-scanner ^
    -e ^
    -Dsonar.verbose=true ^
    -Dsonar.host.url=%SONAR_HOST_URL% ^
    -Dsonar.login=%SONAR_AUTH_TOKEN% ^
    -Dsonar.cfamily.build-wrapper-output=cfamily-compilation-database ^
    -Dsonar.projectKey="c-family:reactos-windows" ^
    -Dsonar.projectName="ReactOS Windows" ^
    -Dsonar.projectVersion=latest ^
    -Dsonar.sourceEncoding=UTF-8 ^
    -Dsonar.sources=. ^
    -Dsonar.inclusions=**/*.c,**/*.cc,**/*.cpp,**/*.cxx,**/*.h,**/*.hh ^
    -Dsonar.scm.disabled=true ^
    -Dsonar.cpd.exclusions=**

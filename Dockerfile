#FROM openjdk:8-jdk-alpine
#ARG JAR_FILE=target/*.jar
#
#VOLUME /tmp
#COPY . /tmp
#COPY covidreports covidreports
#COPY ${JAR_FILE} app.jar
#
#ENTRYPOINT ["java","-jar","/app.jar"]

# -----------

# used to run Maven and build the fat jar, then unpack it.
FROM openjdk:8-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod 777 mvnw
RUN ./mvnw dependency:go-offline

COPY src src
COPY covidreports covidreports

RUN ./mvnw clean install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

# ###########

FROM openjdk:8-jdk-alpine
VOLUME /tmp

ARG DEPENDENCY=/workspace/app/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","com.hust.baseweb.BasewebApplication"]
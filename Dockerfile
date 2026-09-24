FROM docker.m.opsbox.dev/seanly/toolset:openjdk-8-2 AS build

COPY ./ /code/

WORKDIR /code

RUN <<EOF

cd /code/publiccms-parent/
bash ./mvnw clean package -DskipTests

EOF

FROM docker.m.opsbox.dev/seanly/toolset:openjdk-8-2
COPY --from=build /code/publiccms-parent/publiccms/target/publiccms.war /opt/publiccms.war
COPY --from=build /code/data /data
ENV PORT 8080
ENV CONTEXTPATH ""
ENV FILEPATH  "/data/publiccms"

VOLUME $FILEPATH
EXPOSE $PORT

ENTRYPOINT java -jar -Dcms.port=$PORT -Dcms.contextPath=$CONTEXTPATH -Dcms.filePath=$FILEPATH /opt/publiccms.war

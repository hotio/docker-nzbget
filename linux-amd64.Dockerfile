FROM hotio/base@sha256:047c65b9a204d6936c5aaa69e085cad72bc15bd9df9c582de7fd94c2470a7daa

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
ARG VERSION_SHORT
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION_SHORT}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    chown -R root:root "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*

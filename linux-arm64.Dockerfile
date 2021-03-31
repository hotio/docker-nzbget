FROM hotio/base@sha256:ee86e69c172066a6f7b98e742eaad46c4717f687ba22bb532f140500d589472d

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

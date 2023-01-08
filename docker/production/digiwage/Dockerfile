FROM i_swapclient as install_stage

RUN basicswap-prepare --preparebinonly --bindir=/coin_bin --withcoin=digiwage --withoutcoins=particl && \
    find /coin_bin -name *.tar.gz -delete

FROM debian:bullseye-slim
COPY --from=install_stage /coin_bin .

ENV DIGIWAGE_DATA /data

RUN groupadd -r digiwage && useradd -r -m -g digiwage digiwage \
    && apt-get update \
    && apt-get install -qq --no-install-recommends gosu \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir "$WAGE_DATA" \
    && chown -R digiwage:digiwage "$DIGIWAGE_DATA" \
    && ln -sfn "$DIGIWAGE_DATA" /home/digiwage/.digiwage \
    && chown -h digiwage:digiwage /home/digiwage/.digiwage
VOLUME /data

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 46002 46003
CMD ["/digiwage/digiwaged", "--datadir=/data"]

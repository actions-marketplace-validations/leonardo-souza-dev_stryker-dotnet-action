FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["ls"]

ENTRYPOINT ["bash", "entrypoint.sh"]
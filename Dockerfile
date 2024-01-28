FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

COPY FiatClient/. /app/

WORKDIR /app/

RUN dotnet publish --configuration Release --self-contained -o build/


RUN ls -ltrh /app/build/

FROM alpine:3

RUN apk add icu-libs
RUN apk add icu

COPY --from=build /app/build/ /build/.

LABEL org.opencontainers.image.source https://github.com/mathroc/FiatChamp

WORKDIR /build/

CMD [ "/build/FiatChamp" ]

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY InfoTrack.Demos.Composite.Composer/InfoTrack.Demos.Composite.Composer.csproj InfoTrack.Demos.Composite.Composer/
RUN dotnet restore InfoTrack.Demos.Composite.Composer/InfoTrack.Demos.Composite.Composer.csproj
COPY . .
WORKDIR /src/InfoTrack.Demos.Composite.Composer
RUN dotnet build InfoTrack.Demos.Composite.Composer.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish InfoTrack.Demos.Composite.Composer.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "InfoTrack.Demos.Composite.Composer.dll"]

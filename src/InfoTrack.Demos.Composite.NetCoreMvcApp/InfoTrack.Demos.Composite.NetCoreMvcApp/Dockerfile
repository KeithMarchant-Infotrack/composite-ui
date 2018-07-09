FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY InfoTrack.Demos.Composite.NetCoreMvcApp/InfoTrack.Demos.Composite.NetCoreMvcApp.csproj InfoTrack.Demos.Composite.NetCoreMvcApp/
RUN dotnet restore InfoTrack.Demos.Composite.NetCoreMvcApp/InfoTrack.Demos.Composite.NetCoreMvcApp.csproj
COPY . .
WORKDIR /src/InfoTrack.Demos.Composite.NetCoreMvcApp
RUN dotnet build InfoTrack.Demos.Composite.NetCoreMvcApp.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish InfoTrack.Demos.Composite.NetCoreMvcApp.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "InfoTrack.Demos.Composite.NetCoreMvcApp.dll"]
